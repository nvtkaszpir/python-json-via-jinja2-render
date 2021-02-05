#!/usr/bin/env bash
set -exuo pipefail
# render some examples

# eat your own dog food
yq -M '.' examples/readme_table.yaml |
  python render.py \
    --template templates/readme.j2 \
    --output README.md

yq -M '.' examples/readme_table.yaml |
  python render.py \
    --template templates/_generate_test_extra.j2 \
    --output test_extra.sh

chmod +x test_extra.sh
./test_extra.sh
