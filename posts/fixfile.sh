#!/bin/bash

set -ex

for fn in $(find . -name "*.txt"); do
    echo "${fn} -> ${new_fn}"
    new_fn=$(dirname ${fn})/$(basename -s .txt ${fn}).rst
    head -n 5 ${fn} > ${new_fn}
    tail -n +5 ${fn} | pandoc --from=html --to=rst >> ${new_fn}

    vim ${new_fn}
    git add ${new_fn}
    git rm ${fn}
done
