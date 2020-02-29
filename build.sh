#!/bin/bash -x

  $archive_name = 'bundle_layer.zip'

rm layers/bundle_layer.zip
rm -rf layers/bundle_layer/.

mkdir layers/bundle_layer/ruby && \
  mkdir layers/bundle_layer/ruby/gems && \
  mkdir layers/bundle_layer/ruby/gems/2.7.0

set -e

docker build -t ruby27-pg-builder -f Dockerfile .

CONTAINER=$(docker run -d ruby27-pg-builder false)

## this section to transite the postgresql client C libraries to layers folder
## which is already done

# docker cp -L  \
#     $CONTAINER:/usr/lib64/libpq.so.5.5 \
#     layers/bundle_layer/lib/libpq.so.5
#
# #
#
# for include in libpthread.so.0 librt.so.1 libdl.so.2 libm.so.6 libldap-2.4.so.2 libc.so.6 ld-linux-x86-64.so.2 liblber-2.4.so.2 libresolv.so.2 libsasl2.so.3 libssl.so.10 libcrypto.so.10 libssl3.so libsmime3.so libnss3.so libnssutil3.so libplds4.so libplc4.so libnspr4.so libcrypt.so.1 libgssapi_krb5.so.2 libkrb5.so.3 libk5crypto.so.3 libcom_err.so.2 libkrb5support.so.0 libz.so.1 libfreebl3.so libkeyutils.so.1 libselinux.so.1 libpcre.so.1; do
#   docker cp -L \
#     $CONTAINER:/usr/lib64/$include \
#     layers/bundle_layer/lib/$include
# done

docker cp \
    $CONTAINER:/var/task/vendor/bundle/ruby/2.7.0/ \
    layers/bundle_layer/ruby/gems/


docker rm $CONTAINER
