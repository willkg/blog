#!/bin/bash

# Ensures required directories exist and compiles the blog.

set -o errexit

echo ">>> status ..."
just status

echo ">>> compiling site ..."
just compile

echo ">>> copying over the blog ..."
cp -arv output/* /home/willkg/public_html/blog/
