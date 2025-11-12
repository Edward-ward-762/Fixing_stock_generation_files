#!/usr/bin/env nextflow

/*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Fixing Stock Generation Files
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*/

/*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    IMPORT LOCAL MODULES
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*/

include { filt_word_doc            } from './modules/local/filt_word_doc/main.nf'
include { fix_word_doc             } from './modules/local/fix_word_doc/main.nf'
//include { DUMP_SOFTWARE_VERSIONS } from './modules/local/dump_software_versions.nf'

/*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    RUN MAIN WORKFLOW
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*/

workflow{

    //
    // ****************************
    //
    // SECTION: Creating input Channels
    //
    // ****************************
    //

    ch_input = Channel.fromPath(params.inputFile)

    ch_versions = Channel.empty()

    //
    // ****************************
    //
    // SECTION: Filter word document list
    //
    // ****************************
    //

    //
    // MODULE: Run filt_word_doc.py
    //

    filt_word_doc(ch_input)
    ch_versions = ch_versions.mix(filt_word_doc.out.versions)
    ch_filtered = filt_word_doc.out.filtered

    ch_filtered.view()

    /*

    //
    // ****************************
    //
    // SECTION: Fix filtered word document list
    //
    // ****************************
    //

    //
    // CHANNEL: Map ch_filtered
    //

    ch_filtered = ch_filtered
        .splitCsv(header: true)
        .map{ row ->
            [[id: row.sample_id],row.file_path]
        }

    //
    // MODULE: run fix_word_doc
    //

    fix_word_doc(
        ch_input.map{ meta, file -> [meta, file] }
    )
    ch_versions = ch_versions.mix(fix_word_doc.out.versions)

    //
    // ****************************
    //
    // SECTION: Software version dump
    //
    // ****************************
    //

    //
    // MODULE: Collect software versions
    //
    
    /*
    DUMP_SOFTWARE_VERSIONS (
        ch_versions.unique().collectFile()
    )
    */   
}

/*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    END
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*/