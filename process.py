import time
import random

def read(path):
	return 0

def process_dataset(dataset, inputPath='', outputPath='', postfix='seg', method = '1'):

	# Open
	dataset = dataset.split('/')[-1].split('.')[0]
	f = open(inputPath + '/' + dataset+ '_proc' + ".txt", "r")
	#f = open(dataset, "r")
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

	#return " ##########  processing is done for dataset: " + dataset







