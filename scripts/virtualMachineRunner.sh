#!/bin/bash

ISO_FILE=$1
DISK_FILE=$2
# add help message
if [ -z "$ISO_FILE" ] || [ -z "$DISK_FILE" ]; then
    echo "Usage: $0 <iso file> <disk file>"
    exit 1
fi
# format below command for better readability
sudo qemu-system-x86_64 \
  -m 8G \
  -smp 10 \
  -cdrom $ISO_FILE \
  -drive file=$DISK_FILE  \
  -boot d  \
  -enable-kvm  \
  -vga virtio  \
  -usb  \
  -device usb-tablet  \
  -device virtio-net-pci,netdev=net0 \
  -display gtk,gl=off \
  -netdev user,id=net0,hostfwd=tcp::5555-:22
