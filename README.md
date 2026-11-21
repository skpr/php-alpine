PHP Packages for Alpine Linux
=============================

```
ENV ALPINE_VERSION=3.8
ENV PHP_VERSION=7.3

RUN apk add --no-cache curl ca-certificates && \
    curl -L https://packages.skpr.io/php-alpine/skpr.rsa.pub -o /etc/apk/keys/skpr.rsa.pub && \
    echo "https://packages.skpr.io/php-alpine/${ALPINE_VERSION}/php${PHP_VERSION}" >> /etc/apk/repositories
```

## PHP 8.6

PHP 8.6 currently ships the base PHP packages only (`php8.6` and its bundled extensions, eg. `php8.6-fpm`, `php8.6-intl`, `php8.6-pdo_mysql`).

We are waiting on upstream releases with PHP 8.6 support before building these extensions:

| Extension | Blocker |
|-----------|---------|
| apcu | Uses compatibility macros removed in PHP 8.6.0. Fixed on master, waiting on a release. |
| compass | phper bindings don't compile against the PHP 8.6.0 headers. |
| grpc | Not yet available (also skipped for PHP 8.5). |
| imagick | Uses compatibility macros removed in PHP 8.6.0 (`zval_dtor`, `XtOffsetOf`). |
| memcached | Uses compatibility macros removed in PHP 8.6.0 (`zval_dtor`, `XtOffsetOf`). |
| redis | Uses compatibility macros removed in PHP 8.6.0 (`zval_dtor`, `zval_is_true`, `XtOffsetOf`). |
| spx | 0.4.22 only supports up to PHP 8.5. |
| xdebug | 3.5.x refuses to build against PHP 8.6. |

Skipped extensions are listed in `build/entrypoint`. To re-enable one, bump its `packages/php8.6-*/APKBUILD` to a release with PHP 8.6 support, mirror the tarball and remove it from the exclude list.

## Local Development

**Generate Keys**

```
make keys
```

**Build Packages**

```
make ALPINE=3.9 PHP=7.3
make ALPINE=3.9 PHP=7.2
```

```
make ALPINE=3.8 PHP=7.3
make ALPINE=3.8 PHP=7.2
```

**Mirror PECL Extensions**

Extension sources are pulled from https://packages.skpr.io/distributions instead of pecl.php.net.
When adding or bumping an extension, add it to `scripts/mirror-pecl`, run it and upload the tarballs to the mirror.

## Thankyou

This project was inspired by:

* https://github.com/codecasts/php-alpine
* https://github.com/phpearth/alpine
