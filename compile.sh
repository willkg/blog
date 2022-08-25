#!/bin/bash

set -o errexit

if [[ ! -d ./output/ ]]
then
    echo ">>> creating compiled_site directory ..."
    mkdir ./output/
fi

# Show python version and what's in the virtualenv
python --version
pip list

echo ">>> compiling site ..."
nikola build -a

echo ">>> copying over the blog ..."
cp -arv output/* /home/willkg/public_html/blog/
