ARG ALPINE_VERSION=3.14
FROM alpine:${ALPINE_VERSION}

# https://github.com/docker-library/php/blob/master/8.3/alpine3.20/fpm/Dockerfile#L47C1-L55C31
# Apply stack smash protection to functions using local buffers and alloca()
# Make PHP's main executable position-independent (improves ASLR security mechanism, and has no performance impact on x86_64)
# Enable optimization (-O2)
# Enable linker optimization (this sorts the hash buckets to improve cache locality, and is non-default)
# https://github.com/docker-library/php/issues/272
# -D_LARGEFILE_SOURCE and -D_FILE_OFFSET_BITS=64 (https://www.php.net/manual/en/intro.filesystem.php)
ENV PHP_CFLAGS="-fstack-protector-strong -fpic -fpie -O2 -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64"
ENV PHP_CPPFLAGS="$PHP_CFLAGS"
ENV PHP_LDFLAGS="-Wl,-O1 -pie"

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
