# 패키지 설치 및 로드 # install.packages('dplyr')
library(dplyr)

## mtcars 데이터 셋 구조와 내용 확인
str(mtcars)
## 행의 수와 열의 수를 확인하는 함수
nrow(mtcars)
## 수치형 데이터셋의 기초통계량을 확인
summary(mtcars)

# 주요함수
## 주어진 조건에 만족하는 행을 추출: filter(df, condition), subset()
filter(mtcars, cyl == 4)
## [조건식], [인덱스], [행 조건식, 열 조건식], [행 인덱스, 열 인덱스]
mtcars[mtcars$cyl >= 6 & mtcars$mpg > 20, ]
## 논리연산자: and(&), or(|), not(!)
filter(mtcars, cyl >= 6 & mpg > 20)

## 열 추출: select(df, v1, v2, ...)
select(mtcars, am, gear)

## 정렬: arrange(df, v) 또는 arrange(df, desc(v))
head(arrange(mtcars, wt)) # 기본 오름차순
head(arrange(mtcars, -wt)) # 내림차순
arrange(mtcars, mpg, desc(wt))

## 열 추가: muatate(df, 변수명 = 조건)
ncol(mtcars)
mutate(mtcars, year = 2023) # mutate()는 저장이 안 됨 변수에 넣지 않는 이상
## 연비(mpg)를 이용하여 순위를 구하고 해당 순위를 파생변수 mpg_rank 추가
head(mutate(mtcars, mpg_rank = rank(mpg))) # rank()는 동률이 있을 때 소수점이 나오는데 안 나오는 옵션도 있겠지

## 중복값 제거: distinct(df, v)
## 도수분포표: table()
table(mtcars$cyl)
#  4  6  8 
# 11  7 14 
distinct(mtcars, cyl)
#                   cyl
# Mazda RX4           6
# Datsun 710          4
# Hornet Sportabout   8
unique(mtcars$cyl) # [1] 6 4 8

## 요약: summarise(df, 변수명 = 기술통계함수) or summarize()
summarise(mtcars, mpg_mean = mean(mpg), mpg_min = min(mpg), mpg_max = max(mpg))

## 그룹별로: group_by(df, v)
summarise(group_by(mtcars, cyl), n())

# n_distinct(): 중복을 제거한 개수 추출, n(): 전체 개수
## 위 두 함수는 개별적으로 사용불가. 반드시 summarise, filter, mutate에서만 사용 가능

## 샘플: sample_n(df, 추출할 개수), sample_frac(df, 추출할 비율)
sample_n(mtcars, 10) # 10개
sample_frac(mtcars, 0.2) # 32개에서 20%인 6개 추출

## 파이프 연산자 or 연결 연산자: %>%, Shift + Ctrl + M
mtcars %>% 
  group_by(cyl) %>% 
  summarise(cnt = n())

## mpg(연비)를 이용하여 순위를 계산한 후 해당 값을 mp_rank라는 변수에 대입
mp_rank <- mutate(mtcars, mpg_rank = rank(mpg))
arrange(mp_rank, mpg_rank)
# 2
mutate(mtcars, mpg_rank = rank(mpg)) %>% arrange(mpg_rank)
# 3
mtcars %>% mutate(mpg_rank = rank(mpg)) %>% arrange(mpg_rank)