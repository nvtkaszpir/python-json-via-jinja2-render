#!/usr/bin/env bash
set -exuo pipefail
# render some examples

# AWS ECR scans
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
  -i examples/aws_ecr_scan_result.json \
  -t templates/aws_ecr_scan_result_csv.j2 \
  -o examples/aws_ecr_scan_result_csv.csv

# render 'broken' files, such as unsupported images
python render.py \
  -i examples/aws_ecr_scan_result_failed.json \
  -t templates/aws_ecr_scan_result_plaintext_short.j2 \
  -o examples/aws_ecr_scan_result_plaintext_short_failed.txt

python render.py \
  -i examples/aws_ecr_scan_result_failed.json \
  -t templates/aws_ecr_scan_result_plaintext_long.j2 \
  -o examples/aws_ecr_scan_result_plaintext_long_failed.txt

python render.py \
  -i examples/aws_ecr_scan_result_failed.json \
  -t templates/aws_ecr_scan_result_html.j2 \
  -o examples/aws_ecr_scan_result_html_failed.html

python render.py \
  -i examples/aws_ecr_scan_result_failed.json \
  -t templates/aws_ecr_scan_result_csv.j2 \
  -o examples/aws_ecr_scan_result_failed_csv.csv

# docker inspect
python render.py \
  -i examples/docker_inspect.json \
  -t templates/docker_inspect_plaintext.j2 >examples/docker_inspect_plaintext.yaml

# dive docker://quay.io/kaszpir/python-json-via-jinja2-render:latest --json /dev/stdout > examples/dive.json
# redirect to stdout cause dive likes to append to existing file
python render.py \
  -i examples/dive.json \
  -t templates/dive_plaintext.j2 >examples/dive_plaintext.txt

python render.py \
  -i examples/dive.json \
  -t templates/dive_html.j2 >examples/dive_html.htnl

# docker based runs

docker run -v "$(pwd)/templates/:/app/templates:ro" -i quay.io/kaszpir/python-json-via-jinja2-render -t templates/aws_ecr_scan_result_html.j2 \
  <examples/aws_ecr_scan_result.json \
  >output.html

docker run -v "$(pwd)/templates/:/app/templates:ro" -i quay.io/kaszpir/python-json-via-jinja2-render -t templates/aws_ecr_scan_result_html.j2 \
  <examples/aws_ecr_scan_result_failed.json \
  >output_failed.html
