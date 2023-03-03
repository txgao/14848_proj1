#!/bin/bash

FROM --platform=linux/amd64 python:3

COPY . /usr/src/app
WORKDIR /usr/src/app

RUN apt-get update -y 
RUN apt-get install -y python3-pip python-dev

RUN pip install --no-cache-dir -r requirements.txt

RUN apt-get update -y 


EXPOSE 8888
CMD ["python", "app.py"]
