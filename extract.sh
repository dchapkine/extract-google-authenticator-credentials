#!/bin/bash

mkdir -p ./data && adb pull /data/data/com.google.android.apps.authenticator2/databases/databases && mv databases data/databases