FROM golang:1.19-alpine3.16 as builder 

ARG app_name=server
ARG build_stamp=na
ARG build_mode=dev

ARG access_token

ARG user_id=1001
ARG group_id=1001
ARG user_name=appuser
ARG group_name=appgrp

LABEL docker.dev.box.name=${app_name}
LABEL docker.dev.box.type=golang

ENV TZ=America/New_York
ENV LANG en_US.UTF-8

ENV APP=${app_name}
ENV STAMP=${build_stamp}
ENV MODE=${build_mode}

# configure environment and tools
# Cherry-picking make and git over alpine-sdk save us 197MB.
RUN apk add --no-cache make \
    && \
    apk add --no-cache git \
    && \
    apk add --no-cache ca-certificates openssl \
    && \
    apk add --no-cache bash \
    && \
    apk add --no-cache sudo

# configure user, group and timezone
RUN addgroup \
        -S -g ${group_id} ${group_name} \
    && \
    adduser \
        -D -S -H \
        -s /bin/sh \
        -G ${group_name} \
        -u ${user_id} ${user_name} \
    && \
    addgroup appuser wheel \
    && \
    mkdir -p /etc/sudoers.d \
    && \
    echo "${user_name} ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/${user_name} \
    && \
    chmod 0440 /etc/sudoers.d/${user_name} \ 
    && \
    (echo "${user_name}:r00ki3!" | chpasswd) \
    && \
    (ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone);

# set work directory and default app user name
WORKDIR /home/app
USER ${user_name}