# R을 이용한 통계분석: 기술통계분석과 추론통계분석
## 수치형 자료를 분석하는 방법: 기술 통계량

## 수치형 자료를 분석하는 작업: 기술 통계량
x <- c(64, 84, 82, 81, 68, 85, 76, 89, 93, 77, 66, 64, 86, 74, 64, 70, 53, 98, 59, 79, 57, 59, 65, 67, 80)

### 평균
mean(x) # 73.6

### 중앙값
median(x) # 74

### 최소값, 최대값
min(x) # 53
max(x) # 98

## A, B, C 식당의 배달 시간을 이용해서 가장 빠른 배달을 하는 식당을 찾는 작업
storeA <- c(20, 21, 23, 22, 26, 28, 35, 35, 41, 42, 43, 45, 44, 45, 46, 47, 47, 46, 47, 58, 58, 59, 60, 56, 57, 57, 80)
storeB <- c(5, 6, 11, 13, 15, 16, 20, 20, 21, 23, 22, 27, 27, 30, 30, 32, 36, 37, 37, 40 ,40 ,43, 44, 45, 51, 54, 70, 600)
storeC <- c(5, 5, 5, 12, 10, 11, 20, 20, 20, 20, 20, 21, 20, 30, 32, 31, 31, 31, 36, 40, 40, 51, 61, 51, 61, 61, 70)

# A와 B를 비교해서 가장 빠르게 배달하는 식당은?
mean(storeA) # 44
mean(storeB) # 50.53571

median(storeA) # 45
median(storeB) # 30

quantile(storeA)
#   0%  25%  50%  75% 100% 
# 20.0 35.0 45.0 56.5 80.0 
quantile(storeB)
#   0%    25%    50%    75%   100% 
# 5.00  20.00  30.00  40.75 600.00
# boxplot()
boxplot(storeA, storeB, names = c('A식당', 'B식당'))
points(c(mean(storeA), mean(storeB)), pch = 2, col = 'red', cex = 2)
# B 식당의 이상치를 제거한 후 배달시간
storeB <- storeB[storeB < 600]

mean(storeC) # [1] 30.18519
quantile(storeC)
# 0%  25%  50%  75% 100% 
# 5   20   30   40   70 
boxplot(storeB, storeC, names = c('B식당', 'C식당'))

# 구간별 데이터의 분포를 확인하는 시각화 도구
## 히스토그램: 연속형 데이터, hist(데이터, main = 차트제목, xlab, ylab)
## 막대그래프: 이산형 데이터(범주형 데이터), boxplot
hist(storeB, main = 'B식당 배달시간', xlab = '배달 시간 구간', ylab = '배달 건수')
hist(storeC, main = 'C식당 배달시간', xlab = '배달 시간 구간', ylab = '배달 건수')

# 분산과 표준편차
# 첨도와 왜도
var(storeB) # 분산 [1] 239.5413 더 모여있어 안정적
var(storeC) # 분산 [1] 355.6952
sd(storeB) # 표준편차 [1] 15.47712 더 안정적인 시간대가 확보됨
sd(storeC) # 표준편차 [1] 18.85988
## B식당: 평균 배달 시간 30분, 15 ~ 45분
## C식당: 평균 배달 시간 30분, 12 ~ 48분 

# 범주형 데이터 분석: 파이차트, 막대그래프
bloodtype <- c('A', 'B', 'A', 'AB', 'O', 'A', 'O', 'B', 'A', 'O', 'O', 'B', 'O', 'A', 'AB', 'B', 'O', 'A', 'A', 'B')
# 도수분포표
table(bloodtype)
length(bloodtype)
# pie(데이터, 범주명, col, lty, main) # 파이차트를 그리려면 도수분포표값이 필요함 #
pie(table(bloodtype), labels = c('A형', 'AB형', 'B형', 'O형'), 
    col = c('lightcyan', 'lightyellow', 'white', 'lightgray'), # col = heat.colors(4) #
    lty = 2, main = '우리반 혈액형 분포도')
tb <- addmargins(table(bloodtype))

# 막대차트 barplot(height, names.arg, space, horiz = T/F, main, xlab, ylab, col, beside, xlim, ylim)
barplot(table(bloodtype))
barplot(table(bloodtype),
        names.arg = c('A형', 'AB형', 'B형', 'O형'),
        main = '우리반 혈액형 분포도',
        xlab = '혈액형',
        ylab = '학생 수',
        col = heat.colors(4))
names <- c('aaa', 'bbb', 'ccc', 'ddd', 'eee', 'fff', 'ggg', 'hhh', 'iii', 'jjj', 'kkk', 'lll', 'mmm', 'nnn', 'ooo', 'ppp', 'qqq', 'rrr', 'sss', 'ttt')
sex <- c('남', '여', '남', '남', '남', '여', '여', '남', '여', '여', '여', '여', '남', '여', '여', '남', '남', '남', '여', '남')
classDF <- data.frame(naem = names, gender = sex, blood = bloodtype)

classTable <- table(classDF[, -1])
addmargins(table(classDF[, -1]))
#         blood
# gender  A AB  B  O Sum
# 남   3  1  3  3  10
# 여   4  1  2  3  10
# Sum  7  2  5  6  20

barplot(classTable, legend = T, ylim = c(0, 8), col = heat.colors(2), beside = T) # beside = T는 막대그래프를 분리해서 옆에 비교 편하게 함

library(MASS)
head(survey)
str(survey)

survey <- survey[, c('Sex', 'Exer', 'Smoke')]
table(survey$Sex)
table(survey$Exer)
table(survey$Smoke)

xtabs(~Sex, survey) # 데이터프레임만 이 작업이 가능. 백터는 불가

# 교차표: 둘 이상의 범주형 데이터를 이용해서 빈도와 비율 확인
table(Sex = survey$Sex, Smoke = survey$Smoke)
xtabs(~Sex + Smoke, survey)

pie(table(survey$Smoke))
