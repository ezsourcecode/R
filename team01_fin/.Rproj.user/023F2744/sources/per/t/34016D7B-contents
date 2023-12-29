train <- read.csv("https://raw.githubusercontent.com/Eungyum/Power_Consumption/main/train.csv")
test <- read.csv("https://raw.githubusercontent.com/Eungyum/Power_Consumption/main/test.csv")
train$X <- NULL
test$X <- NULL

## 스코어 저장소 생성
score_LR <- data.frame(BID = NA,SMAPE = vector("numeric", 100), RMSE = vector("numeric", 100),MAE = vector("numeric", 100),MSE = vector("numeric", 100))
score_SVM <- data.frame(BID = 1:100,SMAPE = vector("numeric", 100),RMSE = vector("numeric", 100),MAE = vector("numeric", 100),MSE = vector("numeric", 100))
score_kNN <- data.frame(BID = 1:100,SMAPE = vector("numeric", 100),RMSE = vector("numeric", 100),MAE = vector("numeric", 100),MSE = vector("numeric", 100))
score_NN <- data.frame(BID = 1:100,SMAPE = vector("numeric", 100),RMSE = vector("numeric", 100),MAE = vector("numeric", 100),MSE = vector("numeric", 100))
score_gbm <- data.frame(BID = 1:100,SMAPE = vector("numeric", 100),RMSE = vector("numeric", 100),MAE = vector("numeric", 100),MSE = vector("numeric", 100))
