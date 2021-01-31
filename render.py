"""dumb json to jina2 template renderer

"""

import argparse
import jinja2
import json
import sys


def render(data, template):
    """render jija2 template

    Args:
      data(obj): dict with data to pass to jinja2 template
      template(str): jinja2 template to use

    Returns: string, rendered all, or pukes with error :)

    """
    with open(template, 'r'):
        templateLoader = jinja2.FileSystemLoader(searchpath="./")
        templateEnv = jinja2.Environment(loader=templateLoader)
        template = templateEnv.get_template(template)
        outputText = template.render(data=data)
        return outputText


def run():
    """
    Parses arguments and runs the script
    """
    epilog = """
    Example usage:

    Use stdin and stdout:
    cat examples/test.json | python render.py -t templates/test.j2 | sort

    Use specific files for input and output:
    python render.py -i examples/test.json -t templates/test.j2 -o output/test2.txt

    """
    parser = argparse.ArgumentParser(
        epilog=epilog,
        formatter_class=argparse.RawDescriptionHelpFormatter
    )
    parser.add_argument(
        "-i", "--input",
        help='input json file, can be multiline json from stdin or file',
        type=argparse.FileType('r'),
        default=sys.stdin,
    )
    parser.add_argument(
        "-t",
        "--template",
        help='Jinja2 template to use to render the output',
        default='templates/plaintext.j2',
    )
    parser.add_argument(
        "-o",
        "--output",
        nargs='?',
        help='Where to pass rendered output default stdout',
        type=argparse.FileType('w'),
        default=sys.stdout,
    )
    args = parser.parse_args()

    js_input = args.input
    template = args.template
    output = args.output

    # read json input
    data = json.load(js_input)
    # render template
    rendered = render(data, template)
    # write out the rendered output
    output.write(rendered)


if __name__ == '__main__':
    run()
