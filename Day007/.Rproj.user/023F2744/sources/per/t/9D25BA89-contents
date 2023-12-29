# 별도의 기억장소에 저장된 패키지 설치 방법 - github
install.packages('devtools')
# 패키지 설치
devtools::install_github('kilhwan/bizstatp')
# 패키지 로딩
library(ggplot2)
library(bizstatp)
course

# 데이터 확인
str(course)
# 데이터 전체 요약 보고서
summary(course)

# 변수들 간의 상관관계를 파악 - 산점도
plot(course)
# 수치형 데이터를 이용한 상관분석
plot(course[, 5:8])

# 범주형 변수의 기술통계
head(course)

# 절대빈도표 table(), xtabs()
## table(벡터) or table(데이터프레임$컬럼)
## xtabs(수식_formular, data = 데이터 프레임, subset)
table(course$major)
# ME Others 
# 40      5 
xtabs(~year, course)
# year
# 1  2  3  4 
# 1 32  9  3 
xtabs(~year, course, gender == 'M')
# year
# 1  2  3  4 
# 1 18  6  2 
xtabs(~year, course, class == 2)
# year
# 1  2  3  4 
# 1 14  6  2 

# 상대빈도표
dataYear <- xtabs(~year, course)
dataMajor <- xtabs(~ major, course)
dataGender <- xtabs(~gender, course)
dataClass <- xtabs(~class, course)

## 상대빈도표를 만드는 함수: proportions(절대빈도표), prop.table
### 학년과 성별에 대한 상대 빈도표
proportions(dataYear) # 전체를 1로 놓고 그 안에서 비율 계산 * 100을 하면 백분률로 나옴
# year
# 1          2          3          4 
# 0.02222222 0.71111111 0.20000000 0.06666667 
proportions(dataGender) * 100
# gender
# F  M 
# 40 60 

## 막대 그래프
### ggplot(데이터, aes(범주형 범주)) + geom_bar
ggplot(course, aes(year)) + geom_bar(fill = 'orange')

### 상대 빈도를 이용해서 막대그래프를 그릴 때
### ggplot(데이터, aes(x = 범주형 변수, y = after_stat(prop), gruop = 1)) + geom_bar
ggplot(course, aes(year, after_stat(prop), group = 1)) + geom_bar()

ggplot(mpg, aes(class)) + geom_bar() + coord_flip()

## 빈도 순으로 막대를 표시하는 함수
### ggplot(데이터, aes(x = reorder(범주형 변수, 범주형 변수, length))) + geom_bar()
ggplot(mpg, aes(reorder(class, class, length))) + geom_bar() + coord_flip() + labs(x = '자동차 종류')

ggplot(course, aes(reorder(year, year, length))) + geom_bar()

reorder(course$gender, course$score, mean)

ggplot(course, aes(reorder(gender, score, mean), score)) + geom_boxplot()

# 파이 차트: pie(빈도표)
pie(dataYear, main = '학년별 수강생 비율', labels = labels)

labels <- paste0(names(dataYear), '학년: ', round(proportions(dataYear)*100, 2), '%')

# 범주형 변수들 간의 상관성을 수치로 요약하는 방법 - 교차표
## 절대 빈도로 교차표(분할표)를 만든다.
### table() - base, xtabs() - stat, acast()나 dcast() - reshape2 패키지, count() - dplyr
#### table() 함수를 이용한 교차표
#### table(벡터1, 벡터2, ...)
#### table(df$v1, df$v2, ...)
table(course$gender, course$year)
#    1  2  3  4
# F  0 14  3  1
# M  1 18  6  2

### 행, 열, 면(층, layer)
table(course$gender, course$year, course$class)
# , ,  = 1
# 
# 
#    1  2  3  4
# F  0  8  2  0
# M  0 10  1  1
# 
# , ,  = 2
# 
# 
#    1  2  3  4
# F  0  6  1  1
# M  1  8  5  1

# xtabs() 함수를 이용해서 교차표 # 이걸 쓰는 이유는 조건을 담을 수 있기 때문 #
data <- xtabs(~ gender + year, course)
#     year
# gender  1  2  3  4
# F  0 14  3  1
# M  1 18  6  2
xtabs(~ gender + year + class, course)
xtabs(~ gender + year, course, score >= 80)

# 두 범주형 변수의 누적막대 그래프
ggplot(course, aes(year, fill = gender)) + geom_bar(position = 'dodge')
ggplot(course, aes(gender, fill = year)) + geom_bar(position = 'dodge')

# 상대 빈도를 이용한 막대 그래프
ggplot(course, aes(year, fill = gender)) + geom_bar(position = 'fill')

# 모자이크 그래프: ggmosaic # 결측치 파악에도 좋음 #
## 패키지 설치
install.packages('vcd')
## mosaic(범주형 변수2 ~ 범주형 변수1, data, direction = 'v')
library(vcd)

mosaic(gender ~ year, course, direction = 'v')



# 관절염 치료 임상시험 데이터 분석 #
# 새로운 관절염 치료법의 효과를 측정한 데이터 셋 #
Arthritis
str(Arthritis)
table(is.na(Arthritis$ID))
table(is.na(Arthritis$Treatment))
table(is.na(Arthritis$Sex))
table(is.na(Arthritis$Age))
table(is.na(Arthritis$Improved))
# 문제 정의
## 1. 새로운 치료법은 효과가 있는가?
## 치료법(Treatment)과 증상 개선 여부
check <- xtabs(~ Sex + Treatment, Arthritis)
round(proportions(check, margin = 1) * 100, 2)
#          Treatment
# Sex      Placebo Treated
# Female      32      27
# Male        11      14
#          Treatment
# Sex      Placebo Treated
# Female   54.24   45.76
# Male     44.00   56.00
mosaic(Sex ~ Treatment, Arthritis, direction = 'v')
ggplot(Arthritis, aes(Sex, fill = Treatment)) + geom_bar(position = 'dodge')

## 2. 새로운 치료법의 효과는 성별에 따라 차이가 있는가?
## None < Some < Marked
check <- xtabs(~ Sex + Improved, Arthritis)
round(proportions(check, margin = 1) * 100, 2)

tsi_placebo <- xtabs(~ Sex + Improved, Arthritis, subset = Treatment == 'Placebo')
tsi_placebo
round(proportions(tsi_placebo, margin = 1) * 100, 2)
fisher.test(tsi_placebo) # p-value = 0.1706 큰 의미가 없다

tsi_treated <- xtabs(~ Sex + Improved, Arthritis, subset = Treatment == 'Treated')
tsi_treated
round(proportions(tsi_placebo, margin = 1) * 100, 2)
fisher.test(tsi_treated) # p-value = 0.1706  0.05보다 크지만 표본이 너무 작아 큰 의미가 없다
#          Improved
# Sex      None Some Marked
# Female   25   12     22
# Male     17    2      6
mosaic(Sex ~ Improved, Arthritis, direction = 'v')
ggplot(Arthritis, aes(Sex, fill = Improved)) + geom_bar(position = 'dodge')


ggplot(Arthritis, aes(x = Treatment, fill = Improved)) + geom_bar(position = 'fill') + facet_wrap(~Sex)

#
t_f <- xtabs(~ Sex + Treatment, Arthritis, subset = Sex =='Female')
t_m <- xtabs(~ Sex + Improved, Arthritis, subset = Sex == 'Male')
full <- cbind(t_f, t_m)
# gridExtra

## 가설검정: 통계적인 의미가 있는지 살펴보기 위해
## 카이제곱 검정(Chi-Square test): 두 범주형 변수가 서로 상관이 있는지 판단
## 귀무가설 - 차이가 없다.
## 대립가설 - 차이가 있다.
chisq.test(check)



# 이혼에 대한 사회조사 데이터 셋
BrokenMarriage
xtabs(~gender + borken, BrokenMarriage)
# xtabs(빈도변수 ~ 범주형 변수 + ...,data)
tgb <- xtabs(Freq ~ gender + broken, BrokenMarriage)
tgb
round(proportions(tgb, 2)* 100, 2)
chisq.test(tgb)

trb <- xtabs(Freq ~ broken + rank, BrokenMarriage)
round(proportions(trb, 2)* 100, 2)
chisq.test(trb)

## 이렇게 축약된 데이터에서는 geom_bar() 보다는 geom_col()
## ggplot(date, aes(x = 범주형 변수, y = 빈도변수)) + geom_col()
## ggplot(date, aes(x = 범주형 변수, y = 빈도변수, fill = 범주형 변수2)) + geom_col()
## ggplot(date, aes(x = 범주형 변수, y = 빈도변수, fill = 범주형 변수2)) + geom_col(position = 'dodge' or 'fill')
ggplot(BrokenMarriage, aes(x = rank, y = Freq, fill = broken)) + geom_col() + facet_wrap(~gender)

ggplot(BrokenMarriage, aes(x = rank, y = Freq, fill = broken)) + geom_col(position = 'fill') + facet_wrap(~gender)
