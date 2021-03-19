
nextflow.enable.dsl=2

exp = 'exp1'


params.rootDir = "c:\\Users\\fe0968\\Documents\\workflows\\data\\"

//params.rootDir = '/home/ws/fe0968/pipe/data/'
//params.rootDir = '/Users/aleksejersov/projects/pipe/data/'


params.inputDir = params.rootDir + exp
params.procDir = params.rootDir + 'output'
params.outputDir = params.rootDir + 'output'

params.proc_name = 'proc'
params.seg_name = 'seg'


params.config_prepare = 'default.yaml'

//params.datasets = ['01', '02', '03']

//data = Channel.fromPath(params.inputDir + '/*.txt' )
//data.view { "value: $it" }

process prepare {

    echo true

    //storeDir params.procDir 

    cache 'lenient'

	input:
	val dataset

	output:
    val dataset
    //file 'proc.txt'

	script:

    if(exp == 'exp1')

        """
        #!/usr/bin/python

        import sys
        sys.path.append('${launchDir}')
        from prepare import prepare_dataset
        
        #print('${dataset}')
        #print('${launchDir}')

        prepare_dataset('${dataset}', '${params.inputDir}', '${params.outputDir}', '${params.proc_name}')
        #print('${dataset}')

        #f = open('proc.txt', 'w')
        #f.write('')
        #f.close()
        """

    else if (exp == 'exp2')
    
        """
        # Do some other preprocessing for Experiment #2
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

    #---------------------------
    # Settings
    #---------------------------
    params_dict = {}
    params_dict['inputDir']  = '${params.procDir}'
    params_dict['outputDir'] = '${params.outputDir}'
    params_dict['prefix']    = '${params.proc_name}'
    params_dict['postfix']   = '${params.seg_name}'
    params_dict['method']    = '1' 
    #---------------------------

    process_dataset('${dataset}', params_dict)
    
    print('Hi from method 1')

    """

}



process seg2 {

    cache 'lenient'

    errorStrategy 'retry'

    maxRetries 5

	input: val dataset

    output: val dataset

	script:

	"""
    #!/usr/bin/python

    import sys
    sys.path.append('$launchDir')
    from process import process_dataset
    import random

    #---------------------------
    # Settings
    #---------------------------
    params_dict = {}
    params_dict['inputDir']  = '${params.procDir}'
    params_dict['outputDir'] = '${params.outputDir}'
    params_dict['prefix']    = '${params.proc_name}'
    params_dict['postfix']   = '${params.seg_name}'
    params_dict['method']    = '2' 
    #---------------------------

    process_dataset('${dataset}', params_dict)
    #print(r)

    # Testing error strategy
    try_error = False

    v = 0

    if try_error:
        v = random.randint(0,1)

        if v == 1:
            exit(1)

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

    #---------------------------
    # Settings
    #---------------------------
    params_dict = {}
    params_dict['inputDir']  = '${params.procDir}'
    params_dict['outputDir'] = '${params.outputDir}'
    params_dict['prefix']    = '${params.proc_name}'
    params_dict['postfix']   = '${params.seg_name}'
    params_dict['method']    = '3' 
    #---------------------------

    process_dataset('${dataset}', params_dict)

    print('Ho from method 3')

    """

}


workflow {

    data = Channel.fromPath(params.inputDir + '/*.txt' )
    //data = Channel.from(params.datasets)

    //prepare(data)
    prepare(data) | seg1
    //prepare(data) | (seg1 & seg2 & seg3)
}



