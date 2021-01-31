#!/usr/bin/env bash
set -euo pipefail
# render some examples

python render.py \
  -i examples/aws_ecr_scan_result.json \
  -t templates/aws_ecr_scan_result_plaintext_short.j2 \
  -o examples/aws_ecr_scan_result_plaintext_short.txt

python render.py \
  -i examples/aws_ecr_scan_result.json \
  -t templates/aws_ecr_scan_result_plaintext_long.j2 \
  -o examples/aws_ecr_scan_result_plaintext_long.txt

python render.py \
  -i examples/aws_ecr_scan_result.json \
  -t templates/aws_ecr_scan_result_html.j2 \
  -o examples/aws_ecr_scan_result_html.html
