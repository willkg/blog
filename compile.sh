#!/bin/bash

# Ensures required directories exist and compiles the blog.

set -o errexit

# Create output directory if needed
if [[ ! -d ./output/ ]]
then
    echo ">>> output directory doesn't exist; creating"
    mkdir ./output/
fi

echo ">>> status ..."
just status

echo ">>> compiling site ..."
just compile

echo ">>> copying over the blog ..."
cp -arv output/* /home/willkg/public_html/blog/
