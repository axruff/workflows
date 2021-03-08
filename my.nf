
nextflow.enable.dsl=2

exp = 'exp1'

params.rootDir = '/Users/aleksejersov/projects/pipe/data/'
params.inputDir = params.rootDir + exp
params.procDir = params.rootDir + 'output'
params.outputDir = params.rootDir + 'output'

params.proc_name = 'proc'
params.seg_name = 'seg'

//params.datasets = ['01', '02', '03']

params.config_prepare = 'default.yaml'

process prepare {

    //echo true

    //storeDir params.procDir 

    cache 'lenient'

	input:
	val dataset

	output:
    val dataset
    //file 'proc.txt'

	script:

	"""
    #!/usr/bin/python

    import sys
    sys.path.append('$launchDir')
    from prepare import prepare_dataset

    prepare_dataset('${dataset}', '${params.inputDir}', '${params.outputDir}', '${params.proc_name}')
    #print(r)

    #f = open('proc.txt', 'w')
    #f.write('')
    #f.close()


    """
}


process seg1 {

    cache 'lenient'

	input: 
    val dataset
    //val 'seg1.txt'

    output: val dataset

	script:

	"""
    #!/usr/bin/python

    import sys
    sys.path.append('$launchDir')
    from process import process_dataset

    process_dataset('${dataset}' , '${params.procDir}', '${params.outputDir}', '${params.seg_name}', method='1')
    #print(r)

    """

}



process seg2 {

    cache 'lenient'

	input: val dataset

    output: val dataset

	script:

	"""
    #!/usr/bin/python

    import sys
    sys.path.append('$launchDir')
    from process import process_dataset

    process_dataset('${dataset}' , '${params.procDir}', '${params.outputDir}', '${params.seg_name}', method='2')
    #print(r)

    """

}

process seg3 {

    cache 'lenient'

    input: val dataset

    output: val dataset

    script:

    """
    #!/usr/bin/python

    import sys
    sys.path.append('$launchDir')
    from process import process_dataset

    process_dataset('${dataset}' , '${params.procDir}', '${params.outputDir}', '${params.seg_name}', method='3')
    #print(r)

    """

}


workflow {

    data = Channel.fromPath(params.inputDir + '/*.txt' )

    //data = Channel.from(params.datasets)
  
    //prepare(data) 
    //prepare(data) | seg1
    prepare(data) | (seg1 & seg2 & seg3)
}


//target.subscribe {"message: $it" }

