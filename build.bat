go install github.com/caddyserver/xcaddy/cmd/xcaddy@latest

SET CGO_ENABLED=0
SET GOOS=linux
SET CADDY_VERSION=

SET GOARCH=386
xcaddy build %CADDY_VERSION% --output build/naive-linux-386 --with github.com/caddyserver/forwardproxy=github.com/klzgrad/forwardproxy@naive
SET GOARCH=amd64
xcaddy build %CADDY_VERSION% --output build/naive-linux-amd64 --with github.com/caddyserver/forwardproxy=github.com/klzgrad/forwardproxy@naive
SET GOARCH=arm
SET GOARM=6
xcaddy build %CADDY_VERSION% --output build/naive-linux-armv6 --with github.com/caddyserver/forwardproxy=github.com/klzgrad/forwardproxy@naive
SET GOARCH=arm
SET GOARM=7
xcaddy build %CADDY_VERSION% --output build/naive-linux-armv7 --with github.com/caddyserver/forwardproxy=github.com/klzgrad/forwardproxy@naive
SET GOARCH=arm64
xcaddy build %CADDY_VERSION% --output build/naive-linux-arm64 --with github.com/caddyserver/forwardproxy=github.com/klzgrad/forwardproxy@naive
SET GOARCH=ppc64le
xcaddy build %CADDY_VERSION% --output build/naive-linux-ppc64le --with github.com/caddyserver/forwardproxy=github.com/klzgrad/forwardproxy@naive
SET GOARCH=s390x
xcaddy build %CADDY_VERSION% --output build/naive-linux-s390x --with github.com/caddyserver/forwardproxy=github.com/klzgrad/forwardproxy@naive
SET GOOS=windows
SET GOARCH=amd64
xcaddy build %CADDY_VERSION% --output build/naive-windows-amd64.exe --with github.com/caddyserver/forwardproxy=github.com/klzgrad/forwardproxy@naive