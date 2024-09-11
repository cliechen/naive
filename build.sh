#!/usr/bin/env bash
export PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin

# Error handling function
handle_error() {
  echo "$1"
  exit 1
}

# Set Go proxy and GOPATH environment
set_go_env() {
  echo "Configuring Go environment..."
  go env -w GO111MODULE=on GOPROXY=https://goproxy.cn,direct || handle_error "Failed to configure Go environment."
  export GOPATH=$HOME/go
  export PATH=$PATH:$GOPATH/bin
  echo "Go environment configured successfully."
}

# Install Go if not present
install_go() {
  if ! command -v go &>/dev/null; then
    echo "Go is not installed. Installing Go..."
    sudo apt update && sudo apt install -y golang-go || handle_error "Failed to install Go."
    echo "Go installed successfully."
  else
    echo "Go is already installed. Version:"
    go version
  fi
  set_go_env
}

# Install xcaddy if not present
install_xcaddy() {
  if ! command -v xcaddy &>/dev/null; then
    echo "xcaddy is not installed. Installing xcaddy..."
    go install github.com/caddyserver/xcaddy/cmd/xcaddy@latest || handle_error "Failed to install xcaddy."
    echo "xcaddy installed successfully."
  else
    echo "xcaddy is already installed. Version:"
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

  mkdir -p build || handle_error "Failed to create build directory."

  for PLATFORM in "${PLATFORMS[@]}"; do
    IFS="/" read -r GOOS GOARCH <<<"$PLATFORM"
    echo "Cross-compiling Caddy for $GOOS/$GOARCH..."
    XCADDY_OUT="build/caddy-forwardproxy-${GOOS}-${GOARCH}"
    CGO_ENABLED=0 GOOS=$GOOS GOARCH=$GOARCH xcaddy build --output "$XCADDY_OUT" \
      --with github.com/caddyserver/forwardproxy=github.com/klzgrad/forwardproxy@naive ||
      echo "Failed to build Caddy for $GOOS/$GOARCH. Skipping."
    echo "Caddy successfully built for $GOOS/$GOARCH: $XCADDY_OUT"
  done
}

# Main function
main() {
  install_go
  install_xcaddy
  cross_compile_caddy
  echo "Caddy cross-compilation completed for all platforms."
}

# Execute the main function
main
