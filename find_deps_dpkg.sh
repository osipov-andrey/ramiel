#!/bin/sh

set -e

DEPS=$(find $1 -type f -perm /a+x -o -name '*.so' \
        | xargs -n1 ldd 2>1 \
        | grep "=>" \
        | awk -v dep="$3" '{print dep}' \
        | grep "/" \
        | sort -u)

echo "$DEPS" | xargs -n1 dpkg -S
