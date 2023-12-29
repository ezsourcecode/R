# 데이터의 기본 특성
## 범주형 변수의 빈도수, 상대도수 구하기
### 절대 빈도수 구하기
library(MASS)
data <- data.frame(Cars93)

str(data)
summary(data)
table(data$Manufacturer)
### 상대도수 구하기: prop.table()
prop.table(summary(data$Manufacturer)) * 100

### 테이블 형태로 표현: 데이터와 빈도수 함께 추출
data.frame('Freq' = table(data$Manufacturer),
           'Prop' = paste0('(' ,round(prop.table(table(data$Manufacturer)) * 100, 2), '%)'))

## 연속형 변수의 평균, 표준편차 구하기
### summary(): 기초 통계량
mean(data$Price)
sd(data$Price)
paste(round(mean(data$Price), 1), '±', round(sd(data$Price), 1))
## 기술통계 분석에 유용한 함수
install.packages('moonBook')
library(moonBook)
mytable(data) # 보고서 작성시 유용 #
#                 Descriptive Statistics                   
# —————————————————————————————————————————————————————————————— 
#                         Mean ± SD or %     N  Missing (%)
# —————————————————————————————————————————————————————————————— 
# Manufacturer            unique values  32  93   0  ( 0.0%)
# Model                   unique values  93  93   0  ( 0.0%)
# Type                                       93   0  ( 0.0%)
# - Compact                   16  (17.2%)                 
# - Large                     11  (11.8%)                 
# - Midsize                   22  (23.7%)                 
# - Small                     21  (22.6%)                 
# - Sporty                    14  (15.1%)                 
# - Van                         9  (9.7%)                 
# Min.Price                     17.1 ± 8.7  93   0  ( 0.0%)
# Price                         19.5 ± 9.7  93   0  ( 0.0%)
# Max.Price                    21.9 ± 11.0  93   0  ( 0.0%)
# MPG.city                      22.4 ± 5.6  93   0  ( 0.0%)
# MPG.highway                   29.1 ± 5.3  93   0  ( 0.0%)
# AirBags                                    93   0  ( 0.0%)
# - Driver & Passenger        16  (17.2%)                 
# - Driver only               43  (46.2%)                 
# - None                      34  (36.6%)                 
# DriveTrain                                 93   0  ( 0.0%)
# - 4WD                       10  (10.8%)                 
# - Front                     67  (72.0%)                 
# - Rear                      16  (17.2%)                 
# Cylinders                                  93   0  ( 0.0%)
# - 3                           3  (3.2%)                 
# - 4                         49  (52.7%)                 
# - 5                           2  (2.2%)                 
# - 6                         31  (33.3%)                 
# - 8                           7  (7.5%)                 
# - rotary                      1  (1.1%)                 
# EngineSize                     2.7 ± 1.0  93   0  ( 0.0%)
# Horsepower                  143.8 ± 52.4  93   0  ( 0.0%)
# RPM                       5280.6 ± 596.7  93   0  ( 0.0%)
# Rev.per.mile              2332.2 ± 496.5  93   0  ( 0.0%)
# Man.trans.avail                           93   0  ( 0.0%)
# - No                        32  (34.4%)                 
# - Yes                       61  (65.6%)                 
# Fuel.tank.capacity            16.7 ± 3.3  93   0  ( 0.0%)
# Passengers                     5.1 ± 1.0  93   0  ( 0.0%)
# Length                      183.2 ± 14.6  93   0  ( 0.0%)
# Wheelbase                    103.9 ± 6.8  93   0  ( 0.0%)
# Width                         69.4 ± 3.8  93   0  ( 0.0%)
# Turn.circle                   39.0 ± 3.2  93   0  ( 0.0%)
# Rear.seat.room                27.8 ± 3.0  91   2  ( 2.2%)
# Luggage.room                  13.9 ± 3.0  82  11  (11.8%)
# Weight                    3072.9 ± 589.9  93   0  ( 0.0%)
# Origin                                    93   0  ( 0.0%)
# - USA                       48  (51.6%)                 
# - non-USA                   45  (48.4%)                 
# Make                    unique values  93  93   0  ( 0.0%)
# —————————————————————————————————————————————————————————————— 
