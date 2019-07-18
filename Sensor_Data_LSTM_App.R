# install.packages('keras')
# For laptop and basic desktop we can use cpu version of keras
# install_keras(mode='conda',tensorflow = 'cpu')
#               or
# For high graphical processors we can use gpu version of keras
# install_keras(mode='conda',tensorflow = 'gpu')
# We can also use anaconda navigator to create r-tensorflow environment

library(keras)
library(reticulate)
library(ggplot2)
library(rstudioapi)

use_condaenv('r-tensorflow')

current_path <- getActiveDocumentContext()$path
setwd(dirname(current_path))

reticulate::source_python("Sensor_Data_Preprocessor.py")

# import the dataset from python written method readdataset
dataset = readdataset('../HARDataset')
#Checking for missing data
any(is.na(dataset))
# get list of activity labels(WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, # SITTING, STANDING, LAYING)
activities = getactivitylabels('../HARDataset/activity_labels.txt')

train = readdatasetgroup('train', '../HARDataset/')
sub_map = readfile("../HARDataset/train/subject_train.txt")
train_subjects = unique(sub_map)

sub_id = train_subjects[1]
subject = dataforsubject(train[[1]], train[[2]], sub_map, sub_id)

source("plotSubject.R")
plot_subject(subject[[1]], subject[[2]])

verbose = 0
epochs = 60
batch_size =  64
n_timesteps = length(dataset[[1]][1, , 1])
n_features = length(dataset[[1]][1, 1, ])
n_outputs = length(dataset[[2]][1, ])
model = keras_model_sequential()
model %>%
  layer_lstm(30, input_shape = c(n_timesteps, n_features)) %>%
  layer_dropout(rate = 0.5) %>%
  layer_dense(30, activation = 'relu') %>%
  layer_dense(30, activation = 'relu') %>%
  layer_dense(30, activation = 'relu') %>%
  layer_dense(30, activation = 'relu') %>%
  layer_dense(n_outputs, activation = 'softmax')

model %>% compile(loss = 'categorical_crossentropy',
                  optimizer = 'adam',
                  metrics = 'accuracy')

model %>%
  fit(
    x = dataset[[1]],
    y = dataset[[2]],
    shuffle = T,
    batch_size = batch_size,
    validation_split = 0.2,
    epochs = epochs
  )

y_predict = predict_classes(model, dataset[[3]], verbose = 0)
y_predict = as.numeric(y_predict) + 1
actual_values = list()
for (i in 1:length(y_predict)) {
  actual_values[i] = which.max(dataset[[4]][i,])
  actual_values = as.numeric(actual_values)
}
confusion_matrix <- as.data.frame(table(y_predict, actual_values))


ggplot(data = confusion_matrix,
       mapping = aes(x = y_predict,
                     y = actual_values)) +
  geom_tile(aes(fill = Freq)) +
  geom_text(aes(label = sprintf("%1.0f", Freq)), vjust = 1) +
  scale_fill_gradient(low = "blue",
                      high = "red",
                      trans = "log")

accuracy = mean(actual_values == y_predict) * 100
print(paste("Accuracy=", as.character(accuracy)))

