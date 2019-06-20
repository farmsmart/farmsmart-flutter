#!/bin/bash

# Exit script if you try to use an uninitialized variable.
set -o nounset

# Exit script if a statement returns a non-true return value.
set -o errexit

# Use the error status of the first failure, rather than that of the last item in a pipeline.
set -o pipefail

gcp_kms='projects/farmsmart-admin/locations/global/keyRings/farmsmart-admin/cryptoKeys/farmsmart'

files=$(find . -name "*.enc*")

for file in $files
do
  echo "Encrypting file in place: ${file}"
  sops -e -i \
    --gcp-kms ${gcp_kms} \
    ${file}
done
