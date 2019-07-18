
plot_subject = function(X, y){
  require(ggplot2)
  set.seed(1234)
  # determine the total number of plots
  n = length(X[1,1,]) + 1
  off = 1
  myplots <- list()
  
  for(i in 1:3){
    ts = as.data.frame(as.numeric(toseries(X[, , off])))
    names(ts)=c("timeseries")
    for(j in 1:length(toseries(X[, , off]))){
      ts$Id[j] = j
    }
    plot1 <- ggplot(ts)+
      geom_line(aes(x = ts$Id, y = ts$timeseries),colour="darkblue") +
      #geom_point(aes(x = ts$Id, y = ts$timeseries))+
      labs (x = "Time", y = "Indicator Value", title = paste('Total Acceleration:',as.character(i)))
    myplots[[off]] = plot1
    off = off + 1
    print(off)
  }
  
  for(i in 1:3){
    ts = as.data.frame(as.numeric(toseries(X[, , off])))
    names(ts)=c("timeseries")
    for(j in 1:length(toseries(X[, , off]))){
      ts$Id[j] = j
    }
    plot2 <- ggplot(ts)+
      geom_line(aes(x = ts$Id, y = ts$timeseries),colour="darkblue") +
      #geom_point(aes(x = ts$Id, y = ts$timeseries))+
      labs (x = "Time", y = "Indicator Value", title = paste('Body Acceleration:',as.character(i)))
    myplots[[off]] = plot2
    off = off + 1
    print(off)
  }
  
  for(i in 1:3){
    ts = as.data.frame(as.numeric(toseries(X[, , off])))
    names(ts)=c("timeseries")
    for(j in 1:length(toseries(X[, , off]))){
      ts$Id[j] = j
    }
    plot3 <- ggplot(ts)+
      geom_line(aes(x = ts$Id, y = ts$timeseries),colour="darkblue") +
      #geom_point(aes(x = ts$Id, y = ts$timeseries))+
      labs (x = "Time", y = "Indicator Value", title = paste('Body Gyro:',as.character(i)))
    myplots[[off]] = plot3
    off = off + 1
    print(off)
  }
  source("multipart.R")
  print(myplots)
  multiplot(myplots[[1]],myplots[[2]],myplots[[3]],
            myplots[[4]],myplots[[5]],myplots[[6]],
            myplots[[7]],myplots[[8]],myplots[[9]],
            cols=3)
}