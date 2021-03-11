nextflow.enable.dsl=2

proces foo {
    input: val data
    output: val result
    exec:
    result = "$data world"
}

workflow {
   channel.from('Hello','Hola','Ciao') | foo | view
}
