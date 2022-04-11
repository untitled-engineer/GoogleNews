# Start from golang base image
FROM golang:buster

# Add Maintainer info
LABEL maintainer="example"
MAINTAINER examples@docker.com

# Install git.
# Git is required for fetching the dependencies.
RUN apt-get update && apt-get install -y git bash build-essential libpq-dev
RUN apt-get install -y python3 python3-dev python3-pip python3-psycopg2 supervisor

RUN mkdir -p /var/log/supervisor
RUN mkdir -p /var/log/app

RUN mkdir /app
WORKDIR /app

COPY . /app
COPY .env .

RUN . /app/venv/bin/activate && pip3 install --upgrade pip
RUN . /app/venv/bin/activate && pip3 install --upgrade psycopg2-binary
RUN . /app/venv/bin/activate && pip3 install --no-cache-dir -r requirements.txt

EXPOSE 22
CMD ["/usr/bin/supervisord"]