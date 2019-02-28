PHP Repositories for Alpine
===========================

```
ENV ALPINE_VERSION=3.8
ENV PHP_VERSION=7.3

RUN apk add --no-cache curl ca-certificates && \
    curl -L https://packages.skpr.io/php-alpine/skpr.rsa.pub -o /etc/apk/keys/skpr.rsa.pub && \
    echo "https://packages.skpr.io/php-alpine/${ALPINE_VERSION}/php${PHP_VERSION}" >> /etc/apk/repositories
```

## Local Development

**Generate Keys**

```
make keys
```

**Build Packages**

```
make ALPINE=3.9 PHP=7.3
make ALPINE=3.9 PHP=7.2
make ALPINE=3.9 PHP=7.1
```

```
make ALPINE=3.8 PHP=7.3
make ALPINE=3.8 PHP=7.2
make ALPINE=3.8 PHP=7.1
```

## Thankyou

This project was inspired by:

* https://github.com/codecasts/php-alpine
* https://github.com/phpearth/alpine