#!/usr/bin/env python3

from docx import Document
import argparse

def dump_versions(process_name):
    """
    Dump the current Python version into a 'versions.yml' file.

    This function writes the process name and the current Python version into a YAML file named 'versions.yml'.

    Parameters:
    - process_name (str): A string representing the name of the process to be included in the file.
    """
    with open("versions.yml", "w", encoding="UTF-8") as out_f:
        out_f.write(process_name + ":\n")
        out_f.write("    python: " + platform.python_version() + "\n")


def replace_text_in_paragraph(paragraph, key, value):
    if key in paragraph.text:
        inline = paragraph.runs
        for item in inline:
            if key in item.text:
                item.text = item.text.replace(key, value)


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--process_name", default="!{process_name}")
    parser.add_argument("--input", default="!{input}")
    parser.add_argument("--output", default="!{output}")
    args = parser.parse_args()

    document = Document(args.input)

    for paragraph in document.paragraphs:
        replace_text_in_paragraph(paragraph, "30 V, 3", "40 V, 3.5")

    for paragraph in document.paragraphs:
        replace_text_in_paragraph(paragraph, "100 ms", "50 ms")

    for paragraph in document.paragraphs:
        replace_text_in_paragraph(paragraph, "12 pulses", "4 pulses (NEPA21 Type II - (NEPA Gene))")

    document.save(args.output)

    dump_versions(args.process_name)
