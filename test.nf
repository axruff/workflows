nextflow.enable.dsl=2


params.str = 'Hello world! Test'

process splitLetters {

    echo true

    output:
    file 'chunk_*' into letters

    """
    printf '${params.str}' | split -b 6 - chunk_
    """
}

workflow {
   channel.from('Hello','Hola','Ciao') | foo | view
}
