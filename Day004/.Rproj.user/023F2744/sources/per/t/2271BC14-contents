# 데이터 정제: 이상치와 결측치 처리
## 결측치(missing values): 누락된 값
### is.na() 결측값 T/F 판단
### na.omit(): NA 결측값이 존재하는 행 제거
### na.rm = T/F 계산시 제외할지 여부 결정
str(airquality)
head(is.na(airquality))
table(is.na(airquality)) # table로 결측값 확인 #
table(is.na(airquality$Temp)) # 결측치가 없어  FALSE만 나옴 #
table(is.na(airquality$Ozone)) # 결측치 TRUE가 44 나옴 #

mean(airquality$Temp) # [1] 77.88235
mean(airquality$Ozone) # 결측치가 있어 계산이 안 됨 [1] NA

# Ozone에서 결측값이 아닌 데이터만 추출
air_narm <- airquality[!is.na(airquality$Ozone), ]
mean(air_narm$Ozone) # [1] 42.12931

air_omit <- na.omit(airquality)
mean(air_omit$Ozone) # [1] 42.0991

mean(airquality$Ozone, na.rm = T) # [1] 42.12931

## 이상치(outlier)
patients <- data.frame(name = c('환자1', '환자2', '환자3', '환자4', '환자5'),
                       age = c(22, 30, 41, 27, 38),
                       gender = factor(c('M', 'F', 'M', 'K', 'F')),
                       blood.type = factor(c('A', 'O', 'B', 'AB', 'C')))
str(patients)
### 성별에서 이상치를 제거하고 추출
patients_omit <- patients[patients$gender == 'M' | patients$gender == 'F', ]
### patients에서 성별과 혈액형의 이상치를 제거하고 추출
patients_outlier <- patients[(patients$gender == 'M' | patients$gender == 'F') & 
                               (patients$blood.type == 'A' | patients$blood.type == 'B' | patients$blood.type == 'AB' | patients$blood.type == 'O'), ]

patients1 <- data.frame(name = c('환자1', '환자2', '환자3', '환자4', '환자5'),
                       age = c(22, 30, 41, 27, 38),
                       gender = c(1, 2, 1, 3, 2),
                       blood.type = c(1, 3, 2, 4, 5))
## 성별의 이상치를 결측치 처리
table(patients1$gender)
patients1$gender <- ifelse(patients1$gender < 1 | patients1$gender > 2, NA, patients1$gender)
## 혈액형의 이상치를 결측치 처리
table(patients1$blood.type)
patients1$blood.type <- ifelse(patients1$gender < 1 | patients1$blood.type > 4, NA, patients1$blood.type)

## 이상치를 판단하기 어려운 데이터의 처리
boxplot(airquality[, 1:4])
boxplot(airquality[, 1])$stats

## Ozone 컬럼에 이상치를 찾아 결측처리
air <- airquality
air$Ozone <- ifelse(air$Ozone < 1 | air$Ozone > 122, NA, air$Ozone)
table(is.na(air$Ozone)) # 이상치를 결측치로 바꾼 후 39개가 됨

## cars 데이터셋의 dist 이상치를 제거한 후 dist의 평균을 계산하시오.
### 단, 이상치 판단은 boxplot()을 사용할 것
C <- cars
boxplot(C[, 2])$stats
table(is.na(C$dist)) # 이상치 제거 전 FALSE 50 후 FALSE 49 
C$dist <- ifelse(C$dist < 2 | C$dist > 93, NA, C$dist)
mean(C$dist, na.rm = T) # [1] 41.40816

## ChickWeight 데이터에서 병아리 무게(weight)의 이상치를 제거한 후 평균 무게를 구하시오.
### 단, 이상치 판단은 boxplot()을 사용할 것
chick <- ChickWeight
boxplot(chick[, 1])$stats
table(is.na(chick$weight)) # 이상치 제거 전 FALSE 578 후 FALSE 569
chick$weight <- ifelse(chick$weight < 35 | chick$weight > 309, NA, chick$weight)
mean(chick$weight, na.rm = T) # [1] 118.4271
