FROM node:16.15.0-alpine
LABEL maintainer "Marp team"

USER root

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
    && mkdir -p /home/ubuntu/app /home/ubuntu/.cli

RUN apk --no-cache add shadow && \
    usermod -u 1001 node && \
    groupmod -g 1001 node && \
    chown -R node:node /home/node && \
    usermod -u 1000 ubuntu && \
    groupmod -g 1000 ubuntu && \
    chown -R ubuntu:ubuntu /home/ubuntu

RUN npm install -g @marp-team/marp-cli
# Setup workspace for user
ENV MARP_USER ubuntu:ubuntu

# Install node dependencies, and create v8 cache by running Marp CLI once
USER ubuntu:ubuntu
ENV CHROME_PATH /usr/bin/chromium-browser

COPY --chown=ubuntu:ubuntu . .
RUN yarn install --production --frozen-lockfile && yarn cache clean && node marp-cli.js --version

WORKDIR /home/ubuntu/

#ENTRYPOINT ["/home/ubuntu/.cli/docker-entrypoint"]
#CMD ["--help"]
