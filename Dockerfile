FROM alpine:latest

LABEL maintainer="Kevin Pirnie <me@kpirnie.com>"

# System settings. User normally shouldn't change these parameters
ENV APP_NAME emagineovpn
ENV APP_INSTALL_PATH /opt/${APP_NAME}
ENV APP_PERSIST_DIR /opt/${APP_NAME}_data

# Configuration settings with default values
ENV NET_ADAPTER eth0
ENV HOST_ADDR localhost
ENV HOST_TUN_PORT 1194
ENV HOST_CONF_PORT 80

WORKDIR ${APP_INSTALL_PATH}

COPY scripts .
COPY config ./config
COPY VERSION ./config

RUN apk add --no-cache openvpn easy-rsa bash netcat-openbsd zip dumb-init && \
    ln -s /usr/share/easy-rsa/easyrsa /usr/bin/easyrsa && \
    mkdir -p ${APP_PERSIST_DIR} && \
    cd ${APP_PERSIST_DIR} && \
    easyrsa init-pki && \
    openssl dhparam 4096 -out pki/dh.pem && \
    # Copy DH file
    cp pki/dh.pem /etc/openvpn && \
    # Copy FROM ./scripts/server/conf TO /etc/openvpn/server.conf in DockerFile
    cd ${APP_INSTALL_PATH} && \
    cp config/server.conf /etc/openvpn/server.conf


EXPOSE 1194/udp
EXPOSE 8080/tcp

VOLUME [ "${APP_PERSIST_DIR}" ]

ENTRYPOINT [ "dumb-init", "./start.sh" ]
CMD [ "" ]
