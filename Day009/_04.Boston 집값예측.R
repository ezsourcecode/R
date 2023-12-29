library(MASS)
# 보스턴 집값 예측: 회귀분석(선형회귀)
data(Boston)
# 해당 데이터셋을 파일로 저장
write.csv(Boston, file = 'boston.csv', row.names = T)
df <- read.csv('boston.csv', header = T, stringsAsFactors = F)

# 종속변수에 해당하는 medv(집값)을 제외하고 데이터 추출
df <- df[, -1]
df

# 변수의 의미
## crim: 1인당 범죄율
## zn: 25,000 초과하는 거주지역의 비율
## indus: 비상업지역이 점유하는 토지의 비율
## chas: 찰스강 경계 1 or 0
## nox: 10PPM당 일산화질소
## rm: 평균 방의 개수
## age: 1940이년 이전에 건축된 소유주택 비율
## dis: 직업센터까지의 접근성 지수
## rad: 도시고속도로까지의 접근성 지수
## tax: 재산세율
## ptratio: 학생과 교사의 비율
## black: 흑인의 비율
## lstat: 저소득층 비율
## medv: 주택가격(단위 1,000$)

install.packages('Hmisc')
library(Hmisc)
describe(df)
summary(medv ~ crim + zn, data = df)

# 데이터 전처리
## 결측치 확인
sum(is.na(df))

df[complete.cases(df), ] # 결측치가 없으면 TRUE

head(df, 10)

# 결측치 삭제
df <- na.omit(df)
# 결측치 대체
df$crim[is.na(df$crim)] <- 0 # NA값 0으로 대체
mean_crim <- mean(df$crim) # 평균으로 대체

# 데이터 분할 - 학습, 성능평가
nrow(df) # [1] 506
## 랜덤 샘플링: train(70%), test(30%)
df_idx <- sample(1:506, 300)
df_train <- df[df_idx, ]
df_test <- df[-df_idx, ]
df_test <- df_test[, -14]
nrow(df_train) # [1] 300
nrow(df_test) # [1] 206

# 다중회귀분석
result <- lm(medv ~ ., data = df_train)
summary(result) # Adjusted R-squared:  0.7273 설명력이 실제 집값을 맞출 확률이 72%정도 #
# Residuals:
#   Min       1Q   Median       3Q      Max 
# -10.9062  -2.6879  -0.4337   1.5761  25.5019 
# 
# Coefficients:
#               Estimate Std. Error t value Pr(>|t|)    
# (Intercept)  33.885829   6.154033   5.506 8.16e-08 ***
# crim         -0.103739   0.035988  -2.883  0.00424 ** 
# zn            0.048132   0.016497   2.918  0.00381 ** 
# indus         0.005089   0.076399   0.067  0.94694    
# chas          3.072391   1.205134   2.549  0.01131 *  
# nox         -18.595546   4.692609  -3.963 9.36e-05 ***
# rm            4.026249   0.521488   7.721 1.95e-13 ***
# age           0.002151   0.015748   0.137  0.89143    
# dis          -1.287307   0.250527  -5.138 5.14e-07 ***
# rad           0.309111   0.084845   3.643  0.00032 ***
# tax          -0.010564   0.004925  -2.145  0.03282 *  
# ptratio      -0.976824   0.161988  -6.030 5.05e-09 ***
# black         0.008799   0.003433   2.563  0.01089 *  
# lstat        -0.461572   0.061198  -7.542 6.17e-13 ***
# ---
# Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
# 
# Residual standard error: 4.508 on 286 degrees of freedom
# Multiple R-squared:  0.7392,	Adjusted R-squared:  0.7273 
# F-statistic: 62.35 on 13 and 286 DF,  p-value: < 2.2e-16

## 다중공선선: 독립변수들 간에 지나친 상관관계가 존재한다면, 그 데이터의 설명력은 낮아짐
### 팽창지수(vif)
install.packages('car')
library(car)
vif(result) # 팽창지수 값이 10이상이면 다중공선성이 발생했다고 간주. 사람에 따라 5만 넘어도 간주함
# crim        zn     indus      chas       nox        rm       age       dis 
# 1.769441  2.228291  3.904119  1.082380  4.498097  1.778879  3.104897  4.119084 
# rad       tax   ptratio     black     lstat 
# 8.150871 10.183029  1.762875  1.370071  2.650832 

# 이상치 분석
outlierTest(result)

# 상관관계 - 시각화, 통계량(cor)
plot(df_train) # 4번째 열 chas 값이 0,1만 있음 제외


# 회귀분석 결과 - 요약보고서
rcrim <- df

# 변수 선택
## 전진 선택법(forward selection): 절편만 있는 모델에서 가장 많이 개선시키는 변수를 차례대로 추가하는 방법
## 변수 소거법(backward elimination): 모든 변수가 포함된 모델에서 기준 통계치에 가장 도움이 되지 않는 변수를 하나씩 제거하는 방법
## 단계적 방법(stepwise selection): 모든 변수가 포함된 모델에서 시작하여 기준 통계치에 가장 도움이 되지 않는 변수를 삭제하거나 모델에서 빠져 있는 변수 중에서 기준 통계치를 가자아 개선시키는 변수를 추가하는 방법

model <- lm(medv ~ ., df_train)
model2 <- step(model, direction = 'both') # step(단계적 변수 선택)
# AIC: 통계 모델 간의 적합성을 비교하는 모델 지표
# AIC가 작을수록 더 좋은 모델을 의미한다.
# Step:  AIC=913.23
# medv ~ crim + zn + chas + nox + rm + dis + rad + tax + ptratio + black + lstat
# 
#           Df Sum of Sq    RSS    AIC
# <none>                 5813.1 913.23
# + age      1      0.37 5812.7 915.21
# + indus    1      0.08 5813.0 915.22
# - tax      1    109.53 5922.6 916.83
# - chas     1    134.49 5947.6 918.09
# - black    1    134.74 5947.9 918.10
# - crim     1    168.99 5982.1 919.82
# - zn       1    174.22 5987.3 920.09
# - rad      1    289.23 6102.3 925.79
# - nox      1    372.74 6185.8 929.87
# - dis      1    644.62 6457.7 942.78
# - ptratio  1    752.82 6565.9 947.76
# - lstat    1   1248.05 7061.2 969.57
# - rm       1   1253.65 7066.8 969.81
model3 <- lm(medv ~ crim + zn + chas + nox + rm + dis + rad + tax + ptratio + 
               black + lstat, df_train)
# Coefficients:
# (Intercept)         crim           zn         chas          nox           rm  
# 33.780457    -0.103718     0.047856     3.084590   -18.315039     4.036411  
# dis          rad          tax      ptratio        black        lstat  
# -1.301758     0.306364    -0.010406    -0.972972     0.008811    -0.458947
summary(model3)
# Residuals:
#     Min       1Q   Median       3Q      Max 
# -10.9048  -2.6711  -0.4224   1.5781  25.5450 
# 
# Coefficients:
#               Estimate Std. Error t value Pr(>|t|)    
# (Intercept)  33.780457   6.092755   5.544 6.67e-08 ***
# crim         -0.103718   0.035846  -2.893 0.004101 ** 
# zn            0.047856   0.016289   2.938 0.003571 ** 
# chas          3.084590   1.194987   2.581 0.010338 *  
# nox         -18.315039   4.262002  -4.297 2.37e-05 ***
# rm            4.036411   0.512171   7.881 6.73e-14 ***
# dis          -1.301758   0.230350  -5.651 3.83e-08 ***
# rad           0.306364   0.080933   3.785 0.000187 ***
# tax          -0.010406   0.004467  -2.329 0.020526 *  
# ptratio      -0.972972   0.159318  -6.107 3.28e-09 ***
# black         0.008811   0.003410   2.584 0.010268 *  
# lstat        -0.458947   0.058365  -7.863 7.55e-14 ***
#   ---
# Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
# 
# Residual standard error: 4.493 on 288 degrees of freedom
# Multiple R-squared:  0.7392,	Adjusted R-squared:  0.7292 
# F-statistic: 74.19 on 11 and 288 DF,  p-value: < 2.2e-16

# model 결과
df_test <- df_test[,-14]
expect <- predict(model, newdata = df_test)
df_test <- df[-df_idx,]
actual <- df_test$medv

result_df <- data.frame(actual, expect)
result_df
#     actual    expect
# 1     24.0 29.537242
# 4     33.4 28.278065
# 7     22.9 23.121417
# 8     27.1 20.230874
# 11    15.0 19.895434
# 17    23.1 19.828122
# 20    18.2 17.881696
t.test(result_df)
# One Sample t-test
# 
# data:  result_df
# t = 51.863, df = 411, p-value < 2.2e-16
# alternative hypothesis: true mean is not equal to 0
# 95 percent confidence interval:
#   22.29423 24.05083
# sample estimates:
#   mean of x 
# 23.17253 

# model2 결과
df_test <- df_test[,-14]
expect <- predict(model2, newdata = df_test)
df_test <- df[-df_idx,]
actual <- df_test$medv

result_df <- data.frame(actual, expect)
result_df
#     actual    expect
# 1     24.0 29.554054
# 4     33.4 28.286172
# 7     22.9 23.088065
# 8     27.1 20.147697
# 11    15.0 19.815848
# 17    23.1 19.904609
# 20    18.2 17.892105
t.test(result_df)
# One Sample t-test
# 
# data:  result_df
# t = 51.859, df = 411, p-value < 2.2e-16
# alternative hypothesis: true mean is not equal to 0
# 95 percent confidence interval:
#   22.29342 24.05011
# sample estimates:
#   mean of x 
# 23.17177

# model3 결과
df_test <- df_test[,-14]
expect <- predict(model3, newdata = df_test)
df_test <- df[-df_idx,]
actual <- df_test$medv

result_df <- data.frame(actual, expect)
result_df
#     actual    expect
# 1     24.0 29.554054
# 4     33.4 28.286172
# 7     22.9 23.088065
# 8     27.1 20.147697
# 11    15.0 19.815848
# 17    23.1 19.904609
# 20    18.2 17.892105
t.test(result_df)
# One Sample t-test
# 
# data:  result_df
# t = 51.859, df = 411, p-value < 2.2e-16
# alternative hypothesis: true mean is not equal to 0
# 95 percent confidence interval:
#   22.29342 24.05011
# sample estimates:
#   mean of x 
# 23.17177 


lmodel<- lm(medv ~ crim + zn + rm, df_train)
lmodel
# Coefficients:
# (Intercept)       crim           zn           rm  
# -25.71122     -0.20576      0.05603      7.71249 
summary(lmodel)
