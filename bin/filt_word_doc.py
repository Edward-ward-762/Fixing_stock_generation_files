#!/usr/bin/env python3

from docx import Document
import pandas as pd
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


def filt_input_csv(file, key):
    output_val = False
    temp_doc = Document(file)
    for paragraph in temp_doc.paragraphs:
        if key in paragraph.text:
            output_val = True
    return output_val


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--process_name", default="!{process_name}")
    parser.add_argument("--input", default="!{input}")
    parser.add_argument("--output", default="!{output}")
    parser.add_argument("--filter_string", default="!{filter_string}")
    args = parser.parse_args()

    col_headers = [
        'sample_id',
        'file_path'
    ]

    raw_data = pd.read_csv(args.input)

    raw_data.columns = col_headers

    filter_value = args.filter_string

    raw_data['boolean'] = raw_data['file_path'].map(lambda x: filt_input_csv(x, filter_value))

    filtered = raw_data.loc[
        (raw_data['boolean'] == True)
    ].copy()

    output = filtered.drop(columns='boolean').copy()

    output.to_csv(args.output, index=False, header=True)

    #dump_versions(args.process_name)
