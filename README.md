# Caddy forward proxy

Caddy forward proxy for naiveproxy

# 编译

- 编译最新版

  Windows: [build.bat](build.bat)

  Linux: [build.sh](build.sh)

- 编译历史版本

  [klzgrad/forwardproxy](https://github.com/klzgrad/forwardproxy) 和 [caddyserver/caddy](https://github.com/caddyserver/caddy)
  版本之间存在兼容关系，可以在[这里](https://github.com/klzgrad/forwardproxy/blob/b12c33ecb72c78f652b88e697cf8eec4a8cb6373/go.mod#L6)
  查看 klzgrad/forwardproxy 支持最低的 caddyserver/caddy 版本

  在 https://github.com/klzgrad/naiveproxy/releases 下载指定版本 Source code 到本地，例如将Source code 解压至 naive 文件夹内

  ```bash
  CGO_ENABLED=0 GOOS=linux GOARCH=amd64 \
  xcaddy build v2.7.0 --output build/caddybuild/caddy-forwardproxy-linux-amd64 \
  --replace github.com/quic-go/quic-go=github.com/quic-go/quic-go@v0.41.0 \
  --replace github.com/caddyserver/forwardproxy=./naive
  ```