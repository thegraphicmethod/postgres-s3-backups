ARG ALPINE_VERSION
FROM alpine:${ALPINE_VERSION} as alpine

ARG POSTGRES_VERSION
RUN apk add --no-cache postgresql$POSTGRES_VERSION-client \
      aws-cli \
      rsync \ 
      openssh-client
      
RUN mkdir -p /root/.ssh && echo "ssh.frankfurt.render.com ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILg6kMvQOQjMREehk1wvBKsfe1I3+acRuS8cVSdLjinK" > /root/.ssh/known_hosts

WORKDIR /scripts

COPY backup.sh .
ENTRYPOINT [ "sh", "backup.sh" ]
