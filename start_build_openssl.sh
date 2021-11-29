#!/usr/bin/env bash
export ANDROID_NDK_ROOT="/mnt/c/other/ndk/android-ndk-r20"
export opensslDir=$(pwd)/android-lib-openssl/$AOSP_ABI
cd  openssl

if [ ! -d $opensslDir  ];then
 mkdir -p $opensslDir
fi
#here are android-arm, android-arm64, android-mips, android-mip64, android-x86 and android-x86_64 (*MIPS targets are no longer supported with NDK R20+).

for arch in android-arm android-arm64 android-x86 android-x86_64
do
    PATH=$ANDROID_NDK_ROOT/toolchains/llvm/prebuilt/linux-x86_64/bin:$ANDROID_NDK_ROOT/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x86_64/bin:$PATH
    ./Configure  --libdir=$openssl_lib no-asm shared no-cast no-idea no-camellia no-comp -D__ANDROID_API__=21 --prefix=$opensslDir  --openssldir=$opensslDir
    make
    make install
done

