#!/bin/bash

cp raw-pasw-tile/metadata.json pivnet-product/metadata.json
cp raw-pasw-tile/metadata.yaml pivnet-product/metadata.yaml

unzip "raw-pasw-tile/*.zip"

chmod +x winfs-injector-linux
mv winfs-injector-linux /usr/local/bin/winfs-injector


tile=$(ls raw-pasw-tile/pas-windows*.pivotal)

winfs-injector --input-tile ${tile} \
--output-tile pivnet-product/injected-${tile}
