FROM ubuntu:bionic-20200403

EXPOSE 5062/udp

RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
		build-essential git \
		wget ca-certificates \
		pkg-config libopus-dev libssl-dev \
		zlib1g-dev gperf ccache iputils-ping \
	&& rm -rf /var/lib/apt/lists/*

RUN wget https://cmake.org/files/v3.18/cmake-3.18.0-Linux-x86_64.sh \
    && sh cmake-3.18.0-Linux-x86_64.sh --prefix=/usr --exclude-subdir

COPY tdlib_header.patch /
COPY tdlib_threadname.patch /

# TDLib 1.7.10
RUN git clone https://github.com/tdlib/td.git \
    && cd td \
    && git reset --hard a53cb30e99f937cfd64e0266fa558785a184a553 \
    && git apply /tdlib_header.patch \
    && git apply /tdlib_threadname.patch \
    && mkdir build \
    && cd build \
    && cmake -DCMAKE_BUILD_TYPE=Release .. \
    && cmake --build . --target install -j $(grep -c ^processor /proc/cpuinfo) \
    && cd / \
    && rm -rf td

COPY config_site.h /

RUN git clone https://github.com/pjsip/pjproject.git \
    && cd pjproject \
    && git reset --hard 2.9 \
    && cp /config_site.h pjlib/include/pj \
    && ./configure --disable-sound CFLAGS="-O3 -DNDEBUG" \
    && make dep && make -j $(grep -c ^processor /proc/cpuinfo) && make install \
    && cd / \
    && rm -rf pjproject

RUN git clone -n https://github.com/gabime/spdlog.git \
    && cd spdlog \
    && git checkout tags/v0.17.0 \
    && mkdir build \
    && cd build \
    && cmake -DCMAKE_BUILD_TYPE=Release -DSPDLOG_BUILD_EXAMPLES=OFF -DSPDLOG_BUILD_TESTING=OFF .. \
    && cmake --build . --target install -j $(grep -c ^processor /proc/cpuinfo) \
    && cd / \
    && rm -rf spdlog

RUN ls -la

COPY . /

ENV PATH="$PATH:/opt/tg2sip"
RUN echo $PATH

RUN ls -la && cd /tg2sip \
    && mkdir build \
    && export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig \
    && cmake -DCMAKE_BUILD_TYPE=Release -DUSE_SYSTEM_CIMG=0 .. \
    && cmake --build . \
    && mkdir /opt/tg2sip \
    && cp -vr /tg2sip/tg2sip /opt/tg2sip/ \
    && cp -vr /tg2sip/gen_db /opt/tg2sip/ \
    && cp -vr /settings.ini /opt/tg2sip/ \
    && cp -vr /startup.sh /opt/tg2sip/ \
    && chmod +x /opt/tg2sip/tg2sip \
    && chmod +x /opt/tg2sip/startup.sh \
    && chmod +x /opt/tg2sip/gen_db

CMD ["bash", "startup.sh"]