FROM node:12.18.1-alpine3.9
LABEL maintainer=sacharfied

# build tools for native dependencies
RUN apk add --update make gcc g++ python git

# Installing graphicsmagick dependencies
RUN apk add --update lzip \
  wget \
  ffmpeg \
  libjpeg-turbo-dev \
  libpng-dev \
  libtool \
  freetype \
  libgomp \
  graphicsmagick
