# 
library(readxl)
# load data
bike <- read.csv('C:/k_digital/data/SeoulBikeData.csv')
summary(bike)

# 회귀 - 예측
names(bike)
## Date: 대여일(년-월-일)
## Rented.Bike.Count: 대여 자전거 수
## Hour: 대여 시간
## Temperature: 온도
## Humidity: 습도(%)
## Wind.speed(m/s)
## Visibility: 가시성(10m)
## Dew.point.temperature: 이슬점
## Solar.Radiation: 일사량
## Rainfall: 강수량
## Snowfall: 적설량
## Seasons: 계절
## Holiday: 공휴일 / 주말
## Functioning.Day: 비근무시간(NoFunc), 근무시간(Fun)

# scatter plot: 온도와 자전거 대여수의 상관성
plot(x = bike$Temperature, y = bike$Rented.Bike.Count)

# 선형 회귀 분석
## 회귀방정식 y = ax + b 
bmodel<- lm(Rented.Bike.Count ~ Temperature, bike)
# Coefficients:
# (Intercept)  Temperature  
# 329.95        29.08 
summary(bmodel)
# Adjusted R-squared:   0.29로 온도 하나만으로 예측 모델 29% 굉장히 의미없음 다른 변수가 더 필요함

## 예측 y = ax + b
## a = 29.08 b = 329.95
temp_Temperature = 23
a = 29.08 
b = 329.95
y = a * temp_Temperature + b
y

# 회귀선 추가
plot(x = bike$Temperature, y = bike$Rented.Bike.Count)
abline(a = b, b = a, col = 'red')

# 여러 개의 값을 이용한 예측
temperature_list = c(-10, 0, 10, 20, 30, 40)
new <- data.frame(Temperature = temperature_list)
pred_list <- predict(bmodel, newdata = new)
#        1          2          3          4          5          6 
# 39.14152  329.95251  620.76350  911.57449 1202.38548 1493.19647 

data.frame(Temperature = temperature_list, pred_bike_count = pred_list)
# Temperature pred_bike_count
# 1         -10        39.14152
# 2           0       329.95251
# 3          10       620.76350
# 4          20       911.57449
# 5          30      1202.38548
# 6          40      1493.19647
