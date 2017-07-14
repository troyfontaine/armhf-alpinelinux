#!/bin/sh

packages=$(echo "$@" | tr '[,]' ' ')

# Install packages
echo "Updating..."
apk update

echo "Installing packages..."
apk add --no-cache $packages

echo "Securing root..."

# Ensure root password is disabled
sed -ie 's/^root::/root:!:/' "$rootfs/etc/shadow"
