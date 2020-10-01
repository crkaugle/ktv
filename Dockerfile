FROM golang:alpine AS builder
RUN apk update && apk add --no-cache git bash curl
WORKDIR /go/src/vr/core
RUN git clone --progress https://github.com/wellshe/vr-core.git . && \
    bash ./release/user-package.sh nosource noconf codename=$(git describe --tags) buildname=docker-vr abpathtgz=/tmp/v2ray.tgz

FROM alpine
ENV CONFIG=https://raw.githubusercontent.com/wellshe/ktv/master/config.json
COPY --from=builder /tmp/v2ray.tgz /tmp
RUN apk update && apk add --no-cache tor ca-certificates && \
    tar xvfz /tmp/v2ray.tgz -C /usr/bin && \
    rm -rf /tmp/v2ray.tgz
    
ADD v2ray.sh /v2ray.sh
RUN chmod +x /v2ray.sh
CMD nohup tor & \
    v2ray -config $CONFIG
