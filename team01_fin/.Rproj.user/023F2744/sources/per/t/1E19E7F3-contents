str(train)
head(train)

str(test)
head(test)

actual

install.packages('xgboost')
install.packages('caret')

library(dplyr)
library(xgboost)
library(caret)
## 데이터 불러오기
rtrain = train
rtest = test
# 아무거나 선택
high_corr_features <- c('Temp','WS', 'HM', 'DI','WC')
# train/test 데이터 분할
set.seed(123)
train_data <- rtrain
test_data <- rtest

train_data2 <- rtrain%>%
  select(!PC)
test_data2 <- rtest %>%
  select(!PC)


# 데이터 변환
dtrain <- xgb.DMatrix(data = as.matrix(train_data2[, high_corr_features]), label = train_data$PC)
dtest <- xgb.DMatrix(data = as.matrix(test_data2[, high_corr_features]), label = test_data$PC)

# xgboost 파라미터 설정
params <- list(
  objective = "reg:squarederror",
  eta = 0.1,
  max_depth = 13
)
# 모델 학습
bst_model <- xgb.train(params, dtrain, nrounds = 100)
# 예측
predictions <- predict(bst_model, dtest)

head(rtest)
rtest$forecast <- predictions

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

head(rtrain)
rtest2 <- rtrain %>% 
  filter(DateTime>='2022-08-11')

## 선형 조정
alpha <- sum(rtest2$PC * rtest$forecast) / sum(rtest$forecast^2)
rtest$adjusted_forecast <- alpha * rtest$forecast

original_smape <- smape(rtest$PC, rtest$forecast)
adjusted_smape <- smape(rtest$PC, rtest$adjusted_forecast)

print(paste("Original SMAPE:", original_smape))
print(paste("Adjusted SMAPE:", adjusted_smape))
#### 54.7


## 로그 변환 적용
log_forecast <- log(rtest$forecast + 1)
log_actual_previous_week <- log(rtest2$PC + 1)

# 선형 조정
alpha_log <- sum(log_actual_previous_week * log_forecast) / sum(log_forecast^2)
adjusted_log_forecast <- alpha_log * log_forecast

# 역변환
rtest$adjusted_log_forecast <- exp(adjusted_log_forecast) - 1

original_smape <- smape(rtest$PC, rtest$forecast)
adjusted_smape <- smape(rtest$PC, rtest$adjusted_log_forecast)

print(paste("Original SMAPE:", original_smape))
print(paste("Adjusted SMAPE:", adjusted_smape))
#### 52.14


## 제곱근 변환 적용
sqrt_forecast <- sqrt(rtest$forecast)
sqrt_actual_previous_week <- sqrt(rtest2$PC)

# 선형 조정
alpha_sqrt <- sum(sqrt_actual_previous_week * sqrt_forecast) / sum(sqrt_forecast^2)
adjusted_sqrt_forecast <- alpha_sqrt * sqrt_forecast

# 역변환
rtest$adjusted_sqrt_forecast <- adjusted_sqrt_forecast^2

original_smape <- smape(rtest$PC, rtest$forecast)
adjusted_smape <- smape(rtest$PC, rtest$adjusted_sqrt_forecast)

print(paste("Original SMAPE:", original_smape))
print(paste("Adjusted SMAPE:", adjusted_smape))
## 52.88

## 임계값 설정
lower_threshold <- min(rtest2$PC)
upper_threshold <- max(rtest2$PC)

# 클리핑
rtest$clipped_forecast <- pmin(pmax(rtest$forecast, lower_threshold), upper_threshold)

original_smape <- smape(rtest$PC, rtest$forecast)
adjusted_smape <- smape(rtest$PC, rtest$clupped_forecast)

print(paste("Original SMAPE:", original_smape))
print(paste("Adjusted SMAPE:", adjusted_smape))
## 52.88

alpha <- 0.5
rtest2$exp_smoothed <- HoltWinters(rtest2$PC, alpha=alpha, beta=FALSE, gamma=FALSE)$fitted[,1]

