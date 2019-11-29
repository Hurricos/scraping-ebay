#!/bin/bash

echo "This script will need python3, venv and pip installed to work."
echo "If it fails, please consult README.md."

WORKING_DIR="$(dirname $0)"
cd "$WORKING_DIR"

python3 -m venv .
source bin/activate
python3 -m pip install scrapy

echo "$?"
