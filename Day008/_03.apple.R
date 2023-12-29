# 데이터 불러오기: 클립보드 데이터를 데이터 프레임으로 변환
apple_df <- read.table(file = 'clipboard', header = T, sep = '\t', stringsAsFactors = T)

summary(apple_df)

# 품종에 따른 무게, 당도, 산도 분포 시각화
boxplot(weight ~ model, data = apple_df, ylab = '무게')
boxplot(sugar ~ model, data = apple_df, ylab = '당도')
boxplot(acid ~ model, data = apple_df, ylab = '산도')

boxplot(color ~ model, data = apple_df, ylab = '색깔')

library(caret)

# 훈련 데이터 분리 (전체 데이터의 80%): apple_train_idx
apple_row_idx <- createDataPartition(apple_df$model, p = 0.8, list = F)
str(apple_row_idx)

# 훈련 데이터
apple_train_idx <- apple_df[apple_row_idx, ]
table(apple_train_idx$model)
# 로얄후지   미시마   아오리     홍로     홍옥 
# 4        4        4        4        4 

# 테스트 데이터
apple_test_idx <- apple_df[-apple_row_idx, ]
table(apple_test_idx$model)
# 로얄후지   미시마   아오리     홍로     홍옥 
# 1        1        1        1        1 

# 훈련 데이터를 기반으로 분류 모델 생성: rpart
# rpart(formula, data, control)
# 종속변수(반응변수) ~ 독립변수(설명변수)
amodel <- rpart(model ~ ., data = apple_train_idx, control = rpart.control(minsplit = 2))
amodel

# rpart.plot 시각화
rpart.plot(amodel)

# 실제값과 예측한 값 한 눈에 비교할 수 있는 데이터 프레임
amodel$cptable
# CP nsplit rel error xerror       xstd
# 1 0.2500      0    1.0000 1.2500 0.00000000
# 2 0.1875      3    0.2500 1.2500 0.00000000
# 3 0.0625      4    0.0625 0.1250 0.08385255
# 4 0.0100      5    0.0000 0.1875 0.09980450
aprune <- prune(amodel, cp = 0.0100)
aprune
rpart.plot(aprune)
library(party)
apple_ctree <- ctree(model ~ ., data = apple_train_idx)
apple_ctree
plot(apple_ctree)

predict(amodel, newdata = apple_test_idx, type = 'class')
# 1       14       19       24       25 
# 아오리   아오리     홍옥   미시마 로얄후지 
actual <- apple_test_idx$model
expect <- predict(amodel, newdata = apple_test_idx, type = 'class')
result_df <- data.frame(actual, expect)
result_df
#      actual   expect
# 1    아오리   아오리
# 14     홍로   아오리
# 19     홍옥     홍옥
# 24   미시마   미시마
# 25 로얄후지 로얄후지

# 혼돈행렬
#           table(result_df)
# ctual     로얄후지 미시마 아오리 홍로 홍옥
# 로얄후지        1      0      0    0    0
# 미시마          0      1      0    0    0
# 아오리          0      0      1    0    0
# 홍로            0      0      1    0    0
# 홍옥            0      0      0    0    1

# 정확도
(1 + 1 + 1 + 1) / nrow(apple_test_idx) # [1] 0.8
