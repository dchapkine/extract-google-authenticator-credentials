#!/bin/bash

echo "Choose which Authenticator app runs on your old phone"
echo "1. Google Authenticator"
echo "2. LastPass Authenticator"
read -p "Your choice: " choice

mkdir -p ./data
echo ".schema accounts" | sqlite3 ./data/databases > ./data/schema.txt

if [ "$choice" -eq 1 ]
then
    echo "Dumping the db for Google Authenticator"
    echo "select * from accounts;" | sqlite3 -separator ';' ./data/databases > ./data/dump.csv

    echo "Open http://127.0.0.1:2001 on your browser and scan the QR codes on your new phone"
    while True;
    do
        ./genhtml_google.sh data/dump.csv | nc -l -p 2001
    done

elif [ "$choice" -eq 2 ]
then
    echo "Dumping the db for LastPass Authenticator"
    echo "select * from accounts;" | sqlite3 -separator '|' ./data/databases > ./data/dump.csv

    echo "Open http://127.0.0.1:2001 on your browser and scan the QR codes on your new phone"
    while True;
    do
        ./genhtml_lastpass.sh data/dump.csv | nc -l -p 2001
    done
else
    echo "Invalid option. Exiting"
    exit
fi

