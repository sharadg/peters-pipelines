#!/bin/bash

unzip pivnet-product/*.zip

chmod +x winfs-injector-linux
mv winfs-injector-linux /usr/local/bin/winfs-injector


tile=$(ls pivnet-product/pas-windows*.pivotal)

winfs-injector --input-tile pivnet-product/${tile} \
--output-tile pivnet-product/injected-${tile}
