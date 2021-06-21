FROM ghcr.io/linuxserver/baseimage-rdesktop-web:bionic

# set version label
ARG BUILD_DATE
ARG VERSION
ARG PORTFOLIO_RELEASE
LABEL build_version="edwinclement09 version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="ediwnclement08"

ENV ARCHIVE=https://github.com/buchen/portfolio/releases/download/${VERSION}/PortfolioPerformance-${VERSION}-linux.gtk.x86_64.tar.gz

ENV \
  CUSTOM_PORT="8080" \
  GUIAUTOSTART="true" \
  HOME="/config"

    

RUN useradd -ms /bin/bash portfolio && mkdir -p /data /opt/portfolio && chown portfolio /opt/portfolio /data

RUN \
  echo "**** install runtime packages ****" && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    dbus \
    fcitx-rime \
    fonts-wqy-microhei \
    jq \
    libnss3 \
    libqpdf21 \
    libxkbcommon-x11-0 \
    libxcb-icccm4 \
    libxcb-image0 \
    libxcb-keysyms1 \
    libxcb-randr0 \
    libxcb-render-util0 \
    libxcb-xinerama0 \
    python3 \
    python3-xdg \
    ttf-wqy-zenhei \
    wget \
    ca-certificates \
    curl \
    openjdk-11-jre-headless \
    libgtk2.0-0 libswt-gtk* libcanberra-gtk-module libwebkitgtk-3.0.0 

RUN \
  echo "**** install portfolio performance ****" && \
  if [ -z ${PORTFOLIO_RELEASE+x} ]; then \
    PORTFOLIO_RELEASE=$(curl -sX GET "https://api.github.com/repos/buchen/portfolio/releases/latest" \
    | jq -r .tag_name); \
  fi && \
  PORTFOLIO_URL="https://github.com/buchen/portfolio/releases/download/${PORTFOLIO_RELEASE}/PortfolioPerformance-$PORTFOLIO_RELEASE-linux.gtk.x86_64.tar.gz" && \
  echo "Downloading version  ${PORTFOLIO_RELEASE} $PORTFOLIO_URL" &&  \  
  curl -o \
    /tmp/portfolio-tarball.tar.gz -L  "$PORTFOLIO_URL" 

RUN \
  tar xvf /tmp/portfolio-tarball.tar.gz -C \
    /opt/ && \
  dbus-uuidgen > /etc/machine-id && \
  echo "**** cleanup ****" && \
  apt-get clean && \
  rm -rf \
    /tmp/* \
    /var/lib/apt/lists/* \
    /var/tmp/*

# add local files
COPY root/ /
