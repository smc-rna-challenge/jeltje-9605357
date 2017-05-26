arguments:
- {position: 5, valueFrom: $(inputs.fastq1)}
- {position: 6, valueFrom: $(inputs.fastq2)}
- {position: 7, valueFrom: $(inputs.index.path)/$(inputs.refname)}
- {position: 8, valueFrom: $(inputs.sampleid)}
baseCommand: [rsem-calculate-expression]
class: CommandLineTool
cwlVersion: v1.0
hints: []
inputs:
- default: true
  id: bowtie2
  inputBinding: {position: 2, prefix: --bowtie2}
  type: boolean
- {id: fastq1, type: File}
- {id: fastq2, type: File}
- {id: index, type: Directory}
- default: true
  id: nobam
  inputBinding: {position: 3, prefix: --no-bam-output}
  type: boolean
- {default: isoforms.results, id: outfile, type: string}
- default: true
  id: paired
  inputBinding: {position: 4, prefix: --paired-end}
  type: boolean
- {id: refname, type: string}
- {default: sample, id: sampleid, type: string}
- default: 8
  id: threads
  inputBinding: {position: 1, prefix: --num-threads}
  type: int
outputs:
- id: isoforms
  outputBinding: {glob: $(inputs.sampleid).$(inputs.outfile)}
  type: File
requirements:
- {class: InlineJavascriptRequirement}
- {class: DockerRequirement, dockerPull: jeltje/rsem}
- {class: ResourceRequirement, coresMin: 8}
