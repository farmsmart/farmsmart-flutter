#!/bin/bash

# Exit script if you try to use an uninitialized variable.
set -o nounset

# Exit script if a statement returns a non-true return value.
set -o errexit

# Use the error status of the first failure, rather than that of the last item in a pipeline.
set -o pipefail

files=$(find . -name "*.enc*")

for file in $files
do
  plainfile=$( echo ${file} | sed -E 's/(\.enc)//' )
  echo "replacing ${file} with ${plainfile} "
  cp ${plainfile} ${file}
done
