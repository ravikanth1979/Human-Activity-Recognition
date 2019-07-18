# Human-Activity-Recognition
1.1	Introduction
The population of ageing people is continuously increasing around the world. Currently, assisting aged people during their day-to-day activities, increasing their safety, security and self-support, are considered key study contests. Activity recognition[1][2][3] based on new wearable technologies (wearable sensors and accessories, smartphones, etc.) is one of these important challenges. Identifying human activities are fundamental functions to provide healthcare and assistance services to ageing people living alone, physically or mentally disabled people, and children. These individuals need continuous scrutinizing of their activities to notice abnormal circumstances or avert erratic events such as falls.

Activities from “smart phone activity recognition” application are divided into “low level activities” and “high-level activities”. In this case study, term “low level activities” denote a series of activities that run for very short time. The common low level activities in our daily life includes walking, running, sitting, standing, laying etc. High-level activities are complex activities which are reliant on individual person, time and place and it is quite difficult to recognize for sensors. My case study is mainly on classifying day-to-day low level human activities. 

1.2	Aim and Objective of the task
Now a days all modern smart phones have applications related to these sensors. The smartphones activity recognition applications work with “accelerometer” and “gyroscope”. Accelerometer and gyroscope measures velocity and rotational velocity changes. 
In this task, I have used the data collected from accelerometer sensors which are installed as part of smart phone apps. Nearly every modern smartphone has a tri-axial accelerometer that measures acceleration in all three spatial dimensions. Additionally, accelerometers can detect device orientation. Smart phones which attached to the body part record accelerometer and gyroscope measures in three dimensions(x, y, z).

The resultant activities from the sensor shown below:
1.	Walking
2.	Walking Upstairs
3.	Walking Downstairs
4.	Sitting
5.	Standing
6.	Laying

In this section, I have developed “Long Short-Term Memory (LSTM)”[4][5], “Artificial Neural Network(ANN)” network models using R and SAS Enterprise Miner.
The benefit of LSTM is, it can handle pre-processed time series sensor data(which has 200 to 400-time steps) directly and does not required any experts to convert time series sensor data to featured engineered data. Where as remaining models such as ANN and SAS EM neural networks can only handle data with engineered features and can not handle data with time series sensor data. Though it is complex for LSTM to handle time series sensor data, it can achieve similar performance to models like ANN and SAS EM neural networks. Through this task I also want to justify the performance LSTM with ANN and SAS EM neural networks.
I have used R programming language for developing LSTM[4][5] and ANN models and SAS Enterprise Miner for developing basic neural network model.

1.3	Basic Literature Review
This case study presents a review of different classification techniques used to recognize human activities from smart phone sensor data. Three supervised classification techniques namely, long short-term memory(LSTM) recurrent neural networks, Artificial Neural Networks (ANN) and SAS EM neural networks are compared in terms of accuracy and specificity. Pre-processed raw data has used for LSTM and engineered feature data has used for ANN and SAS EM neural network modes. Based on my experiments, the results obtained show that the k-NN, SAS EM neural networks provides the best accuracy compared to other supervised classification algorithms because these are dealing with engineered features, but the LSTM classifier is the one that is best suited for the sensor raw data which considered time gap as third dimensional data.  This comparison highlights which approach gives better performance in supervised contexts. 

Keywords:
 activity recognition; wearable sensors; smart spaces; data classifiers; accelerometers; physical activities


