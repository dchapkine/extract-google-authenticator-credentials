#!/bin/bash

trap ctrl_c INT

function ctrl_c() {
        echo "Removing extracted credentials..."
	./clean.sh
	echo "Credentials removed."
	exit
}

echo "View QR codes in webbrowser at http://localhost:2001"
echo "Press CTRL-C to exit and remove extracted credentials"

while true ;
do
	./genhtml.sh data/dump.csv | nc -l 2001

done