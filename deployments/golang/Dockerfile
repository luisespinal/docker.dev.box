FROM golang:1.17-alpine as builder 

ARG app_name=server
ARG build_stamp=na
ARG build_mode=dev

ARG access_token

ARG user_id=1001
ARG group_id=1001


LABEL docker.dev.box.name=${app_name}
LABEL docker.dev.box.type=golang

ENV TZ=America/New_York
ENV LANG en_US.UTF-8

ENV APP=${app_name}
ENV STAMP=${build_stamp}
ENV MODE=${build_mode}

# Cherry-picking make and git over alpine-sdk save us 197MB.
RUN apk add --no-cache make=4.3-r0; \
    apk add --no-cache git=2.34.1-r0


WORKDIR /home/app

RUN (echo 'root:r00ki3!' | chpasswd) \
    && (groupmod -g ${group_id} node) \
    && (usermod -u ${user_id} -g ${group_id} node) \
    && (ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone)

USER node
ENV PORT 3000

EXPOSE 3000

ENTRYPOINT /bin/bash