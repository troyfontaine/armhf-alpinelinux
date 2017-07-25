#!/bin/sh

packages=$(echo "$@" | tr '[,]' ' ')

# Install packages
echo "Updating APK repos and install packages"
apk --update add --no-cache $packages

# Upgrade packages
echo "Upgrading installed packages"
apk upgrade

# Ensure root password is disabled
echo "Securing root..."
sed -ie 's/^root::/root:!:/' "/etc/shadow"

# Clear APK cache
echo "Clearing APK Cache..."
rm -f /var/cache/apk/*

# Set timezone to UTC
echo "Setting timezone to UTC"
cp /usr/share/zoneinfo/UTC /etc/localtime