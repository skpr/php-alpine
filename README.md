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

None of our extensions build against PHP 8.6.0 yet. Most still use compatibility macros that PHP 8.6.0 removed (`zval_dtor`, `zval_is_true`, `XtOffsetOf`, etc.).
We are waiting on the following before adding each one back:

| Extension | Current release | Waiting on |
|-----------|-----------------|------------|
| apcu | 5.1.28 | A release with the fix already on master. 5.1.29 was tagged then reverted ([krakjoe/apcu#634](https://github.com/krakjoe/apcu/issues/634)). |
| compass | 1.1.0 | Our own extension. Needs a release with a phper version that compiles against the PHP 8.6.0 headers ([skpr/compass-extension](https://github.com/skpr/compass-extension)). |
| grpc | 1.85.4 | Not built for PHP 8.5 either. Revisit after the other extensions. |
| imagick | 3.8.1 | The fix to be merged ([Imagick/imagick#768](https://github.com/Imagick/imagick/pull/768)) and released ([Imagick/imagick#804](https://github.com/Imagick/imagick/issues/804)). |
| memcached | 3.4.0 | A release with the fix already on master ([php-memcached-dev/php-memcached#586](https://github.com/php-memcached-dev/php-memcached/issues/586)). |
| redis | 6.3.0 | The fix to be merged ([phpredis/phpredis#2831](https://github.com/phpredis/phpredis/pull/2831)) and released. |
| spx | 0.4.22 | A release with PHP 8.6 support, merged on master in [NoiseByNorthwest/php-spx#353](https://github.com/NoiseByNorthwest/php-spx/pull/353). |
| xdebug | 3.5.3 | A release with PHP 8.6 support. 3.5.x refuses to build against PHP 8.6, master already allows it ([xdebug/xdebug](https://github.com/xdebug/xdebug)). |

Skipped extensions are listed in `build/entrypoint`. To add one back, create `packages/php8.6-<extension>` from its `packages/php8.5-<extension>` counterpart, bump it to a release with PHP 8.6 support, mirror the tarball and remove it from the exclude list.

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
