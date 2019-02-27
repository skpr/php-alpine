ARG ALPINE_VERSION=3.9
FROM alpine:${ALPINE_VERSION}

ENV GIT_DISCOVERY_ACROSS_FILESYSTEM=1

RUN apk add --no-cache alpine-sdk \
    && adduser -D -g '' -u 1000 -G abuild packager \
    && echo "packager ALL=(ALL) ALL" >> /etc/sudoers \
    && echo "packager ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers \
    && echo "/_output/packages" | tee -a /etc/apk/repositories \
    # For building some packages (litespeeed and pear) the php command is used
    # and we'll use the latest development php.ini files to show possible warnings
    # and notices
    && mkdir -p /etc/php/7.1 /etc/php/7.2 /etc/php/7.3 \
    && curl https://raw.githubusercontent.com/php/php-src/PHP-7.1/php.ini-development --output /etc/php/7.1/php.ini \
    && curl https://raw.githubusercontent.com/php/php-src/PHP-7.2/php.ini-development --output /etc/php/7.2/php.ini \
    && curl https://raw.githubusercontent.com/php/php-src/PHP-7.3/php.ini-development --output /etc/php/7.3/php.ini

ADD .abuild/skpr.rsa.pub /etc/apk/keys/skpr.rsa.pub
ADD --chown=packager:abuild .abuild /home/packager/.abuild

ADD scripts/generate-index /usr/local/bin/generate-index
RUN chmod +x /usr/local/bin/generate-index

ADD entrypoint /usr/local/bin/entrypoint
RUN chmod +x /usr/local/bin/entrypoint

USER packager

WORKDIR /packages

ENTRYPOINT [ "entrypoint" ]