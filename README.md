# About

Very simple script to get json input, pass it via Jinja2 template to get the output.

Why? Sometimes I got some simple json file and I want to process it into
something easier to read, for example text file or html.

Other tools usually do too much already, like extra connecting to internet idk why...

# Known limitations

* not providing pip package, I'm too lazy and this is too simple to package it anyway.... or docker, yeaaaaaaahhh ;)
* template used is **TOTALLY** dependent on json file used as input, see examples

# Requirements

* pretty sure it requires python
* may require Jinja2

# Usage

```bash

render.py --help

```

# Examples

## AWS ECR security scan output

### Plain text short

* [input](examples/aws_ecr_scan_result.json)
* [template](templates/aws_ecr_scan_result_plaintext_short.j2) 
* [output](examples/aws_ecr_scan_result_plaintext_short.txt)

```bash
python render.py \
  -i examples/aws_ecr_scan_result.json \
  -t templates/aws_ecr_scan_result_plaintext_short.j2 \
  -o examples/aws_ecr_scan_result_plaintext_short.txt
```

### Plain text long

* [input](examples/aws_ecr_scan_result.json)
* [template](templates/aws_ecr_scan_result_plaintext_long.j2) 
* [output](examples/aws_ecr_scan_result_plaintext_long.txt)


```bash
python render.py \
  -i examples/aws_ecr_scan_result.json \
  -t templates/aws_ecr_scan_result_plaintext_long.j2 \
  -o examples/aws_ecr_scan_result_plaintext_long.txt
```

### HTML

This is a bit more useful :)

* [input](examples/aws_ecr_scan_result.json)
* [template](templates/aws_ecr_scan_result_html.j2) 
* [output](examples/aws_ecr_scan_result_html.html)

```bash
python render.py \
  -i examples/aws_ecr_scan_result.json \
  -t templates/aws_ecr_scan_result_html.j2 \
  -o examples/aws_ecr_scan_result_html.html
```

Fully rendered output [here](https://nvtkaszpir.github.io/python-json-via-jinja2-render/examples/aws_ecr_scan_result_html.html).

### Docker

```bash
cat examples/aws_ecr_scan_result.json \
| docker run -v $(pwd)/templates/:/app/templates:ro -i quay.io/kaszpir/python-json-via-jinja2-render -t templates/aws_ecr_scan_result_html.j2 \
> output.html
```

or:

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
| docker run -v $(pwd)/my_template/:/app/templates:ro -i quay.io/kaszpir/python-json-via-jinja2-render -t templates/custom.j2 \
> output.html

```
