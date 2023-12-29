# dplyr 패키지: 데이터 프레임을 핸들링할 때 가장 기본적으로 사용되는 함수
# install.packages('dplyr')
library(dplyr)

## filter(df, x): 행 추출, subset()
## select(df, x, y): 열 추출, df[, c('x', 'y')]
## mutate(df, z = x + y): 열 추가(파생변수), df$z <- df$x + df$y, transform()
## arrange(df, x): 정렬, order(), sort()
## distinct(df, x): unique 행 추출, unique()
## rename(df, y= x): 변수명 변경, names(df)[names(df) == 'x'] <- 'y'
## summerise(): 집계, aggregate()
## group_by(): 그룹별 집계
## inner_join(df1, df2), merge(df1, df2)
## left_join(df1, df2), merge(df1, df2, all.x = T)

## 체인연산자 %>% 앞 뒤 명령어를 이 연산자로 이어서 수행함

# 세계 각국의 기대수명과 1인당 국내 총 생산, 인구 정보를 집계한 데이터셋
install.packages("gapminder")
library(gapminder)
str(gapminder)

## 각 나라별 기대수명을 추출
gapminder[, c('country', 'lifeExp')]

## 각 나라별 기대수명과 측정연도
gapminder[, c('country', 'lifeExp', 'year')]

# 1
select(gapminder, country, lifeExp) # 컬럼명이라 select, 행 추출은 filter #
# 2
gapminder %>%
  select(country, lifeExp) #위와 동일 결과 나옴#

gapminder[gapminder$country == 'Croatia', ]
filter(gapminder, country == 'Croatia')

gapminder[gapminder$country == 'Croatia', c('pop', 'lifeExp')]

# Croatia의 1990년 이후의 기대수명과 인구를 추출
gapminder[gapminder$country == 'Croatia' & gapminder$year > 1990, c('pop', 'lifeExp')]

# Croatia의 기대수명과 인구의 평균을 추출하시오.
apply(gapminder[gapminder$country == 'Croatia', c('pop', 'lifeExp')], 2, mean) # apply 1- 행, 2-열
# 2
gapminder %>%
  filter(country == 'Croatia') %>%
  select(pop, lifeExp)

# 인구(pop) 평균
mean(gapminder$pop)
summarise(gapminder, mean(pop))

# 대륙별 인구 평균
summarise(group_by(gapminder, continent), mean(pop))
# 2
gapminder %>%
  group_by(continent) %>%
  summarise(mean(pop))

# 대륙별 나라의 인구 평균
gapminder %>%
  group_by(continent, country) %>%
  summarise(mean(pop))

# mtcars
## 행 추출: filter(데이터, 조건식)
### 실린더(cyl) 개수가 4기통에 해당하는 자동차의 정보만 추출하시오.
str(mtcars)
mtcars %>%
  filter(cyl == 4)
### 실린더가 6기통 이상, 연비(mpg)가 20을 초과하는 자동차 정보만 추출
mtcars %>%
  filter(cyl >= 6 & mpg > 20)

## 열추출: select(데이터명, 변수명 ...)
### mtcars에서 변속기(am), 기어(gear) 데이터만 추출
mtcars %>%
  select(am, gear)
## 정렬: arrange(데이터, 변수명1, 변수명2 ...), arrange(데이터, desc(변수명))
### mtcars에서 무게(wt)를 기준으로 내림차순 정렬한 후 상위 6개만 추출
mtcars %>%
  arrange(-wt) %>%
  head()
head(arrange(mtcars, desc(wt)))
## 열 추가: mutate(데이터, 추가할 변수명 = 조건 ...)
### mtcars에서 year라는 생산년도를 담을 열을 추가 후 1974 값 표시
c_mt <- mtcars
c_mt %>%
  mutate(year = 1974)
### 자동차별 연비(mpg) 순위를 구하여 mpg_rank 열을 추가해 표시
c_mt %>%
  mpg_rank <- rank(-mpg) %>%
  mutate(mpg_rank = mpg_rank)
head(mutate(mtcars, mpg_rank = rank(mpg)))
## 중복값 제거: distinct(데이터, 변수명)
### mtcars에서 실린더(cyl) 개수에 따른 종류와 기어(gear) 개수에 따른 종류 추출
c_mt %>%
  distinct(cyl, gear)
## 요약: summarise(데이터, 요약 변수명 = 기술 통계 함수)
### 자동차 실린더(cyl) 개수의 평균, 최소, 최대 추출
c_mt %>%
  summarise(mn = mean(cyl),  mi = min(cyl), ma = max(cyl))
## 그룹설정: group_by(데이터, 변수명)
### 동일한 실린더 개수를 가진 차가 몇 대인지 추출
mtcars %>%
  group_by(cyl) %>%
  count(cyl)

mtcars %>%
  gq <- group_by(cyl) %>%
  summarise(gp, n())

# 동일한 실린더 개수를 가진 차들 중 기어 값이 중복인 데이터를 제외한 건수
gq <- group_by(mtcars, cyl)
summarise(gq, n_distinct(gear)) # 중복 값 제거 n_distinct()


# EDA(탐색적 데이터 분석)
tips <- read.csv('https://raw.githubusercontent.com/mwaskom/seaborn-data/master/tips.csv')
str(tips)

summary(tips)
# 데이터가 뭔지를 알면 stringsAsFactor로 한 번에 바꾸는게 낫다
tips$sex <- as.factor(tips$sex)
tips$smoker <- as.factor(tips$smoker)
tips$day <- as.factor(tips$day)
tips$time <- as.factor(tips$time)

# total_bill         tip             sex      smoker      day         time    
# Min.   : 3.07   Min.   : 1.000   Female: 87   No :151   Fri :19   Dinner:176  
# 1st Qu.:13.35   1st Qu.: 2.000   Male  :157   Yes: 93   Sat :87   Lunch : 68  
# Median :17.80   Median : 2.900                          Sun :76               
# Mean   :19.79   Mean   : 2.998                          Thur:62               
# 3rd Qu.:24.13   3rd Qu.: 3.562                                                
# Max.   :50.81   Max.   :10.000                                                
# size     
# Min.   :1.00  
# 1st Qu.:2.00  
# Median :2.00  
# Mean   :2.57  
# 3rd Qu.:3.00  
# Max.   :6.00                    총 244명

head(arrange(tips, desc(tip)), 40) # 대강 봤을 때 남자, 토요일, 저녁이 팁 많이 냄 

summarise(group_by(tips, day, time), mean(tip)) # 일요일(저녁만 함)이 3.26으로 가장 높음. 영업일 저녁 다 3에 가까움
summarise(group_by(tips, sex), mean(tip)) # 남자가 3.09 좀더 높음
summarise(group_by(tips, size), mean(tip)) # 인원수에 완벽하게 비례하진 않으나 6명이서 온 그룹이 5.22로 가장 높고 혼자 온 사람이 1.44로 가장 낮게 냄

# 동석자 수의 분포
tips %>%
  ggplot(aes(size)) + geom_histogram() # 2명이 오는 경우가 가장 많다

# 총액에 따른 팁 액수 분석 + 요일별 색상 + 결제 성별 모양, 심볼 사이즈
tips %>%
  ggplot(aes(total_bill, tip)) + geom_point(aes(col = day, pch = sex), size = 3)

# 막대 그래프
tips %>%
  ggplot(aes(day, tip, fill = time)) + geom_bar(stat = "identity", position = 'fill')

tot <- tips$total_bill + tips$tip
tips %>%
  ggplot(aes(day, tot, fill = time)) + geom_bar(stat = "identity", position = 'dodge') + geom_line(aes(tip))

# 탐색적 데이터 분석: mpg
str(mpg)
mpg <- as.data.frame(ggplot2::mpg)

## 자동차 배기량(displ)에 따라 고속도로 연비(hwy)
table(mpg$displ)
median(mpg$displ) [1] 3.3

## 자동차 배기량이 4 이하인 자동차와 5 이상인 자동차 중 어떤 자동차의 고속도로 연비가 높은지
d4 <- filter(mpg, displ <= 4)
d5 <- filter(mpg, displ >= 5)
mean(d4$hwy)
mean(d5$hwy)
summarise(group_by(mpg$displ <= 4 , mpg$displ >= 5), mean(hwy))
## 자동차의 제조회사별 도시 연비(cty)가 어떤지 분석
summarise(group_by(mpg, manufacturer), mean(cty))
