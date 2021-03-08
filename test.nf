//nextflow.enable.dsl=2


params.str = 'Hello world!'

process splitLetters {

    echo true

    output:
    file 'chunk_*' into letters

    """
    printf '${params.str}' | split -b 6 - chunk_
    """
}


process convertToUpper {

    input:
    file x from letters.flatten()

    output:
    stdout result

    """
    cat $x | tr '[a-u]' '[A-Z]'
    """
}

result.view { it.trim() }