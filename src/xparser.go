package main

import (
	"flag"
	"fmt"
	"github.com/opesun/goquery"
	"io"
	"os"
	"os/signal"
	"strings"
	"time"
	//Пакеты, которые пригодятся для работы с файлами и сигналами:

	//А вот эти - для высчитывания хешей:
	"crypto/md5"
	"encoding/hex"
)

var (
	WORKERS       int             = 2                     //кол-во "потоков"
	REPORT_PERIOD int             = 10                    //частота отчетов (сек)
	DUP_TO_STOP   int             = 500                   //максимум повторов до останова
	HASH_FILE     string          = "hash.bin"            //файл с хешами
	QUOTES_FILE   string          = "quotes.txt"          //файл с цитатами
	used          map[string]bool = make(map[string]bool) //map в котором в качестве ключей будем использовать строки, а для значений - булев тип.
)

func init() {
	//Задаем правила разбора:
	flag.IntVar(&WORKERS, "w", WORKERS, "количество потоков")
	flag.IntVar(&REPORT_PERIOD, "r", REPORT_PERIOD, "частота отчетов (сек)")
	flag.IntVar(&DUP_TO_STOP, "d", DUP_TO_STOP, "кол-во дубликатов для остановки")
	flag.StringVar(&HASH_FILE, "hf", HASH_FILE, "файл хешей")
	flag.StringVar(&QUOTES_FILE, "qf", QUOTES_FILE, "файл записей")
	//И запускаем разбор аргументов
	flag.Parse()
}

func grab() <-chan string { //функция вернет канал, из которого мы будем читать данные типа string
	c := make(chan string)
	for i := 0; i < WORKERS; i++ { //в цикле создадим нужное нам количество гоурутин - worker'oв
		go func() {
			for { //в вечном цикле собираем данные
				query := make(map[string]string)
				query["for"] = "война+в+украине"
				query["hl"] = "ru"
				query["gl"] = "UA"
				query["ceid"] = "UA%3Aru"
				// https://news.google.com/search?for=%B0+%D0%B2+%D1%8&hl=ru&gl=UA&ceid=UA%3Aru
				url := fmt.Sprintf("https://news.google.com/search?for=%s&hl=%s&gl=%s&ceid=%s",
					query["for"], query["hl"], query["gl"], query["ceid"])
				x, err := goquery.ParseUrl(url)
				// bb := x.Find("div.[\"NiLAwe\", \"y6IFtc\", R7GTQ keNKEd j7vNaf nID9nc\"]")
				//bb := x.Find("div[class=\"NiLAwe y6IFtc R7GTQ keNKEd j7vNaf nID9nc\"]")
				bb := x.Find(".NiLAwe.y6IFtc.R7GTQ.keNKEd.j7vNaf.nID9nc") // NiLAwe y6IFtc R7GTQ keNKEd j7vNaf nID9nc\"]")
				bb.Each(func(index int, element *goquery.Node) {
					print(index)
				})
				if err == nil {
					if s := strings.TrimSpace(x.Find(".fi_text").Text()); s != "" {
						c <- s //и отправляем их в канал
					}
				}
				time.Sleep(100 * time.Millisecond)
			}
		}()
	}
	fmt.Println("Запущено потоков: ", WORKERS)
	return c
}

func check(e error) {
	if e != nil {
		panic(e)
	}
}

func readHashes() {
	//проверим файл на наличие
	if _, err := os.Stat(HASH_FILE); err != nil {
		if os.IsNotExist(err) {
			fmt.Println("Файл хешей не найден, будет создан новый.")
			return
		}
	}

	fmt.Println("Чтение хешей...")
	hash_file, err := os.OpenFile(HASH_FILE, os.O_RDONLY, 0666)
	check(err)
	defer hash_file.Close()
	//читать будем блоками по 16 байт - как раз один хеш:
	data := make([]byte, 16)
	for {
		n, err := hash_file.Read(data) //n вернет количество прочитанных байт, а err - ошибку, в случае таковой.
		if err != nil {
			if err == io.EOF {
				break
			}
			panic(err)
		}
		if n == 16 {
			used[hex.EncodeToString(data)] = true
		}
	}

	fmt.Println("Завершено. Прочитано хешей: ", len(used))
}

func main() {
	readHashes()
	//Открываем файл с цитатами...
	quotesFile, err := os.OpenFile(QUOTES_FILE, os.O_APPEND|os.O_CREATE, 0666)
	check(err)
	defer quotesFile.Close()

	//...и файл с хешами
	hashFile, err := os.OpenFile(HASH_FILE, os.O_APPEND|os.O_CREATE, 0666)
	check(err)
	defer hashFile.Close()

	//Создаем Ticker который будет оповещать нас когда пора отчитываться о работе
	ticker := time.NewTicker(time.Duration(REPORT_PERIOD) * time.Second)
	defer ticker.Stop()

	//Создаем канал, который будет ловить сигнал завершения, и привязываем к нему нотификатор...
	keyChan := make(chan os.Signal, 1)
	signal.Notify(keyChan, os.Interrupt)

	//...и все что нужно для подсчета хешей
	hashes := md5.New()

	//Счетчики цитат и дубликатов
	quotesCount, dupCount := 0, 0

	//Все готово, поехали!
	quotesChan := grab()
	for {
		select {
		case quote := <-quotesChan: //если "пришла" новая цитата:
			quotesCount++
			//считаем хеш, и конвертируем его в строку:
			hashes.Reset()
			io.WriteString(hashes, quote)
			hash := hashes.Sum(nil)
			hashString := hex.EncodeToString(hash)
			//проверяем уникальность хеша цитаты
			if !used[hashString] {
				//все в порядке - заносим хеш в хранилище, и записываем его и цитату в файлы
				used[hashString] = true
				hashFile.Write(hash)
				quotesFile.WriteString(quote + "\n\n\n")
				dupCount = 0
			} else {
				//получен повтор - пришло время проверить, не пора ли закругляться?
				if dupCount++; dupCount == DUP_TO_STOP {
					fmt.Println("Достигнут предел повторов, завершаю работу. Всего записей: ", len(used))
					return
				}
			}
		case <-keyChan: //если пришла информация от нотификатора сигналов:
			fmt.Println("CTRL-C: Завершаю работу. Всего записей: ", len(used))
			return
		case <-ticker.C: //и, наконец, проверяем не пора ли вывести очередной отчет
			fmt.Printf("Всего %d / Повторов %d (%d записей/сек) \n", len(used), dupCount, quotesCount/REPORT_PERIOD)
			quotesCount = 0
		}
	}
}
