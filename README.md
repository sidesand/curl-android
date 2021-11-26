# curl-android
curl 交叉编译 Android


## curl编译

文档 ： [https://curl.se/docs/install.html](https://curl.se/docs/install.html)

When building curl for Android it's recommended to use a Linux environment since using curl's configure script is the easiest way to build curl for Android. Before you can build curl for Android, you need to install the Android NDK first. This can be done using the SDK Manager that is part of Android Studio. Once you have installed the Android NDK, you need to figure out where it has been installed and then set up some environment variables before launching configure. On macOS, those variables could look like this to compile for aarch64 and API level 29:
```
export NDK=~/Library/Android/sdk/ndk/20.1.5948944
export HOST_TAG=darwin-x86_64
export TOOLCHAIN=$NDK/toolchains/llvm/prebuilt/$HOST_TAG
export AR=$TOOLCHAIN/bin/aarch64-linux-android-ar
export AS=$TOOLCHAIN/bin/aarch64-linux-android-as
export CC=$TOOLCHAIN/bin/aarch64-linux-android29-clang
export CXX=$TOOLCHAIN/bin/aarch64-linux-android29-clang++
export LD=$TOOLCHAIN/bin/aarch64-linux-android-ld
export RANLIB=$TOOLCHAIN/bin/aarch64-linux-android-ranlib
export STRIP=$TOOLCHAIN/bin/aarch64-linux-android-strip
When building on Linux or targeting other API levels or architectures, you need to adjust those variables accordingly. After that you can build curl like this:
```

`./configure --host aarch64-linux-android --with-pic --disable-shared`
Note that this will not give you SSL/TLS support. If you need SSL/TLS, you have to build curl against a SSL/TLS layer, e.g. OpenSSL, because it's impossible for curl to access Android's native SSL/TLS layer. To build curl for Android using OpenSSL, follow the OpenSSL build instructions and then install libssl.a and libcrypto.a to $TOOLCHAIN/sysroot/usr/lib and copy include/openssl to $TOOLCHAIN/sysroot/usr/include. Now you can build curl for Android using OpenSSL like this:

`./configure --host aarch64-linux-android --with-pic --disable-shared --with-openssl="$TOOLCHAIN/sysroot/usr"`
Note, however, that you must target at least Android M (API level 23) or configure will not be able to detect OpenSSL since stderr (and the like) were not defined before Android M.


## openssl编译
- 文档：[https://github.com/openssl/openssl/blob/master/INSTALL.md](https://github.com/openssl/openssl/blob/master/INSTALL.md)
- Android：[https://github.com/openssl/openssl/blob/master/NOTES-ANDROID.md](https://github.com/openssl/openssl/blob/master/NOTES-ANDROID.md)

