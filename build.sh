#!/usr/bin/env bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

# Set Go proxy to a China mirror for faster package downloads
set_goproxy() {
  echo "Setting Go proxy to a China mirror..."
  go env -w GOPROXY=https://goproxy.cn,direct
  if [ $? -eq 0 ]; then
    echo "Go proxy set successfully."
  else
    echo "Failed to set Go proxy. Please check manually."
    exit 1
  fi
}

# Check if Go is installed, and install it if not
install_go() {
  if ! command -v go &>/dev/null; then
    echo "Go is not installed. Installing Go..."
    sudo apt update
    sudo apt install -y golang-go
    if ! command -v go &>/dev/null; then
      echo "Failed to install Go. Please install it manually."
      exit 1
    else
      echo "Go installed successfully."
      set_goproxy
    fi
  else
    echo "Go is already installed. Version information:"
    go version
  fi
}

# Check if xcaddy is installed
check_xcaddy() {
  if ! command -v xcaddy &>/dev/null; then
    echo "xcaddy is not installed. Installing xcaddy..."
    go install github.com/caddyserver/xcaddy/cmd/xcaddy@latest
    if ! command -v xcaddy &>/dev/null; then
      echo "Failed to install xcaddy. Please check manually."
      exit 1
    else
      echo "xcaddy installed successfully."
    fi
  else
    echo "xcaddy is already installed. Version information:"
    xcaddy version
  fi
}

# Cross-compile Caddy for multiple platforms with forwardproxy plugin
cross_compile_caddy() {
  PLATFORMS=(
    "linux/386"
    "linux/amd64"
    "linux/arm/6"
    "linux/arm/7"
    "linux/arm64"
    "linux/ppc64le"
    "linux/s390x"
  )

  for PLATFORM in "${PLATFORMS[@]}"; do
    IFS="/" read -r GOOS GOARCH <<<"$PLATFORM"
    echo "Cross-compiling Caddy for $GOOS/$GOARCH with forwardproxy plugin..."
    XCADDY_OUT="build/caddy-forwardproxy-${GOOS}-${GOARCH}"
    CGO_ENABLED=0 GOOS=$GOOS GOARCH=$GOARCH xcaddy build --output "$XCADDY_OUT" --with github.com/caddyserver/forwardproxy=github.com/klzgrad/forwardproxy@naive
    if [ $? -eq 0 ]; then
      echo "Caddy successfully build for $GOOS/$GOARCH: $XCADDY_OUT"
    else
      echo "Failed to build Caddy for $GOOS/$GOARCH. Please check the logs."
    fi
  done
}

# Main function to run all tasks
main() {
  install_go
  check_xcaddy
  cross_compile_caddy
  echo "Caddy cross-compilation with forwardproxy completed for all platforms."
}

# Execute the main function
main
