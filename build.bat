@echo off
:: Check if xcaddy is installed
where xcaddy >nul 2>nul
if errorlevel 1 (
    echo xcaddy is not installed, installing...
    go install github.com/caddyserver/xcaddy/cmd/xcaddy@latest
) else (
    echo xcaddy is already installed.
)

:: Define an array of platforms and architectures
set PLATFORMS=386 amd64 armv6 armv7 arm64 ppc64le s390x

:: Set fixed environment variables
set GOOS=linux
set CGO_ENABLED=0

:: Loop through each platform and build
for %%P in (%PLATFORMS%) do (
    echo Building Caddy for linux/%%P...

    set "GOARM="
    if %%P==armv6 (
        set GOARCH=arm
        set GOARM=6
    ) else if %%P==armv7 (
        set GOARCH=arm
        set GOARM=7
    ) else (
        set GOARCH=%%P
    )

    :: Construct the output filename with conditional GOARM addition
    if defined GOARM (
        set OUTPUT=build/caddy-forwardproxy-%GOOS%-%GOARCH%v%GOARM%
    ) else (
        set OUTPUT=build/caddy-forwardproxy-%GOOS%-%GOARCH%
    )

    :: Build with xcaddy
    xcaddy build --output %OUTPUT% --with github.com/caddyserver/forwardproxy=github.com/klzgrad/forwardproxy@naive

    :: Check if the build succeeded
    if errorlevel 1 (
        echo Failed to build Caddy for %GOOS%/%GOARCH%v%GOARM%. Skipping.
    ) else (
        echo Successfully built: %OUTPUT%.
    )
)
