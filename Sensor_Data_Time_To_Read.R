# File for testing the time to read data

current_path <- getActiveDocumentContext()$path
setwd(dirname(current_path))

pt<-proc.time()
x_train = data.table::fread("../HARDataset/train/X_train.txt", header = FALSE)
y_train = data.table::fread("../HARDataset/train/y_train.txt", header = FALSE)
x_test = data.table::fread("../HARDataset/test/X_test.txt", header = FALSE)
y_test = data.table::fread("../HARDataset/test/y_test.txt", header = FALSE)
proc.time()-pt

pt<-proc.time()
x_train = read.csv("../HARDataset/train/X_train.txt", header = FALSE)
y_train = read.csv("../HARDataset/train/y_train.txt", header = FALSE)
x_test = data.table::fread("../HARDataset/test/X_test.txt", header = FALSE)
y_test = data.table::fread("../HARDataset/test/y_test.txt", header = FALSE)
proc.time()-pt

pt<-proc.time()
x_train = readr::read_csv("../HARDataset/train/X_train.txt",col_names = FALSE)
y_train = readr::read_csv("../HARDataset/train/y_train.txt", col_names = FALSE)
x_test = data.table::fread("../HARDataset/test/X_test.txt", col_names = FALSE)
y_test = data.table::fread("../HARDataset/test/y_test.txt", col_names = FALSE)
proc.time()-pt



pt<-proc.time()
dataset = readr::read_csv("../HARDataset/KNN dataset/X_train_knn_csv.csv")
proc.time()-pt


pt<-proc.time()
dataset = read.csv("../HARDataset/KNN dataset/X_train_knn_csv.csv")
proc.time()-pt

