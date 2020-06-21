FROM node:12.18.1-alpine3.9
LABEL maintainer=sacharfied

# build tools for native dependencies
RUN apk add --update make gcc g++ python git

# install graphicsmagick from source because install via apk not working
ENV PKGNAME=graphicsmagick
ENV PKGVER=1.3.35
ENV PKGSOURCE=http://downloads.sourceforge.net/$PKGNAME/$PKGNAME/$PKGVER/GraphicsMagick-$PKGVER.tar.lz

# Installing graphicsmagick dependencies
RUN apk add --update lzip \
  wget \
  ffmpeg \
  libjpeg-turbo-dev \
  libpng-dev \
  libtool \
  freetype \
  libgomp && \
  wget $PKGSOURCE && \
  lzip -d -c GraphicsMagick-$PKGVER.tar.lz | tar -xvf - && \
  cd GraphicsMagick-$PKGVER && \
  ./configure \
  --build=$CBUILD \
  --host=$CHOST \
  --prefix=/usr \
  --sysconfdir=/etc \
  --mandir=/usr/share/man \
  --infodir=/usr/share/info \
  --localstatedir=/var \
  --enable-shared \
  --disable-static \
  --with-modules \
  --with-threads \
  --with-quantum-depth=16 && \
  make && \
  make install && \
  cd / && \
  rm -rf GraphicsMagick-$PKGVER && \
  rm GraphicsMagick-$PKGVER.tar.lz
