library(dplyr)
library(xgboost)
library(caret)
library(data.table)

## 데이터 불러오기
rtrain = read.csv('C:/k_digital/r/source/team01/train.csv')
rtest = read.csv('C:/k_digital/r/source/team01/test.csv')

str(rtrain)
str(rtest)
colSums(is.na(rtest))

rtrain <- rtrain[, -1]
rtest <- rtest[, -1]

# 아무거나 선택
high_corr_features <- c('Temp','WS', 'HM', 'DI','WC')
names(rtrain)
head(rtrain)
rtrain <- rtrain %>%
  select(BID, Temp, Rain, WS, HM, PC, SR, DI, WC)
# train/test 데이터 분할
set.seed(123)
splitIndex <- createDataPartition(rtrain$PC, p = 0.8, list = FALSE)
train_data <- rtrain[splitIndex, ]
train_data2 <- train_data %>%
  select(!PC)
test_data <- rtrain[-splitIndex, ]
test_data2 <- test_data %>%
  select(!PC)


# 데이터 변환
dtrain <- xgb.DMatrix(data = as.matrix(train_data2[, high_corr_features]), label = train_data$PC)
dtest <- xgb.DMatrix(data = as.matrix(test_data2[, high_corr_features]), label = test_data$PC)

# xgboost 파라미터 설정
params <- list(
  objective = "reg:squarederror",
  eta = 0.1,
  max_depth = 60
)
# 모델 학습
bst_model <- xgb.train(params, dtrain, nrounds = 100)
# 예측
predictions <- predict(bst_model, dtest)

# 성능 측정: RMSE
rmse <- sqrt(mean((test_data$PC - predictions)^2))
print(paste("RMSE: ", rmse))
# [1] "RMSE:  2468.94946773297"
# 성능 측정 : SMAPE
smape <- function(actual, forecast) {
  return(100 * mean(2 * abs(forecast - actual) / (abs(actual) + abs(forecast))))
}
preds <- predict(bst_model, dtest)
smape_value <- smape(test_data$PC, preds)
print(paste("SMAPE: ", smape_value))
# [1] "SMAPE:  56.6908505744145"