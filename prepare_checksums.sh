#!/usr/bin/env bash

set -e

npm install -g checksum

sum_file() {
  if [[ -f "${1}" ]]; then
    echo "Calculating checksum for ${1}"
    checksum -a sha256 "${1}" > "${1}".sha256
    checksum "${1}" > "${1}".sha1
  fi
}

cd assets

rm -f checksums-md5.txt checksums-sha1.txt

ARTIFACTS=(*)

for FILE in "${ARTIFACTS[@]}"; do
  if [[ -f "${FILE}" ]]; then
    sum_file "${FILE}"
    checksum -a md5 "${FILE}" >> checksums-md5.txt
    checksum -a sha1 "${FILE}" >> checksums-sha1.txt
  fi
done

# The aggregate files only exist once the loop finishes, so sidecar them here;
# release.sh uploads every file together with its .sha1/.sha256 siblings.
sum_file checksums-md5.txt
sum_file checksums-sha1.txt

cd ..
