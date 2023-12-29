# 선형회귀: 독립변수와 종속변수 간의 관계를 모델링하는 기법
## 단순 선형 회귀: 하나의 독립변수
## 다중 선형 회귀: 독립변수가 2개 이상인 경우

## 전제 조건
### 독립변수 x는 고정된 값
### 오차항의 분산이 동일(등분산)
### 오차항은 정규 분포를 따른다.
### 독립변수간 독립

#cars - speed(자동차 속도), dist(제동거리)
cor(cars$speed, cars$dist) # [1] 0.8068949

# 회귀모델
m <-lm(dist ~ speed, cars)
# Coefficients:
# (Intercept)        speed  
# -17.579        3.932  

# 회귀 방정식 dist = -17.579 + 3.932 * speed

# 회귀모델 요약보고서
summary(m)
# Residuals: 잔차값
#   Min      1Q  Median      3Q     Max 
# -29.069  -9.525  -2.272   9.215  43.201

## 회귀 계수
coef(m)

## 예측값(Fitted Values) y = ax + b
fitted(m)[1:4]
#         1         2         3         4
# -1.849460 -1.849460  9.947766  9.947766

## 잔차: 예측 값과 실제 값 차이
residuals(m)[1:4]
#        1         2         3         4 
# 3.849460 11.849460 -5.947766 12.052234 

## cars$dist = fitted(m) + residuals(m)
fitted(m)[1:4] + residuals(m)[1:4]
# 1  2  3  4 
# 2 10  4 22

## 계수의 신뢰구간
confint(m)
#                 2.5 %    97.5 %
# (Intercept) -31.167850 -3.990340
# speed         3.096964  4.767853

## 잔차 제곱 합
deviance(m) # [1] 11353.52 아래는 풀어 쓴 것
sum((cars$dist - predict(m, newdata = cars))^2)

## 예측
predict(m, newdata = cars)

