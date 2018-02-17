#!/bin/bash

mkdir -p ./data && adb pull /sdcard/databases && mv databases data/databases
