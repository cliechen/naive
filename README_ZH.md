<div align="center">

<h1 align="center">Caddy forward proxy</h1>

[English](README.md) / 简体中文

[Caddy](https://github.com/caddyserver/caddy) [forward proxy](https://github.com/caddyserver/forwardproxy)
for [naiveproxy](https://github.com/klzgrad/naiveproxy)

<p>
<a href="https://www.gnu.org/licenses/gpl-3.0.html"><img src="https://img.shields.io/github/license/jonssonyan/caddy-forwardproxy" alt="License: GPL-3.0"></a>
<a href="https://github.com/jonssonyan/caddy-forwardproxy/stargazers"><img src="https://img.shields.io/github/stars/jonssonyan/caddy-forwardproxy" alt="GitHub stars"></a>
<a href="https://github.com/jonssonyan/caddy-forwardproxy/forks"><img src="https://img.shields.io/github/forks/jonssonyan/caddy-forwardproxy" alt="GitHub forks"></a>
<a href="https://github.com/jonssonyan/caddy-forwardproxy/releases"><img src="https://img.shields.io/github/v/release/jonssonyan/caddy-forwardproxy" alt="GitHub release"></a>
</p>

</div>

## 部署

### 快速安装 (推荐)

安装最新版

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/jonssonyan/h-ui/main/install.sh)
```

### 容器部署

1. 安装 Docker

   https://docs.docker.com/engine/install/

   ```bash
   bash <(curl -fsSL https://get.docker.com)
   ```

2. 启动容器

卸载

```bash
docker rm -f h-ui
docker rmi jonssonyan/h-ui
rm -rf /h-ui
```

## 性能优化

- 定时重启服务器

    ```bash
    0 4 * * * /sbin/reboot
    ```

- 安装网络加速
    - [TCP Brutal](https://github.com/apernet/tcp-brutal) (推荐)
    - [teddysun/across#bbrsh](https://github.com/teddysun/across#bbrsh)
    - [Chikage0o0/Linux-NetSpeed](https://github.com/ylx2016/Linux-NetSpeed)
    - [ylx2016/Linux-NetSpeed](https://github.com/ylx2016/Linux-NetSpeed)

## 构建

- 编译最新版

  Windows: [build.bat](build.bat)

  Linux: [build.sh](build.sh)

- 编译历史版本

  [klzgrad/forwardproxy](https://github.com/klzgrad/forwardproxy)
  和 [caddyserver/caddy](https://github.com/caddyserver/caddy)
  版本之间存在兼容关系，可以在[这里](https://github.com/klzgrad/forwardproxy/blob/b12c33ecb72c78f652b88e697cf8eec4a8cb6373/go.mod#L6)
  查看 klzgrad/forwardproxy 支持最低的 caddyserver/caddy 版本。[quic-go/quic-go](https://github.com/quic-go/quic-go)
  的版本可以在[这里](https://github.com/caddyserver/caddy/blob/21f9c20a04ec5c2ac430daa8e4ba8fbdef67f773/go.mod#L22)查看。

  在 https://github.com/klzgrad/naiveproxy/releases 下载指定版本
  Source code 到本地，例如将Source code 解压至 naive 文件夹内。

  例如：编译 v2.7.x

  ```bash
  CGO_ENABLED=0 GOOS=linux GOARCH=amd64 \
  xcaddy build v2.7.0 --output build/caddy-forwardproxy-linux-amd64 \
  --with github.com/caddyserver/forwardproxy=./naive \
  --replace github.com/quic-go/quic-go=github.com/quic-go/quic-go@v0.40.0
  ```

  需要注意 [golang/go](https://github.com/golang/go) klzgrad/forwardproxy quic-go/quic-go 的版本

## 其他

Telegram Channel: https://t.me/jonssonyan_channel

你可以在 YouTube 上关注我: https://www.youtube.com/@jonssonyan

如果这个项目对你有帮助，你可以请我喝杯咖啡:

<img src="https://github.com/jonssonyan/install-script/assets/46235235/cce90c48-27d3-492c-af3e-468b656bdd06" width="150" alt="微信赞赏码" title="微信赞赏码"/>

## 开源协议

[GPL-3.0](LICENSE)