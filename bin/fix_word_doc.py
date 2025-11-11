#!/usr/bin/env python3

from docx import Document
import argparse
import platform

"""
def dump_versions(process_name):
    
    Dump the current Python version into a 'versions.yml' file.

    This function writes the process name and the current Python version into a YAML file named 'versions.yml'.

    Parameters:
    - process_name (str): A string representing the name of the process to be included in the file.
    
    with open("versions.yml", "w", encoding="UTF-8") as out_f:
        out_f.write(process_name + ":\n")
        out_f.write("    python: " + platform.python_version() + "\n")
"""

def replace_text_in_paragraph(paragraph, key, value):
    if key in paragraph.text:
        paragraph.text = paragraph.text.replace(key, value)


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--process_name", default="!{process_name}")
    parser.add_argument("--input", default="!{input}")
    parser.add_argument("--output", default="!{output}")
    parser.add_argument("--original_string", default="!{original_string}")
    parser.add_argument("--replacement_string", default="!{replacement_string}")
    args = parser.parse_args()

    document = Document(args.input)

    for paragraph in document.paragraphs:
        replace_text_in_paragraph(paragraph,
                                  key=args.original_string,
                                  value=args.replacement_string
                                 )

    document.save(args.output)

"""
    dump_versions(args.process_name)
"""
