#!/bin/sh
redis-server &
python crawler.py
python joogle_search.py