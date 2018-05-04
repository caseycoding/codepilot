FROM python:3-alpine

RUN apk add -U wget bash tzdata build-base libffi-dev openssl-dev

RUN echo "http://dl-8.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories

ENV TZ=America/Chicago

# Clean APK cache
RUN rm -rf /var/cache/apk/*

COPY requirements.txt /tmp/requirements.txt
RUN pip install -r /tmp/requirements.txt