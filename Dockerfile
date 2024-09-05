FROM alpine:3.15

LABEL maintainer="jonsosnyan <https://jonssonyan.com>"

WORKDIR /caddy-forwardproxy

ENV TZ=Asia/Shanghai

ARG TARGETOS
ARG TARGETARCH
ARG TARGETVARIANT

COPY build/caddy-forwardproxy-${TARGETOS}-${TARGETARCH}${TARGETVARIANT} caddy-forwardproxy

RUN apk update && apk add --no-cache bash tzdata ca-certificates nftables \
    && rm -rf /var/cache/apk/* \
    && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
    && echo $TZ > /etc/timezone \
    && chmod +x /caddy-forwardproxy/caddy-forwardproxy

CMD ["./caddy-forwardproxy"]