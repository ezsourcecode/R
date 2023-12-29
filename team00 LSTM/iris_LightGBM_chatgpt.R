# LightGBM 모델 예제
library(lightgbm)
library(dplyr)

# 데이터 불러오기
data(iris)

# 라벨 값 수정 (0, 1, 2로 변경)
iris$Species <- as.numeric(factor(iris$Species)) - 1

# 트레이닝 데이터와 테스트 데이터 분리
set.seed(123)
indices <- sample(1:nrow(iris), nrow(iris) * 0.7)
train_data <- iris[indices, ]
test_data <- iris[-indices, ]
nrow(train_data)
nrow(test_data)
View(test_data)
# LightGBM 데이터셋으로 변환
train_data_lgb <- lgb.Dataset(data = as.matrix(train_data[, -5]), label = train_data$Species)
test_data_lgb <- lgb.Dataset(data = as.matrix(test_data[, -5]), label = test_data$Species, reference = train_data_lgb)

# LightGBM 모델 파라미터 설정
params <- list(
  objective = "multiclass",
  num_class = 3,
  metric = "multi_logloss",
  boosting_type = "gbdt",
  num_leaves = 31,
  learning_rate = 0.05,
  feature_fraction = 0.9,
  verbose_eval = TRUE
)

# 모델 훈련
model <- lgb.train(
  params = params,
  data = train_data_lgb,
  nrounds = 100,
  valids = list(test = test_data_lgb),  # 검증 데이터에 이름을 지정
  early_stopping_rounds = 10
)

# 예측 데이터 준비
predict_data <- as.matrix(test_data[, -5])

# 예측
predictions <- predict(model, data = predict_data)
predicted_labels <- max.col(predictions) - 1

# 정확도 계산
accuracy <- mean(predicted_labels == test_data$Species)
cat("Accuracy:", accuracy, "\n")


# 검증 데이터에 대한 평가 결과 확인
# valid_results <- model$eval
# print(valid_results)


















