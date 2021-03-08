import time
import random

def read(path):
	return 0

def prepare_dataset(dataset, inputPath='', outputPath='', postfix='proc'):

	# Open
	#f = open(inputPath + '/' + dataset+ ".txt", "r")
	f = open(dataset, "r")
	content = f.read().rstrip()
	f.close()

	# Process

	content = content + '-proc' + content + '_' + str(random.randint(100,999))

	# Save
	dataset = dataset.split('/')[-1].split('.')[0]
	f = open(outputPath + '/' + dataset+ "_" + postfix + ".txt", "w")
	f.write(content)
	f.close()

	#time.sleep(2.0)

	#return dataset + '_' + postfix







