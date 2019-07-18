# install.packages('keras')
# For laptop and basic desktop we can use cpu version of keras
# install_keras(mode='conda',tensorflow = 'cpu')
#               or
# For high graphical processors we can use gpu version of keras
# install_keras(mode='conda',tensorflow = 'gpu')

library(keras)
library(rstudioapi)
use_condaenv('r-tensorflow')
current_path <- getActiveDocumentContext()$path
setwd(dirname(current_path))

x_train = data.table::fread("../HARDataset/train/X_train.txt", header = FALSE)
y_train = data.table::fread("../HARDataset/train/y_train.txt", header = FALSE)

x_train = as.matrix(x_train)
y_train = as.matrix(y_train)

x_test = data.table::fread("../HARDataset/test/X_test.txt", header = FALSE)
y_test = data.table::fread("../HARDataset/test/y_test.txt", header = FALSE)

any(is.na(x_train))
any(is.na(y_train))
any(is.na(x_test))
any(is.na(y_test))

x_test = as.matrix(x_test)
y_test = as.matrix(y_test)

# one hot encode classes / create DummyFeatures
levels(y_train) = 1:length(y_train)
y_train = to_categorical(as.numeric(unlist(y_train)-1), num_classes = 6)


# implement ANN model

# create sequential model
model = keras_model_sequential()

# add layers, first layer needs input dimension
model %>%
  layer_dense(input_shape = ncol(x_train), units = 10, activation = "relu") %>%
  layer_dense(units = 10, activation = "relu") %>%
  layer_dense(units = 10, activation = "relu") %>%
  layer_dense(units = 10, activation = "relu") %>%
  layer_dense(units = 6, activation = "softmax")

model %>%
  compile(
    loss = "categorical_crossentropy",
    optimizer = "adagrad",
    metrics = "accuracy"
  )

# fit model with our training data set, training will be done for 200 times data set
model %>%
  fit(
    x = x_train,
    y = y_train,
    shuffle = T,
    batch_size = 10,
    validation_split = 0.3,
    epochs =200
  )

y_predict = predict_classes(model, x_test, verbose = 0)
y_predict = as.numeric(y_predict)+1


confusion_matrix <- as.data.frame(table(y_predict, y_test))

library(ggplot2)
ggplot(data = confusion_matrix,
       mapping = aes(x = y_predict,
                     y = y_test)) +
  geom_tile(aes(fill = Freq)) +
  geom_text(aes(label = sprintf("%1.0f", Freq)), vjust = 1) +
  scale_fill_gradient(low = "blue",
                      high = "red",
                      trans = "log")


accuracy = mean(y_test == y_predict) * 100
print(paste("Accuracy=", as.character(accuracy)))




