#!/usr/bin/env bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

# Error handling function
handle_error() {
  echo "$1"
  exit 1
}

# Set Go proxy to a China mirror for faster package downloads
set_goproxy() {
  echo "Setting Go proxy to a China mirror..."
  go env -w GO111MODULE=on || handle_error "Failed to set GO111MODULE. Please check manually."
  go env -w GOPROXY=https://goproxy.cn,direct || handle_error "Failed to set GOPROXY. Please check manually."
  echo "Go proxy set successfully."
}

# Set GOPATH and add it to the environment PATH
set_gopath() {
  GOPATH=$HOME/go
  export GOPATH
  export PATH=$PATH:$GOPATH/bin
  echo "GOPATH set to $GOPATH and added to PATH."
}

# Check if Go is installed, and install it if not
install_go() {
  if ! command -v go &>/dev/null; then
    echo "Go is not installed. Installing Go..."
    sudo apt update && sudo apt install -y golang-go || handle_error "Failed to install Go. Please install it manually."
    echo "Go installed successfully."
  else
    echo "Go is already installed. Version information:"
    go version
  fi
  set_goproxy
  set_gopath
}

# Check if xcaddy is installed
check_xcaddy() {
  if ! command -v xcaddy &>/dev/null; then
    echo "xcaddy is not installed. Installing xcaddy..."
    go install github.com/caddyserver/xcaddy/cmd/xcaddy@latest || handle_error "Failed to install xcaddy. Please check manually."
    echo "xcaddy installed successfully."
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

  # Ensure the build directory exists
  mkdir -p build || handle_error "Failed to create build directory."

  for PLATFORM in "${PLATFORMS[@]}"; do
    IFS="/" read -r GOOS GOARCH <<<"$PLATFORM"
    echo "Cross-compiling Caddy for $GOOS/$GOARCH with forwardproxy plugin..."
    XCADDY_OUT="build/caddy-forwardproxy-${GOOS}-${GOARCH}"
    CGO_ENABLED=0 GOOS=$GOOS GOARCH=$GOARCH xcaddy build --output "$XCADDY_OUT" --with github.com/caddyserver/forwardproxy=github.com/klzgrad/forwardproxy@naive || echo "Failed to build Caddy for $GOOS/$GOARCH. Skipping."
    echo "Caddy successfully built for $GOOS/$GOARCH: $XCADDY_OUT"
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
