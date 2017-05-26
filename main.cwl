class: Workflow
cwlVersion: v1.0
dct:creator: {'@id': 'http://orcid.org/0000-0002-7681-6415', 'foaf:mbox': jeltje@synapse.org,
  'foaf:name': jeltje}
doc: 'SMC-RNA challenge isoform quantification submission

  '
hints: []
id: main
inputs:
- {id: TUMOR_FASTQ_1, type: File}
- {id: TUMOR_FASTQ_2, type: File}
- {id: index, type: File}
name: main
outputs:
- {id: OUTPUT, outputSource: cut/cutfile, type: File}
requirements:
- {class: MultipleInputFeatureRequirement}
- {class: StepInputExpressionRequirement}
- {class: InlineJavascriptRequirement}
steps:
- id: cut
  in:
  - {id: cutfile, valueFrom: $('TPM.txt')}
  - {id: infile, source: rsem/isoforms}
  out: [cutfile]
  run: cut.cwl
- id: rsem
  in:
  - {id: fastq1, source: TUMOR_FASTQ_1}
  - {id: fastq2, source: TUMOR_FASTQ_2}
  - {id: index, source: tar/output}
  - {id: refname, valueFrom: $('ref_transcriptome')}
  out: [isoforms]
  run: rsem.cwl
- id: tar
  in:
  - {id: outdir, valueFrom: $('rsem_index')}
  - {id: tarfile, source: index}
  out: [output]
  run: tar.cwl
