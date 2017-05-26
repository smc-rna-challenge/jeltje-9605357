baseCommand: [tar, xvzf]
class: CommandLineTool
cwlVersion: v1.0
hints: []
inputs:
- {id: outdir, type: string}
- id: tarfile
  inputBinding: {position: 1}
  type: File
outputs:
- id: output
  outputBinding: {glob: $(inputs.outdir)}
  type: Directory
