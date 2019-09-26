#!/bin/bash
set -xe
# This script setup your environement for recent android-ndk (>28)
# but also take care to "emulate" old ndk environement for crate that is not up-to-date
# by creating some link to /usr/bin so crate that require old naming convention still find
# ggc, ar, clang or strip, NOTE that gcc is aliased to clang
# the script also create a cargo config to tell were theses binary are located
# if you need another toolchain you must add the coresponding cargo config like bellow

NDK=$HOME/android-ndk
LINKER=$NDK/toolchains/llvm/prebuilt/linux-x86_64/bin/aarch64-linux-android29-clang
AR=$NDK/toolchains/llvm/prebuilt/linux-x86_64/bin/aarch64-linux-android-ar
SYSROOT=$NDK/sysroot/
FLAGS="" #"-Clink-args=--sysroot=$NDK_SYSROOT/arch-arm64"
mkdir -p .cargo
cat > .cargo/config <<END
[target.aarch64-linux-android]
linker = "$LINKER"
ar = "$AR"
rustflags = [  ]
END

echo ".cargo/config created successfully"

sudo rm -f /usr/bin/aarch64-linux-android-gcc
sudo rm -f /usr/bin/aarch64-linux-android-clang
sudo rm -f /usr/bin/aarch64-linux-android-ar
sudo rm -f /usr/bin/aarch64-linux-android-strip
sudo ln -s $NDK/toolchains/llvm/prebuilt/linux-x86_64/bin/aarch64-linux-android29-clang /usr/bin/aarch64-linux-android-gcc
sudo ln -s $NDK/toolchains/llvm/prebuilt/linux-x86_64/bin/aarch64-linux-android29-clang /usr/bin/aarch64-linux-android-clang
sudo ln -s $NDK/toolchains/llvm/prebuilt/linux-x86_64/bin/aarch64-linux-android-ar /usr/bin/aarch64-linux-android-ar
sudo ln -s $NDK/toolchains/llvm/prebuilt/linux-x86_64/bin/aarch64-linux-android-strip /usr/bin/aarch64-linux-android-strip
