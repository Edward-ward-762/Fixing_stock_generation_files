#!/usr/bin/env nextflow

process fix_word_doc{
    tag "$meta.id"
    label 'process_single'

    input:
    path(file)

    output:
    path("${file.baseName}_filtered.csv"), emit: filtered
    path "versions.yml"                  , optional: true, emit: versions

    script:
    """
    python3 $workflow.projectDir/bin/filt_word_doc.py \
        --input $file \
        --output "${file.baseName}_filtered.csv" \
        --process_name $task.process \
        --filter_string $params.filter_string
    """
}