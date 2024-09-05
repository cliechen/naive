go install github.com/caddyserver/xcaddy/cmd/xcaddy@latest
::Linux 386
SET CGO_ENABLED=0
SET GOOS=linux
SET GOARCH=386
xcaddy build v2.7.0 --output build/caddy-forwardproxy-linux-386 --with github.com/caddyserver/forwardproxy@caddy2=github.com/klzgrad/forwardproxy@naive
::Linux amd64
SET CGO_ENABLED=0
SET GOOS=linux
SET GOARCH=amd64
xcaddy build v2.7.0 --output build/caddy-forwardproxy-linux-amd64 --with github.com/caddyserver/forwardproxy@caddy2=github.com/klzgrad/forwardproxy@naive
::Linux armv6
SET CGO_ENABLED=0
SET GOOS=linux
SET GOARCH=arm
SET GOARM=6
xcaddy build v2.7.0 --output build/caddy-forwardproxy-linux-armv6 --with github.com/caddyserver/forwardproxy@caddy2=github.com/klzgrad/forwardproxy@naive
::Linux armv7
SET CGO_ENABLED=0
SET GOOS=linux
SET GOARCH=arm
SET GOARM=7
xcaddy build v2.7.0 --output build/caddy-forwardproxy-linux-armv7 --with github.com/caddyserver/forwardproxy@caddy2=github.com/klzgrad/forwardproxy@naive
::Linux arm64
SET CGO_ENABLED=0
SET GOOS=linux
SET GOARCH=arm64
xcaddy build v2.7.0 --output build/caddy-forwardproxy-linux-arm64 --with github.com/caddyserver/forwardproxy@caddy2=github.com/klzgrad/forwardproxy@naive
::Linux ppc64le
SET CGO_ENABLED=0
SET GOOS=linux
SET GOARCH=ppc64le
xcaddy build v2.7.0 --output build/caddy-forwardproxy-linux-ppc64le --with github.com/caddyserver/forwardproxy@caddy2=github.com/klzgrad/forwardproxy@naive
::Linux s390x
SET CGO_ENABLED=0
SET GOOS=linux
SET GOARCH=s390x
xcaddy build v2.7.0 --output build/caddy-forwardproxy-linux-s390x --with github.com/caddyserver/forwardproxy@caddy2=github.com/klzgrad/forwardproxy@naive