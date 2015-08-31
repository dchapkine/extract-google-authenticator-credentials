#!/bin/bash

mkdir -p ./data && echo ".schema accounts" | sqlite3 ./data/databases > ./data/schema.txt && echo "select * from accounts;" | sqlite3 -separator ';' ./data/databases > ./data/dump.csv