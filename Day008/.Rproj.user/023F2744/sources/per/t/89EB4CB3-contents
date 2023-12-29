# data() r이 제공하는 데이터셋 목록 출력됨
str(iris)

## 데이터 설명
### Sepal.Width 꽃받침의 너비 cm
### Sepal.Length 꽃받침의 길이
### Petal.Width 꽃잎의 너비
### Petal.Length 꽃잎의 길이
### Species 붓꽃의 품종 setosa, versicolor, virginica, 범주형 변수

## 데이터 내용 확인
head(iris, 10)

# 3차원 배열형태로 저장된 iris3 데이터 셋 
iris3

# 기술통계
summary(iris)
# 시각화 - 다변량 상관분석
plot(iris)
plot(iris$Sepal.Length)
plot(iris$Species)
plot(iris$Species ~ ., data = iris) # iris$Species ~ ., 품종과 품종 제외한 모든 것을 비교 #
plot(iris$Sepal.Length, col = as.numeric(iris$Species))
plot(iris$Sepal.Width, col = as.numeric(iris$Species))
plot(iris$Petal.Length, col = as.numeric(iris$Species))
plot(iris$Petal.Width, col = as.numeric(iris$Species))

install.packages('caret')
library(caret)

featurePlot(iris[, 1:4], iris$Species, 'ellipse')

# 정규화 - 로그 변환, z-value
scale(iris[1:4])
cbind(as.data.frame(scale(iris[1:4])), iris$Species)

# 주성분 분석: PCA 차원축소 알고리즘 - 비지도 학습
p <- princomp(iris[, 1:4], cor = T)
summary(p)
# Importance of components:
#                           Comp.1    Comp.2     Comp.3      Comp.4
# Standard deviation     1.7083611 0.9560494 0.38308860 0.143926497 # 
# Proportion of Variance 0.7296245 0.2285076 0.03668922 0.005178709 # 설명력
# Cumulative Proportion  0.7296245 0.9581321 0.99482129 1.000000000 # 누적합

plot(p, type = 'l') # 보통 확 꺾이는 comp.3 이전을 주성분으로 선택 #

# Decision Tree: 의사결정 트리
## 예측력이 떨어져 모델 성능은 낮지만 이해하기 쉽고 직관적인 알고리즘
## 앙상블 기법
## 의사결정 트리 관련 패키지: rpart, party, tree
## rpart, tree 패키지는 과대적합을 해결하기 위해 가지치기가 필요
## party는 입력 변수의 레벨이 31개로 제한

# 품종 레벨 확인
levels(iris$Species) # [1] "setosa"     "versicolor" "virginica" 

# 분할: train과 test를 분리해서 학습한다.
## train - 70%(80%), test - 30%(20%) 보통(적음)
## train - 60%, test - 20%, vaild - 20% 요즘 데이터 양 많을 때

# iris 행수
nrow(iris) # [1] 150

# 품종별 레코드 수
table(iris$Species)

head(iris, 10)
tail(iris, 10)

# createDataPartition(y, p, list)
## y - 추출할 팩터
## p - 비율
## list - 추출할 벡터의 위치 정보(리스트 타입으로 받을 때 T)

iris_row_idx <- createDataPartition(iris$Species, p = 0.8, list = F)
str(iris_row_idx)

iris_train <- iris[iris_row_idx, ]
table(iris_train$Species)

iris_test <- iris[-iris_row_idx, ]
table(iris_test$Species)

# 의사결정 트리 패키지 설치
install.packages('rpart')
library(rpart)

# rpart(formula, data, control)
# 종속변수(반응변수) ~ 독립변수(설명변수)
model <- rpart(Species ~ ., data = iris_train, control = rpart.control(minsplit = 2)) # minsplit 분리 시 최소 데이터 #
model
# 시각화
install.packages('rpart.plot')
library(rpart.plot)

rpart.plot(model)

# 가지치기(CP)
## CP값 조회
model$cptable
# CP nsplit rel error xerror       xstd
# 1 0.5000      0    1.0000 1.2375 0.05202914
# 2 0.4500      1    0.5000 0.9375 0.06629126
# 3 0.0125      2    0.0500 0.0875 0.03209280
# 4 0.0100      5    0.0125 0.0875 0.03209280
model_prune <- prune(model, cp = 0.0125)
rpart.plot(model_prune)

# party 패키지 - ctree()
install.packages('party')
library(party)

# ctree(formula, data)
iris_ctree <- ctree(Species ~  .,data = iris_train)
iris_ctree

plot(iris_ctree, type = 'simple') # 밑에 막대그래프 안 나옴#
plot(iris_ctree)

# 예측하기: predict(model, new_data, type = class, prob)
str(iris_test)
predict(model, newdata = iris_test, type = 'class')

# 실제값과 예측값을 데이터 프레임으로 생성
## actual: 실제 값 expect: 예측 값
actual <- iris_test$Species
expect <- predict(model, newdata = iris_test, type = 'class')
result_df <- data.frame(actual, expect)
result_df

# 혼동행렬 confusion Matrix
table(result_df)
#             expect
# actual       setosa versicolor virginica
# setosa         10          0         0
# versicolor      0          9         1
# virginica       0          0        10
# 정확도
(10 + 10 + 9) /nrow(iris_test) # [1] 0.9666667
