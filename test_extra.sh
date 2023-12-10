#!/usr/bin/env bash
set -x
set -e
# auto-generated file to run rendering of the files
# this file looks like a real nightmare under shellcheck :D
# don't even try to run shfmt on jinja2 template.

# [wagoodman/dive](https://github.com/wagoodman/dive) HTML
#  #

python render.py \
  --input    examples/dive.json \
  --template templates/dive_html.j2 \
  --output   examples/dive_html.html


# [wagoodman/dive](https://github.com/wagoodman/dive) plain text
#  #

python render.py \
  --input    examples/dive.json \
  --template templates/dive_plaintext.j2 \
  --output   examples/dive_plaintext.txt


# AWS ECR security scan CSV
#  #

python render.py \
  --input    examples/aws_ecr_scan_result.json \
  --template templates/aws_ecr_scan_result_csv.j2 \
  --output   examples/aws_ecr_scan_result_csv.csv


# AWS ECR security scan CSV for failed scan
#  #

python render.py \
  --input    examples/aws_ecr_scan_result_failed.json \
  --template templates/aws_ecr_scan_result_csv.j2 \
  --output   examples/aws_ecr_scan_result_csv_failed.csv


# AWS ECR security scan HTML
#  #

python render.py \
  --input    examples/aws_ecr_scan_result.json \
  --template templates/aws_ecr_scan_result_html.j2 \
  --output   examples/aws_ecr_scan_result_html.html


# AWS ECR security scan HTML for failed scan
#  #

python render.py \
  --input    examples/aws_ecr_scan_result_failed.json \
  --template templates/aws_ecr_scan_result_html.j2 \
  --output   examples/aws_ecr_scan_result_html_failed.html


# AWS ECR security scan plaintext long
#  #

python render.py \
  --input    examples/aws_ecr_scan_result.json \
  --template templates/aws_ecr_scan_result_plaintext_long.j2 \
  --output   examples/aws_ecr_scan_result_plaintext_long.txt


# AWS ECR security scan plaintext long for failed scan
#  #

python render.py \
  --input    examples/aws_ecr_scan_result_failed.json \
  --template templates/aws_ecr_scan_result_plaintext_long.j2 \
  --output   examples/aws_ecr_scan_result_plaintext_long_failed.txt


# AWS ECR security scan plaintext short
#  #

python render.py \
  --input    examples/aws_ecr_scan_result.json \
  --template templates/aws_ecr_scan_result_plaintext_short.j2 \
  --output   examples/aws_ecr_scan_result_plaintext_short.txt


# AWS ECR security scan plaintext short for failed scan
#  #

python render.py \
  --input    examples/aws_ecr_scan_result_failed.json \
  --template templates/aws_ecr_scan_result_plaintext_short.j2 \
  --output   examples/aws_ecr_scan_result_plaintext_short_failed.txt


# docker inspect plain text to simulate YAML cause we can!
# This one is rendered totally within docker container #

docker run \
    -v "$(pwd)/templates/:/app/templates:ro" \
    -i quay.io/kaszpir/python-json-via-jinja2-render \
        -t templates/docker_inspect_plaintext.j2 \
        <examples/docker_inspect.json \
        >examples/docker_inspect_plaintext.yaml


# skopeo stdout plaintext as MarkDown
#  #

python render.py \
  --input    examples/skopeo_stdout.json \
  --template templates/skopeo_markdown.j2 \
  --output   examples/skopeo_markdown.md


echo "If you can see this then all is OK."
