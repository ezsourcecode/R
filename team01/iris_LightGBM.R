# 데이터 로드
data(iris)
data <- iris

# 타겟 변수와 특성 변수 분리
target <- data$Species
features <- data[, -5]  # Species 변수 제외

# LightGBM 데이터셋 생성
train_data <- lgb.Dataset(data = as.matrix(features), label = as.numeric(target) - 1)

# LightGBM 모델 파라미터 설정
params <- list(
  objective = "multiclass",
  num_class = 3,  # 분류 클래스 수
  metric = "multi_logloss"  # 손실함수
)

# 모델 학습
model <- lgb.train(
  params = params,
  data = train_data,
  nrounds = 100,  # 학습 라운드 수
  verbose = 1
)

# 예측
predictions <- predict(model, as.matrix(features))

# 예측 결과 확인
head(predictions)