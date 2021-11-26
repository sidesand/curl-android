#!/usr/bin/env bash
export ANDROID_NDK_ROOT="/mnt/c/other/ndk/android-ndk-r20"
cd  openssl

#here are android-arm, android-arm64, android-mips, android-mip64, android-x86 and android-x86_64 (*MIPS targets are no longer supported with NDK R20+).

for arch in android-arm android-arm64 android-x86 android-x86_64
do
    PATH=$ANDROID_NDK_ROOT/toolchains/llvm/prebuilt/linux-x86_64/bin:$ANDROID_NDK_ROOT/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x86_64/bin:$PATH
    ./Configure $openssl_target -D__ANDROID_API__=21
    make
done

