# Build container
FROM resin/raspberry-pi-debian:stretch AS build

WORKDIR /root/
ENV INITSYSTEM on

RUN    apt-get update \
    && apt-get -qy install \
          build-essential git \
          libomxil-bellagio-dev

RUN    git clone --depth=1 https://github.com/FFmpeg/FFmpeg.git \
    && cd FFmpeg \
    && ./configure --arch=armhf --target-os=linux --enable-gpl --enable-omx --enable-omx-rpi --enable-nonfree --prefix="/opt/ffmpeg" \
    && make \
    && make install

# Runtime container
FROM resin/raspberry-pi-debian:stretch

WORKDIR /root/
COPY --from=build /opt/ffmpeg/ /

RUN    apt-get update \
    && apt-get -qy install \
         libraspberrypi-bin \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

COPY start.sh ./

CMD ["bash", "start.sh"]
