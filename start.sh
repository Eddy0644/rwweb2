#!/bin/sh

# configs
AUUID=ac5fbb44-cead-406d-a170-5146490b1a70
CADDYIndexPage=https://ja.xjqxz.top/myrailwayweb.zip
CONFIGCADDY=https://raw.githubusercontent.com/netcyabc/rwweb2/main/etc/Caddyfile

CONFIGXRAY=https://raw.githubusercontent.com/netcyabc/rwweb2/main/etc/xray.json
ParameterSSENCYPT=chacha20-ietf-poly1305
StoreFiles=https://raw.githubusercontent.com/netcyabc/rwweb2/main/etc/StoreFiles
#PORT=4433
mkdir -p /etc/caddy/ /usr/share/caddy && echo -e "User-agent: *\nDisallow: /" >/usr/share/caddy/robots.txt
wget $CADDYIndexPage -O /usr/share/caddy/index.html && unzip -qo /usr/share/caddy/index.html -d /usr/share/caddy/ && mv /usr/share/caddy/*/* /usr/share/caddy/
wget -qO- $CONFIGCADDY | sed -e "1c :$PORT" -e "s/\$AUUID/$AUUID/g" -e "s/\$MYUUID-HASH/$(caddy hash-password --plaintext $AUUID)/g" >/etc/caddy/Caddyfile
wget -qO- $CONFIGXRAY | sed -e "s/\$AUUID/$AUUID/g" -e "s/\$ParameterSSENCYPT/$ParameterSSENCYPT/g" >/xray.json

# storefiles
# mkdir -p /usr/share/caddy/$AUUID && wget -O /usr/share/caddy/$AUUID/StoreFiles $StoreFiles
# wget -P /usr/share/caddy/$AUUID -i /usr/share/caddy/$AUUID/StoreFiles

# for file in $(ls /usr/share/caddy/$AUUID); do
#     [[ "$file" != "StoreFiles" ]] && echo \<a href=\""$file"\" download\>$file\<\/a\>\<br\> >>/usr/share/caddy/$AUUID/ClickToDownloadStoreFiles.html
# done

screen -dmS tor tor
screen -dmS xray /xray -config /xray.json
screen -dmS sshd /usr/sbin/sshd
screen -dmS wstunnel wstunnel -s 0.0.0.0:8989 &
screen -dmS caddy caddy run --config /etc/caddy/Caddyfile --adapter caddyfile
# tor &
# echo --tor-----xray--
# /xray -config /xray.json &
# echo -----sshd
# /usr/sbin/sshd &
# echo -----wstunnel
# wstunnel -s 0.0.0.0:8989 &
# echo -----caddy
# caddy run --config /etc/caddy/Caddyfile --adapter caddyfile
