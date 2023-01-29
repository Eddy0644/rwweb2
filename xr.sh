#/bin/bash
cd ~
wget -qO- https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip | busybox unzip - 
chmod +x ~/xray
screen -S xray ~/xray -config /xray.json
