#!/bin/bash

set -eu

function main() {

  om-linux \
    --target "https://${OPSMAN_DOMAIN_OR_IP_ADDRESS}" \
    --username "${OPS_MGR_USR}" \
    --password "${OPS_MGR_PWD}" \
    --skip-ssl-validation \
    configure-product \
    --product-name "${PRODUCT_NAME}" \
    -c "${PRODUCT_CONFIG_YAML}"
}

main