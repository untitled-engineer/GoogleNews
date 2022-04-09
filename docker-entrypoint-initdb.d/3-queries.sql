--
-- PostgreSQL database dump
--

-- Dumped from database version 14.2
-- Dumped by pg_dump version 14.2

-- Started on 2022-03-31 05:10:26 EEST

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 213 (class 1259 OID 16410)
-- Name: queries; Type: TABLE; Schema: search_results; Owner: postgres
--

CREATE TABLE search_results.queries (
    id integer NOT NULL,
    query text,
    ref_language_id smallint,
    ref_topic_id bigint
);


ALTER TABLE search_results.queries OWNER TO postgres;

--
-- TOC entry 212 (class 1259 OID 16409)
-- Name: keywords_id_seq; Type: SEQUENCE; Schema: search_results; Owner: postgres
--

CREATE SEQUENCE search_results.keywords_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE search_results.keywords_id_seq OWNER TO postgres;

--
-- TOC entry 3593 (class 0 OID 0)
-- Dependencies: 212
-- Name: keywords_id_seq; Type: SEQUENCE OWNED BY; Schema: search_results; Owner: postgres
--

ALTER SEQUENCE search_results.keywords_id_seq OWNED BY search_results.queries.id;


--
-- TOC entry 3444 (class 2604 OID 16413)
-- Name: queries id; Type: DEFAULT; Schema: search_results; Owner: postgres
--

ALTER TABLE ONLY search_results.queries ALTER COLUMN id SET DEFAULT nextval('search_results.keywords_id_seq'::regclass);


--
-- TOC entry 3587 (class 0 OID 16410)
-- Dependencies: 213
-- Data for Name: queries; Type: TABLE DATA; Schema: search_results; Owner: postgres
--

COPY search_results.queries (id, query, ref_language_id, ref_topic_id) FROM stdin;
1	Україна	1	\N
2	Росія	1	\N
4	Ukraine	4	\N
5	War in Ukraine	4	\N
6	Украина	2	\N
7	Владимир Зеленский	3	\N
8	Володимир Зеленський	1	\N
9	Владимир Путин	3	\N
10	Володимир Путін	1	\N
11	vladimir putin	4	\N
12	Volodymyr Zelenskyy	4	\N
13	War in Ukraine	5	\N
3	Вторжение России на Украину	3	\N
14	Російське вторгнення в Україну	1	\N
\.


--
-- TOC entry 3594 (class 0 OID 0)
-- Dependencies: 212
-- Name: keywords_id_seq; Type: SEQUENCE SET; Schema: search_results; Owner: postgres
--

SELECT pg_catalog.setval('search_results.keywords_id_seq', 1, false);


--
-- TOC entry 3446 (class 2606 OID 16417)
-- Name: queries keywords_pkey; Type: CONSTRAINT; Schema: search_results; Owner: postgres
--

ALTER TABLE ONLY search_results.queries
    ADD CONSTRAINT keywords_pkey PRIMARY KEY (id);


-- Completed on 2022-03-31 05:10:28 EEST

--
-- PostgreSQL database dump complete
--

