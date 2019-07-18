from numpy import dstack
from pandas import read_csv
from keras.utils import to_categorical

# load the dataset, returns train and test X and y elements
def readdataset(prefix=''):
	training_X, training_Y = readdatasetgroup('train', prefix + '/')
	testing_X, testing_Y = readdatasetgroup('test', prefix + '/')
    
	training_Y = training_Y - 1
	testing_Y = testing_Y - 1
    # convertiing to categorical varibles
	training_Y = to_categorical(training_Y)
	testing_Y = to_categorical(testing_Y)
	return training_X, training_Y, testing_X, testing_Y

# load a list of files and return as a 3-Dimensional numpy array
def readgroup(filenames, prefix=''):
	loaded = list()
	for name in filenames:
		data = readfile(prefix + name)
		loaded.append(data)
	loaded = dstack(loaded)
	return loaded

def readfile(filepath):
	dataframe = read_csv(filepath, header=None, delim_whitespace=True)
	return dataframe.values

# load a dataset group, such as train or test
def readdatasetgroup(group, prefix=''):
	filepath = prefix + group + '/Inertial Signals/'
	filenames = list()
	# total acceleration
	filenames += ['total_acc_x_'+group+'.txt', 'total_acc_y_'+group+'.txt', 'total_acc_z_'+group+'.txt']
	# body acceleration
	filenames += ['body_acc_x_'+group+'.txt', 'body_acc_y_'+group+'.txt', 'body_acc_z_'+group+'.txt']
	# body gyroscope
	filenames += ['body_gyro_x_'+group+'.txt', 'body_gyro_y_'+group+'.txt', 'body_gyro_z_'+group+'.txt']
	# load input data
	X = readgroup(filenames, filepath)
	# load class output
	Y = readfile(prefix + group + '/y_'+group+'.txt')
	return X, Y

def getactivitylabels(filepath):
    activities = read_csv(filepath, header=None, delim_whitespace=True)
    activities.columns = ['activity_number','activity_name']
    return activities

def dataforsubject(X, Y, sub_map, sub_id):
	index_x = [i for i in range(len(sub_map)) if sub_map[i]==sub_id]
	return X[index_x, :, :], Y[index_x]
 
# convert a series of gaps to a 1D list
def toseries(windows):
	series = list()
	for window in windows:
		half = int(len(window) / 2) - 1
		for value in window[-half:]:
			series.append(value)
	return series
