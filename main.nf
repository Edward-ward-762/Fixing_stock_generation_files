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

include { fix_word_doc           } from './modules/local/fix_word_doc/main.nf'
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
                        .splitCsv(header: true)
                        .map { row ->
                            [[id: row.file_id],row.file_path]
                        }

    ch_versions = Channel.empty()

    //
    // ****************************
    //
    // SECTION: Run python script
    //
    // ****************************
    //

    //
    // MODULE: run fix_word_doc
    //

    fix_word_doc(
        ch_input.map{ meta, file -> [meta, file] }
    )
    //ch_versions = ch_versions.mix(fix_word_doc.out.versions)

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