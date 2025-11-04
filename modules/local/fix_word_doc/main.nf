#!/usr/bin/env nextflow

process fix_word_doc{
    tag "$meta.id"
    label 'process_single'

    input:
    tuple val(meta), path(file)

    output:
    tuple val(meta), path("${file.baseName}_fixed.docx"), emit: fixed
    path "versions.yml"                                 , optional: true, emit: versions

    script:
    """
    fix_word_doc.py --input $file --output "${file.baseName}_fixed.docx" --process_name $task.process
    """
}