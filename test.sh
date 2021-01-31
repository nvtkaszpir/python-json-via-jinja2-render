#!/usr/bin/env bash
set -exuo pipefail
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

python render.py \
  -i examples/docker_inspect.json \
  -t templates/docker_inspect_plaintext.j2 >examples/docker_inspect_plaintext.yaml

docker run -v "$(pwd)/templates/:/app/templates:ro" -i quay.io/kaszpir/python-json-via-jinja2-render -t templates/aws_ecr_scan_result_html.j2 \
  <examples/aws_ecr_scan_result.json \
  >output.html
