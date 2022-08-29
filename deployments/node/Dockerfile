FROM node:18-bullseye-slim as builder

ARG app_name=server
ARG build_stamp=na
ARG build_mode=dev

ARG access_token

ARG user_id=1001
ARG group_id=1001
ARG user_name=node
ARG group_name=node


LABEL docker.dev.box.name=${app_name}
LABEL docker.dev.box.type=node

ENV TZ=America/New_York
ENV LANG en_US.UTF-8

ENV APP=${app_name}
ENV STAMP=${build_stamp}
ENV MODE=${build_mode}

# configure environment and tools
RUN DEBIAN_FRONTEND=noninteractive apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get -y upgrade \
    && DEBIAN_FRONTEND=noninteractive apt-get install -yq \
        sudo \
        ca-certificates \
        openssl \
        make \
        git

# configure user, group and timezone
RUN (groupmod -g ${group_id} node) \
    && (usermod -u ${user_id} -g ${group_id} ${user_name}) \
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