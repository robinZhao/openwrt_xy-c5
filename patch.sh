#!/bin/sh
set -e

sed -i '/mt7621[ \t]*|/i\\txiaoyu,xy-c5|\\' target/linux/ramips/base-files/etc/board.d/02_network
sed -i '/tew-692gr[ \t]*)/i\\txiaoyu,xy-c5|\\' target/linux/ramips/base-files/etc/board.d/02_network
# 这两行可有可无
#sed -i '/mt7621[ \t]*|/i\\txiaoyu_xy-c5|\\' target/linux/ramips/base-files/etc/board.d/02_network
#sed -i '/tew-692gr[ \t]*)/i\\txiaoyu_xy-c5|\\' target/linux/ramips/base-files/etc/board.d/02_network

curl -L https://raw.githubusercontent.com/openwrt/openwrt/master/target/linux/ramips/dts/mt7621_xiaoyu_xy-c5.dts > target/linux/ramips/dts/xiaoyu_xy-c5.dts

echo 'define Device/xiaoyu_xy-c5
  DTS := xiaoyu_xy-c5
  IMAGE_SIZE := $(ralink_default_fw_size_32M)
  DEVICE_TITLE := XiaoYu XY-C5
  DEVICE_PACKAGES := kmod-ata-core kmod-ata-ahci kmod-usb3
endef
TARGET_DEVICES += xiaoyu_xy-c5' >> target/linux/ramips/image/mt7621.mk

