FROM python:3.9-slim-bullseye
MAINTAINER examples@docker.com
RUN apt-get update && apt-get install -y openssh-server supervisor gcc libpq-dev
RUN mkdir -p /var/log/supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD . /app
WORKDIR /app
RUN python -m venv ./venv
RUN . /app/venv/bin/activate && pip3 install --upgrade pip
RUN . /app/venv/bin/activate && pip3 install --upgrade psycopg2-binary
RUN . /app/venv/bin/activate && pip3 install --no-cache-dir -r requirements.txt

EXPOSE 22
CMD ["/usr/bin/supervisord"]