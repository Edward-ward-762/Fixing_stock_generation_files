from docx import Document


input_name = "MRC Harwell CRISPR stock generation file ACVR2B-FLOX-INTER-EM1-B6N"

output_name = input_name + "_output"

input_file = input_name + ".docx"

output_file = output_name + ".docx"


def replace_text_in_paragraph(paragraph, key, value):
    if key in paragraph.text:
        inline = paragraph.runs
        for item in inline:
            if key in item.text:
                item.text = item.text.replace(key, value)


document = Document(input_file)

for paragraph in document.paragraphs:
    replace_text_in_paragraph(paragraph, "30 V, 3", "40 V, 3.5")

for paragraph in document.paragraphs:
    replace_text_in_paragraph(paragraph, "100 ms", "50 ms")

for paragraph in document.paragraphs:
    replace_text_in_paragraph(paragraph, "12 pulses", "4 pulses (NEPA21 Type II - (NEPA Gene))")

document.save(output_file)
