ARG ALPINE_VERSION=3.14
FROM alpine:${ALPINE_VERSION}

ENV GIT_DISCOVERY_ACROSS_FILESYSTEM=1

RUN apk add --no-cache alpine-sdk sudo bash \
    && adduser -D -g '' -u 1000 -G abuild packager \
    && echo "packager ALL=(ALL) ALL" >> /etc/sudoers \
    && echo "packager ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers \
    && echo "/_output/packages" | tee -a /etc/apk/repositories

ADD .abuild/skpr.rsa.pub /etc/apk/keys/skpr.rsa.pub
ADD --chown=packager:abuild .abuild /home/packager/.abuild

ADD scripts/generate-index /usr/local/bin/generate-index
RUN chmod +x /usr/local/bin/generate-index

ADD entrypoint /usr/local/bin/entrypoint
RUN chmod +x /usr/local/bin/entrypoint

USER packager

WORKDIR /packages

ENTRYPOINT [ "entrypoint" ]
