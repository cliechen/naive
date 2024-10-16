FROM alpine:3.15

LABEL maintainer="jonsosnyan <https://jonssonyan.com>"

WORKDIR /naive

ENV TZ=Asia/Shanghai

ARG TARGETOS
ARG TARGETARCH
ARG TARGETVARIANT

COPY build/naive-${TARGETOS}-${TARGETARCH}${TARGETVARIANT} naive

RUN apk update && apk add --no-cache bash tzdata ca-certificates nftables \
    && rm -rf /var/cache/apk/* \
    && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
    && echo $TZ > /etc/timezone \
    && chmod +x /naive/naive

CMD ["./naive"]