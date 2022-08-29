FROM node:18-bullseye-slim

ARG group_id=1000
ARG user_id=1000
ARG app_name=na

LABEL docker.dev.box.name=${app_name}
LABEL docker.dev.box.type=node
ENV TZ=America/New_York

ENV LANG en_US.UTF-8

WORKDIR /home/app

RUN (echo 'root:r00ki3!' | chpasswd) \
    && (groupmod -g ${group_id} node) \
    && (usermod -u ${user_id} -g ${group_id} node) \
    && (ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone)

USER node
ENV PORT 3000

EXPOSE 3000

ENTRYPOINT /bin/bash