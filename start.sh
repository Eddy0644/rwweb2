#!/bin/sh

AUUID=ac5fbb44-cead-406d-a170-5146490b1a70
CADDYIndexPage=http://nc32.top/myrwweb.zip
CONFIGCADDY=https://raw.githubusercontent.com/netcyabc/rwweb2/okteto/etc/Caddyfile
CONFIGXRAY=https://raw.githubusercontent.com/netcyabc/rwweb2/okteto/etc/xray.json
ParameterSSENCYPT=chacha20-ietf-poly1305
StoreFiles=https://raw.githubusercontent.com/netcyabc/rwweb2/okteto/etc/StoreFiles
mkdir -p /etc/caddy/ /usr/share/caddy && echo -e "User-agent: *\nDisallow: /" >/usr/share/caddy/robots.txt
wget $CADDYIndexPage -O /usr/share/caddy/index.html && unzip -qo /usr/share/caddy/index.html -d /usr/share/caddy/ && mv /usr/share/caddy/*/* /usr/share/caddy/
wget -qO- $CONFIGCADDY | sed -e "1c :8443" -e "s/\$AUUID/$AUUID/g" -e "s/\$MYUUID-HASH/$(caddy hash-password --plaintext $AUUID)/g" >/etc/caddy/Caddyfile
wget -qO- $CONFIGXRAY | sed -e "s/\$AUUID/$AUUID/g" -e "s/\$ParameterSSENCYPT/$ParameterSSENCYPT/g" >/xray.json

screen -dmS tor tor
#screen -dmS xray /xray -config /xray.json
#screen -dmS sshd /usr/sbin/sshd
/usr/sbin/sshd &
wstunnel -s 0.0.0.0:8989 &
#caddy fmt --config /etc/caddy/Caddyfile > /etc/caddy/Caddyfile
caddy run --config /etc/caddy/Caddyfile --adapter caddyfile
