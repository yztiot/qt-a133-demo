#!/bin/sh
PKG_CONFIG_SYSROOT_DIR=/opt/toolchain/aarch64/aarch64-szbaijie-linux-gnu/sysroot
export PKG_CONFIG_SYSROOT_DIR
PKG_CONFIG_LIBDIR=/opt/toolchain/aarch64/aarch64-szbaijie-linux-gnu/sysroot/usr/lib/pkgconfig:/opt/toolchain/aarch64/aarch64-szbaijie-linux-gnu/sysroot/usr/share/pkgconfig:/opt/toolchain/aarch64/aarch64-szbaijie-linux-gnu/sysroot/usr/lib/aarch64-szbaijie-linux-gnu/pkgconfig
export PKG_CONFIG_LIBDIR
exec pkg-config "$@"
