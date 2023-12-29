# 추론통계분석: 가설검정
## A학원을 다니면 성적이 도움이 되느냐?

# 학원을 다니기 전 성적
before_study <- c(34, 76, 76, 63, 73, 75, 67, 78, 81, 53, 58, 81, 77, 80, 43, 65, 76, 63, 54, 64, 85, 54, 70, 71, 71, 55, 40, 78, 76, 100, 51, 93, 64, 42, 63, 61, 82, 67, 98, 59, 63, 84, 50, 67, 80, 83, 66, 86, 57, 48)
# 학원을 다닌 후 성적
after_study <- c(74, 87, 89, 98, 65, 82, 70, 70, 70, 84, 56, 76, 72, 69, 73, 61, 83, 82, 89, 75, 48, 72, 80, 66, 82, 71, 49, 54, 70, 65, 74, 63, 65, 101, 82, 75, 62, 83, 90, 76, 87, 90, 78, 63, 59, 79, 74, 65, 77, 74)

# boxplot() 비교
boxplot(before_study, after_study, names = c('수강 전', '수강 후'))

# t-검정: 집단간의 차이를 검증하는 도구, t.test()
## t.test(x, y, paired = T/F, var.equal = T/F, alternative = 양측검정, 단측검정)
### paired = T 대응표본, 한 집단으로부터 두 번 반복해 샘플을 추출하는 것
### paired = F 독립표본, 서로 독립된 집단에서 각 샘플을 추출하는 것
### alternative = 'two.sided' 두 집단이 서로 같은지 비교
### alternative = 'less', A less than B, A가 B보다 작은지 비교
### alternative = 'greater' A greater than B, A가 B보다 큰지 비교
## 반드시 선행되어야 하는 가정 - 정규분포

# 샘플이 30개 미만이면 정규분포 여부를 반드시 확인해야 한다. length()로 표본수 확인하면 좋음
# 동일집단을 대상으로 하는 대응표본
# 가설: 두 집단이 차이가 있다
# 대립가설: 두 집단이 차이가 있다
t.test(before_study, after_study, paired = T)
# p-value = 0.03973 # p값이 0.05보다 작아 대립가설이 채택되고, 귀무가설 기각 #

# 대립가설: 두 집단의 평균의 차가 0보다 크다 A - B > 0
# 귀무가설: 
t.test(before_study, after_study, paired = T, alternative = 'greater')
# p-value = 0.9801 # p값이 0.05보다 크기에 대립가설이 기각됨
# 수강 후 성적이 떨어진다는 것은 기각한다.

# 표본이 1개인 경우, 단일 표본 t 검정
## A회사의 건전지 수명시간이 1,000시간일 때
## 귀무가설: 건전지 수명은 1,000시간이다
## 대립가설: 건전지 수명은 1,000시간이 아니다
a <- c(980, 1003, 963, 1032, 1012, 1002, 996, 1102, 1017, 1003)
## 표본이 30개 미만으로 정규분포 여부 확인: Shapiro-wilk 검정
### 귀무가설: 정규분포를 따른다
### 대립가설: 정규분포를 따르지 않는다
shapiro.test(a)
# p-value = 0.0502 p값이 0.05보다 크므로 귀무가설 채택
## alternative = 'two.sided', 주어진 샘플이 평균과 다르다
## alternative = 'less', 샘플이 주어진 평균보다 작다
## alternative = 'greater', 샘플이 주어진 평균보다 크다
t.test(a, mu = 1000, alternative = 'two.sided')
# p-value = 0.3742 # p값이 0.05보다 큼
# 결론: 건전지의 평균 수명은 1,000시간이다.

# 수학 평균점수가 55점이다
# 0교시 실행후 학생들의 성적이 올랐다고 할 수 있는지
## 귀무가설: 오르지 않았다
## 대립가설: 성적이 올랐다
score <- c(58, 49, 39, 99, 32, 88, 62, 30, 55, 65, 44, 55, 57, 53, 33, 42, 39)
shapiro.test(score)
# p-value = 0.06308
t.test(score, ma = 55, alternative = 'two.sided')

## 피셔검정(Fisher's exact Test): 표본 수가 적거나 데이터의 분포가 치우진 경우에 적용
## fisher.test(data)
fisher.test(score)


# 정수기 회사 직원 채용 분석 - AS기사 채용 수요 분석 
purifier_df <- read.table(file = 'clipboard', header =T, sep = '\t', stringsAsFactors = T)
str(purifier_df)
## purifier: 총 정수기 대여 수(전월)
## old_purifier: 10년 이상 노후된 정수기 대여 수(전월)
## as_time: AS 소요시간(당월)

# 상관관계: 총 정수기 대여 수와 AS 시간의 상관관계
plot(purifier_df$purifier, purifier_df$as_time, xlab = '총 정수기 대여 수', ylab = 'AS 시간')

# 상관관계: 10년 이상 노후된 정수기의 대여 수와 AS 시간의 상관관계
plot(purifier_df$old_purifier, purifier_df$as_time, xlab = '노후 정수기 대수여' , ylab = 'AS 시간')

# 상관계수: 피어슨 상관계수, 스피어만 상관계수
cor(purifier_df$purifier, purifier_df$as_time) # method 생략하면 기본이 피어슨#
# 피어슨 [1] 0.9102497 스피어만 [1] 0.8653226
cor(purifier_df$old_purifier, purifier_df$as_time, method = 'spearman')
# 피어슨 [1] 0.8795908 스피어만 [1] 0.8935484

# 상관분석
# 구내식당의 음식값이 매출에 미치는 영향을 분석
## 귀무가설: 상관관계가 없다
## 대립가설: 상관관계가 있다
x <- c(70, 72, 62, 64, 71, 76, 0, 65, 74, 72) 
y <- c(70, 74, 65, 68, 72, 74, 61, 66, 76, 75)
cor.test(x, y, method = 'pearson')
# p-value = 0.008752  0.05보다 작아 귀무가설 기각  # 피어슨 상관계수 값 cor 0.7729264 

# R base 내장 데이터 women
str(women)
plot(women$height, women$weight)

# 상관계수
cor(women$height, women$weight)
# [1] 0.9954948

# 회귀분석: 독립변수와 종속변수
# 체중 = 기울기 * 신장 + 절편
# 종속변수 ~ 독립변수
model <- lm(women$weight ~ women$height) # 보통은 이렇게 씀 (weight ~ height, women)
# (Intercept)  women$height   # 절편 -87.52, 기울기 3.45
# -87.52          3.45  
# 체중 = 3.45 * 신장 - 87.52
# 신장이 180인 사람의 체중 예측
model$coefficients[[2]] * 180 + model$coefficients[[1]] # [1] 533.4833
summary(model)
# t value -14.74로 0보다 작아 귀무가설 기각 즉, 상관관계 있음
# Adjusted R-squared:  0.9903 모델의 설명력이 99%

# 회귀선
plot(women$height, women$weight) + abline(model)

# 자동차의 속도와 제동거리 데이터 셋
str(cars)
plot(cars$speed, cars$dist)
cor(cars$speed, cars$dist)
# 0.05보다 큰 강한 상관관계[1] 0.8068949

# lm(formula, data)
# 제동거리 ~ 속도
# 제동거리 ~ 속도 + 타이어 면적

head(cars, 10)
# 차 속도에 따른 제동거리를 확인하는 회귀분석
model <- lm(dist ~ speed, cars)
# (Intercept)        speed  # 기울기 -17.579 절편 3.932 summary Estimate Std. 부분이 더 정확한 수치
# -17.579        3.932 
summary(model)
# 예측 모델의 정확성  64% 정도 Adjusted R-squared:  0.6438 # p값 0.05 보다 작음 p-value: 1.49e-12
# 회귀방정식
## 제동거리 = 3.9324 * speed -17.5791
abline(model)

# 회귀분석 모델의 평가 요소
## 독립변수의 유의성, 모델의 정확도, 오차항의 정규성

## 가로 2 * 세로 2
par(mfrow = c(2, 2))
plot(model)

# 예측: 새로운 독립변수를 대입해서 종속변수의 값을 확인
# 점 추정과 구간 추정
# predict(model, data, interval, level)
model <- lm(dist ~ speed, cars)

# 독립변수에 여러 값을 담아 예측
speed <- c(50, 60, 70, 80, 90, 100)
new_input <- data.frame(speed)

## 예측 - 점 추정
predict(model, new_input)
result <- predict(model, new_input)
str(result)

cbind(new_input, result)

# 예측 - 구간 측정
## interval = 'confidence' 모델 계수의 불확실성을 감안한 구간 추정
## interval = 'prediction' 모델 계수의 불확실성과 결과의 오차를 감안한 구간추정
result <- predict(model, new_input, interval = 'confidence', level = 0.95)
# fit      lwr      upr
# 1 179.0413 149.8060 208.2766
# 2 218.3654 180.8489 255.8820
# 3 257.6895 211.8651 303.5139
# 4 297.0136 242.8670 351.1602
# 5 336.3377 273.8603 398.8151
# 6 375.6618 304.8480 446.4755
# 수치데이터의 기초 통계량
summary <- (purifier_df)

## 독립변수: 정수기 총 대여 수, 노후된 정수기 총 대여 수
## 종속변수: AS 시간
## 정수기 총 대여수 = 10 이전 대여 수 + 10 이후 대여 수
## 파생변수 young_purifier
purifier_df$y_purifier <- purifier_df$purifier - purifier_df$old_purifier

lm_result <-lm(as_time ~ y_purifier + old_purifier, purifier_df)
# (Intercept)    y_purifier  old_purifier  
# 193.73664       0.08881       0.23977  
summary(lm_result)
# Adjusted R-squared:  0.9996 모델 정확성 99% 정도 p-value: < 2.2e-16
# AS 시간 = 0.08881 * 10년 미만 + 0.23977 * 10년 이후 + 193.73664
## 월말 총 대여수 300,000대, 그 중 10년 이상이 70,000이라고 한다면 
## 예측 - 점 추정
input_predict <- data.frame(y_purifier = 230000, old_purifier = 70000)
result <- predict(lm_result, input_predict)
# 37403.09
# AS기사 1명이 한 달간 처리하는 AS 시간 : 8시간 * 20일 160시간
result / (8 * 20) # 233.7693명 필요

# 구간추정
result <- predict(lm_result, input_predict, interval = 'confidence', level = 0.95)
#         fit      lwr      upr
# 1 37403.09 37283.69 37522.48