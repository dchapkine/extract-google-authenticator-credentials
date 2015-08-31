#!/bin/bash

while true ;
do

	./genhtml.sh data/dump.csv | nc -l -p 2001

done