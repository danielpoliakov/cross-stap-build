# CrossStapBuild - Cross-compile Systemtap Scripts

Docker environment for simple cross-compiling Systemtap scripts.

### Build

```
# docker build -t csb .
```

### Example

```
# docker run -v /host/shared:/shared:rw csb -a arm -k /shared/arm-kernel-tree /shared/script.stp
```

### Supported architectures

- x86_64
- i386
- arm
- aarch64
- mips

### Custom changes

- SystemTap patch for undefined syscalls (arm).
- Usage of debian-patched elfutils (elfutils upstream misses mips support).

### Cross-compilation toolchains

Project uses following toolchains from [toolchains.bootlin.com](https://toolchains.bootlin.com):

- [x86-64-core-i7--glibc--stable-2018.11-1](https://toolchains.bootlin.com/downloads/releases/toolchains/x86-64-core-i7/tarballs/x86-64-core-i7--glibc--stable-2018.11-1.tar.bz2)
- [x86-i686--glibc--stable-2018.11-1](https://toolchains.bootlin.com/downloads/releases/toolchains/x86-i686/tarballs/x86-i686--glibc--stable-2018.11-1.tar.bz2)
- [armv7-eabihf--glibc--stable-2018.11-1](https://toolchains.bootlin.com/downloads/releases/toolchains/armv7-eabihf/tarballs/armv7-eabihf--glibc--stable-2018.11-1.tar.bz2)
- [aarch64--glibc--stable-2018.11-1](https://toolchains.bootlin.com/downloads/releases/toolchains/aarch64/tarballs/aarch64--glibc--stable-2018.11-1.tar.bz2)
- [mips32--glibc--stable-2018.11-1](https://toolchains.bootlin.com/downloads/releases/toolchains/mips32/tarballs/mips32--glibc--stable-2018.11-1.tar.bz2)
