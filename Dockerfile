FROM alpine:edge

RUN apk update && \
    apk add --no-cache ca-certificates caddy tor wget npm screen && \
    rm -rf /var/cache/apk/*
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \    
    && apk add --no-cache openssh tzdata \
    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && sed -i "s/#PermitRootLogin.*/PermitRootLogin yes/g" /etc/ssh/sshd_config \
    && ssh-keygen -t dsa -P "" -f /etc/ssh/ssh_host_dsa_key \
    && ssh-keygen -t rsa -P "" -f /etc/ssh/ssh_host_rsa_key \ 
    && ssh-keygen -t ecdsa -P "" -f /etc/ssh/ssh_host_ecdsa_key \
    && ssh-keygen -t ed25519 -P "" -f /etc/ssh/ssh_host_ed25519_key \
    && echo "root:netcyroot" | chpasswd
RUN cd ~ && npm install -g wstunnel
ADD start.sh /start.sh
RUN chmod +x /start.sh

CMD /start.sh