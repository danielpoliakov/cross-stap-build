FROM fedora:29

RUN dnf install -y @development-tools \
                   gcc-c++ \
                   python2 \
                   zlib-devel \
                   flex \
                   bison \
                   bzip2 \
                   wget

RUN rpm -e --nodeps systemtap \
  && rpm -e --nodeps systemtap-client \
  && rpm -e --nodeps systemtap-devel \
  && rpm -e --nodeps systemtap-runtime 

COPY . /csb/

RUN wget https://toolchains.bootlin.com/downloads/releases/toolchains/armv7-eabihf/tarballs/armv7-eabihf--glibc--stable-2018.11-1.tar.bz2 -q -O - | tar xj -C /csb/toolchains \
  && wget https://toolchains.bootlin.com/downloads/releases/toolchains/x86-i686/tarballs/x86-i686--glibc--stable-2018.11-1.tar.bz2 -q -O - | tar xj -C /csb/toolchains \
  && wget https://toolchains.bootlin.com/downloads/releases/toolchains/mips32/tarballs/mips32--glibc--stable-2018.11-1.tar.bz2 -q -O - | tar xj -C /csb/toolchains \
  && wget https://toolchains.bootlin.com/downloads/releases/toolchains/x86-64-core-i7/tarballs/x86-64-core-i7--glibc--stable-2018.11-1.tar.bz2 -q -O - | tar xj -C /csb/toolchains \
  && wget https://toolchains.bootlin.com/downloads/releases/toolchains/aarch64/tarballs/aarch64--glibc--stable-2018.11-1.tar.bz2 -q -O - | tar xj -C /csb/toolchains

RUN git clone https://github.com/danieluhricek/systemtap

WORKDIR systemtap

RUN ./configure --with-elfutils=/csb/elfutils/elfutils-0.176/ \
  && make all \
  && make install

WORKDIR /

ENTRYPOINT ["/csb/entrypoint.sh"]
