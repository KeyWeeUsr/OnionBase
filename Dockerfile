FROM debian:9.8-slim

ENV TOR_DEB deb.torproject.org
ENV TOR_KEY A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89
ENV NGX /var/lib/nginx

RUN apt -y update && \
    apt -y install apt-transport-https gnupg nginx curl && \
    echo "deb https://${TOR_DEB}/torproject.org stretch main" \
        >> /etc/apt/sources.list && \
    echo "deb-src https://${TOR_DEB}/torproject.org stretch main" \
        >> /etc/apt/sources.list && \
    curl https://${TOR_DEB}/torproject.org/${TOR_KEY}.asc | \
        gpg --import && \
    apt -y remove curl && \
    gpg --export ${TOR_KEY} | apt-key add - && \
    apt -y update && \
    apt -y install tor ${TOR_DEB}-keyring && apt -y remove gnupg && \
    apt -y purge && apt -y autoremove && apt -y autoclean

# fix NGINX permission errors when running as non-root
RUN mkdir -p $NGX/body && \
    mkdir -p $NGX/proxy && \
    mkdir -p $NGX/fastcgi && \
    mkdir -p $NGX/uwsgi && \
    mkdir -p $NGX/scgi
