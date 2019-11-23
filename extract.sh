#!/bin/bash
echo -e "Requires root access to \"Shell\" (com.android.shell). \n Depending on setup, this could be done through Magisk Manager Superuser tab .\nCheck phone for Superuser prompt\nAttemping to extract SQLite schema from application local storage..." && 
mkdir -p ./data &&
adb shell "su -c echo \"'.schema accounts' | sqlite3 /data/data/com.google.android.apps.authenticator2/databases/databases >> /sdcard/gaeschema.txt\"" &&
adb pull /sdcard/gaeschema.txt &&
adb shell "su -c rm /sdcard/gaeschema.txt" && 
mv gaeschema.txt data/schema.txt &&
echo "Attempting to dump SQLite accounts table from application local storage..." &&
adb shell "su -c echo \"'SELECT * from accounts;' | sqlite3 -separator ';' /data/data/com.google.android.apps.authenticator2/databases/databases >> /sdcard/gaedump.csv\"" &&
adb pull /sdcard/gaedump.csv &&
adb shell "su -c rm /sdcard/gaedump.csv" && 
mv gaedump.csv data/dump.csv
