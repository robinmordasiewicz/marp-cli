FROM node:16.15.0-alpine
LABEL maintainer "Marp team"

RUN apk update && apk upgrade && \
    echo @edge http://nl.alpinelinux.org/alpine/edge/community >> /etc/apk/repositories && \
    echo @edge http://nl.alpinelinux.org/alpine/edge/main >> /etc/apk/repositories && \
    echo @edge http://nl.alpinelinux.org/alpine/edge/testing >> /etc/apk/repositories && \
    apk add --no-cache \
      grep \
      chromium@edge \
      freetype@edge \
      libstdc++@edge \
      harfbuzz@edge \
      ttf-liberation@edge \
      font-noto-cjk@edge \
      font-noto-devanagari@edge \
      font-noto-arabic@edge \
      font-noto-bengali@edge \
      nss@edge \
      wayland-dev@edge \
      su-exec

RUN addgroup -S ubuntu && adduser -S -g ubuntu ubuntu \
    && chown -R ubuntu:ubuntu /home/ubuntu

ENV MARP_USER ubuntu:ubuntu

RUN mkdir /opt/marp
COPY docker-entrypoint /opt/marp/docker-entrypoint
RUN chmod 755 /opt/marp/docker-entrypoint

WORKDIR /home/ubuntu/
RUN npm install --save v8-compile-cache
RUN npm install @babel/core
RUN npm install -g @marp-team/marp-cli

# Install node dependencies, and create v8 cache by running Marp CLI once
RUN chown -R ubuntu:ubuntu /home/ubuntu
USER ubuntu:ubuntu
ENV CHROME_PATH /usr/bin/chromium-browser

COPY --chown=ubuntu:ubuntu . .

#RUN yarn install
#RUN yarn cache clean
#RUN node marp-cli.js --version
#RUN yarn install --production --frozen-lockfile && yarn cache clean && node marp-cli.js --version

# Setup workspace for user
#USER root

#ENTRYPOINT ["/opt/marp/docker-entrypoint"]
#CMD ["--help"]
