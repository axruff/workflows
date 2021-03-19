import time
import random

def read(path):
	return 0

def process_dataset(dataset, params):

	# Get parameters
	inputPath = params['inputDir']
	outputPath = params['outputDir']
	prefix = params['prefix']
	postfix = params['postfix']
	method = params['method']

	# Open
	dataset = dataset.split('/')[-1].split('.')[0]
	f = open(inputPath + '/' + dataset + '_' + prefix + ".txt", "r")
	content = f.read().rstrip()
	f.close()

	# Process 

	content = content + '-seg' + method + '_' + str(random.randint(100,999))

	# Save
	#dataset = dataset.split('/')[-1].split('.')[0]
	#f = open(outputPath + '/' + dataset.split('_')[0] + "_" + postfix +  method +  ".txt", "w")
	f = open(outputPath + '/' + dataset + "_" + postfix +  method +  ".txt", "w")
	f.write(content)
	f.close()







