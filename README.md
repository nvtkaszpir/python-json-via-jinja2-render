# About

Very simple script to get json input, pass it via Jinja2 template to get the output.

Why? Sometimes I got some simple json file and I want to process it into
something easier to read, for example text file or html.

Other tools usually do too much already, like extra connecting to internet idk why...

# Known limitations

* not providing pip package, I'm too lazy and this is too simple to package it anyway.... or docker, yeaaaaaaahhh ;)
* template used is **TOTALLY** dependent on json file used as input, see examples

# Requirements

* pretty sure it requires python, possibly may work on python 2.x but never tested
* requires Jinja2

# Usage

```bash

render.py --help

```

# Examples

* Just see `test.sh` for exact usage.
* See `test_extra.sh` for more complex examples, also see at the bottom some intereting use cases.
* For results see `examples/` and `'templates/' directory for input/output and template files.

| Name | Input | Template | Output |
| ---- | ----- | -------- | ------ |
| [wagoodman/dive](https://github.com/wagoodman/dive) HTML | [input](examples/dive.json) | [template](templates/dive_html.j2) | [output](https://nvtkaszpir.github.io/python-json-via-jinja2-render/examples/dive_html.html) |
| [wagoodman/dive](https://github.com/wagoodman/dive) plain text | [input](examples/dive.json) | [template](templates/dive_plaintext.j2) | [output](https://nvtkaszpir.github.io/python-json-via-jinja2-render/examples/dive_plaintext.txt) |
| AWS ECR security scan CSV | [input](examples/aws_ecr_scan_result.json) | [template](templates/aws_ecr_scan_result_csv.j2) | [output](https://nvtkaszpir.github.io/python-json-via-jinja2-render/examples/aws_ecr_scan_result_csv.csv) |
| AWS ECR security scan HTML | [input](examples/aws_ecr_scan_result.json) | [template](templates/aws_ecr_scan_result_html.j2) | [output](https://nvtkaszpir.github.io/python-json-via-jinja2-render/examples/aws_ecr_scan_result_html.html) |
| AWS ECR security scan plaintext long | [input](examples/aws_ecr_scan_result.json) | [template](templates/aws_ecr_scan_result_plaintext_long.j2) | [output](https://nvtkaszpir.github.io/python-json-via-jinja2-render/examples/aws_ecr_scan_result_plaintext_long.txt) |
| AWS ECR security scan plaintext short | [input](examples/aws_ecr_scan_result.json) | [template](templates/aws_ecr_scan_result_plaintext_short.j2) | [output](https://nvtkaszpir.github.io/python-json-via-jinja2-render/examples/aws_ecr_scan_result_plaintext_short.txt) |
| docker inspect plain text to simulate YAML cause we can! | [input](examples/docker_inspect.json) | [template](templates/docker_inspect_plaintext.j2) | [output](https://nvtkaszpir.github.io/python-json-via-jinja2-render/examples/docker_inspect_plaintext.yaml) |

### Docker

```bash
cat examples/aws_ecr_scan_result.json \
| docker run -v $(pwd)/templates/:/app/templates:ro -i quay.io/kaszpir/python-json-via-jinja2-render -t templates/aws_ecr_scan_result_html.j2 \
> output.html
```

or with stdin/stdout:

```bash
docker run \
    -v "$(pwd)/templates/:/app/templates:ro" \
    -i quay.io/kaszpir/python-json-via-jinja2-render \
        -t templates/aws_ecr_scan_result_html.j2 \
        <examples/aws_ecr_scan_result.json \
        >output.html
```

## Running in container with custom templates

* Create `my_template` dir with desired template
* write `my_template/custom.j2` file which is tailored to your json input files
* Run command to get output to stdout:

```bash
cat examples/aws_ecr_scan_result.json \
| docker run -v $(pwd)/my_template/:/app/templates:ro \
  -i quay.io/kaszpir/python-json-via-jinja2-render \
  -t templates/custom.j2 \
>output.html

```

# Testing

* Run under linux
* install [yq](https://github.com/mikefarah/yq)
* install docker
* run `./test.sh`
* see generated files, commit and make PR