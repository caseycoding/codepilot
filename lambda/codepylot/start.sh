#!/usr/bin/env bash

pip install -r requirements.txt

watchmedo auto-restart \
 --patterns="*.py;" \
 --ignore-directories \
 --recursive \
 -- chalice local --host 0.0.0.0 --port 9000