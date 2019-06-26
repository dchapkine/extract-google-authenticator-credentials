#!/bin/bash

echo -e "HTTP/1.1 200 OK\r\n\
$(date)\r\n\
Content-Type: text/html\r\n\
\r\n";

cat ./templates/header.html

OLDIFS=$IFS
IFS=";"

while read _id email secret counter type provider issuer original_name
 do

	if [ "$type" == "1" ]; then
		url="otpauth://hotp/"$email"?secret="$secret"&issuer="$issuer"&counter="$counter;
	else
		url="otpauth://totp/"$email"?secret="$secret"&issuer="$issuer;
	fi
	echo '<div class="qrcode">'
	echo '<div class="title">'$email'</div>'
	echo '<div class="code" id="__qrcode__'$_id'"></div>'
	echo '<script>'
	echo '	new QRCode(document.getElementById("__qrcode__'$_id'"), "'$url'");'
	echo '</script>'
	echo '</div>'

    #echo -e "$_id \
    #======================\n\
    #Type: \t $type\n\
    #Email :\t $email\n\
    #Secret :\t $secret\n\
    #Issuer :\t $issuer\n\
    #Counter:\t $counter\n\
    #Url:\t $url\n\
    #\n"

 done < $1
 IFS=$OLDIFS


cat ./templates/footer.html
