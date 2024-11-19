FROM debian:latest

WORKDIR /app

COPY ./server/mini_server.c /app/mini_server.c
COPY ./run.sh /app/run.sh

RUN groupadd -r nginx && \
    useradd -r -g nginx nginx && \
    apt-get update && apt-get install -y \
        gcc \
        spawn-fcgi \
        nginx \
        libfcgi-dev \
        make && \
    rm -rf /var/lib/apt/lists/* && \
    chmod u-s /usr/bin/gpasswd /usr/bin/chsh /usr/bin/chfn /usr/bin/passwd /usr/bin/chage /usr/bin/wall /bin/umount /bin/mount /usr/bin/newgrp /bin/su && \
    chmod g-s /usr/sbin/unix_chkpwd /usr/bin/expiry /usr/bin/chage && \
    mkdir -p /var/lib/nginx/body /var/log/nginx && \
    chown -R nginx:nginx /var/lib/nginx /var/log/nginx && \
    chmod -R 755 /var/lib/nginx /var/log/nginx && \
    gcc -o /app/mini_server /app/mini_server.c -lfcgi && \
    touch /var/run/nginx.pid && \
    chown nginx:nginx /var/run/nginx.pid /etc/nginx/nginx.conf

COPY nginx.conf /etc/nginx/nginx.conf

HEALTHCHECK CMD curl http://localhost:81/ || exit 1

ENTRYPOINT ["bash", "./run.sh"]