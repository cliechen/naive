@echo off

:: Install xcaddy if not already installed
go install github.com/caddyserver/xcaddy/cmd/xcaddy@latest

:: Define an array of platforms and architectures
set PLATFORMS=386 amd64 armv6 armv7 arm64 ppc64le s390x

:: Loop through each platform and build
for %%P in (%PLATFORMS%) do (
    echo Building Caddy for linux/%%P...

    if %%P==armv6 (
        set GOOS=linux
        set GOARCH=arm
        set GOARM=6
    ) else if %%P==armv7 (
        set GOOS=linux
        set GOARCH=arm
        set GOARM=7
    ) else (
        set GOOS=linux
        set GOARCH=%%P
        set GOARM=
    )

    set CGO_ENABLED=0
    xcaddy build --with github.com/caddyserver/forwardproxy=github.com/klzgrad/forwardproxy@naive --output build/caddy-forwardproxy-%GOOS%-%GOARCH%%GOARM%
    
    if errorlevel 1 (
        echo Failed to build Caddy for %GOOS%/%GOARCH%%GOARM%. Skipping.
    ) else (
        echo Successfully build: build/caddy-forwardproxy-%GOOS%-%GOARCH%%GOARM%.
    )
)
