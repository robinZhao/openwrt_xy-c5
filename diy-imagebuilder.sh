#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# Modify default IP

#sed -i 's/192.168.1.1/192.168.2.1/g' package/base-files/files/bin/config_generate

set -e

#sed -i '/mt7621[ \t]*|/i\\txiaoyu,xy-c5|\\' target/linux/ramips/base-files/etc/board.d/02_network
#sed -i '/tew-692gr[ \t]*)/i\\txiaoyu,xy-c5|\\' target/linux/ramips/base-files/etc/board.d/02_network
# 这两行可有可无
#sed -i '/mt7621[ \t]*|/i\\txiaoyu_xy-c5|\\' target/linux/ramips/base-files/etc/board.d/02_network
#sed -i '/tew-692gr[ \t]*)/i\\txiaoyu_xy-c5|\\' target/linux/ramips/base-files/etc/board.d/02_network

#sed -i '108acp -f $(TOPDIR)/vermagic $(LINUX_DIR)/.vermagic' include/kernel-defaults.mk
curl -L https://raw.githubusercontent.com/robinZhao/openwrt_xy-c5/main/01_leds > target/linux/ramips/base-files/etc/board.d/01_leds
curl -L https://raw.githubusercontent.com/robinZhao/openwrt_xy-c5/main/02_network > target/linux/ramips/base-files/etc/board.d/02_network
curl -L https://raw.githubusercontent.com/robinZhao/openwrt_xy-c5/main/mt7621_xiaoyu_xy-c5.dts > target/linux/ramips/dts/xiaoyu_xy-c5.dts
curl -L https://raw.githubusercontent.com/robinZhao/openwrt_xy-c5/main/kernel_defaults.mk > include/kernel-defaults.mk
#curl -L https://raw.githubusercontent.com/robinZhao/openwrt_xy-c5/main/package/kernel/linux/Makefile > package/kernel/linux/Makefile
#curl -L https://raw.githubusercontent.com/robinZhao/openwrt_xy-c5/main/.config > .config

echo 'define Device/xiaoyu_xy-c5
  MTK_SOC := mt7621
  DTS := xiaoyu_xy-c5
  IMAGE_SIZE := 32448k
  DEVICE_VENDOR := XiaoYu
  DEVICE_MODEL := XY-C5
  DEVICE_TITLE := XiaoYu XY-C5
  DEVICE_PACKAGES := kmod-ata-core kmod-ata-ahci kmod-usb3 kmod-usb-ledtrig-usbport
  SUPPORTED_DEVICES += xy-c5
endef
TARGET_DEVICES += xiaoyu_xy-c5' >> target/linux/ramips/image/mt7621.mk

echo 'Target-Profile: DEVICE_xiaoyu_xy-c5
Target-Profile-Name: xiaoyu-c5
Target-Profile-Packages: kmod-usb3
Target-Profile-hasImageMetadata: 1
Target-Profile-SupportedDevices: xiaoyu,xiaoyu-c5 xy-c5

Target-Profile-Description:
Build firmware images for xiaoyu-c5
@@
' >> .targetinfo
