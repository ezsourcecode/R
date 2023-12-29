# R base 내장 데이터
data()
## 데이터 표 형태로 데이터를 보여주는 View()
View(iris)
## 데이터 구조 확인 str()
str(iris)

# 데이터 셋 목록 확인
library(help = "datasets")
# 실제 데이터를 사용할 때
data(mtcars)

## head() & tail() 앞/뒤 6개 데이터를 보여줌
head(mtcars)

View(mtcars)

# 파일 입출력
## csv 파일 입출력: read.csv(파일명, header=T)
x <- read.csv('C:/k_digital/data/aaa.csv')
x <- read.csv('C:/k_digital/data/bbb.csv', header = F)
names(x) <- c('id', 'name', 'score') #열머리글 옵션 설정 안 했을 때 이름을 바꿀 순 있지만, 열머리글로 설정되었던 데이터행 하나 손실됨# 
str(x)
x$name <- as.factor(x$name)
x$name <- as.character(x$name)

x <- read.csv('C:/k_digital/data/aaa.csv', stringsAsFactors = T)

x <- read.csv('C:/k_digital/data/ccc.csv')
x <- read.csv('C:/k_digital/data/ccc.csv', na.strings = 'NIL')
is.na(x$score)
table(is.na(x$score)) # 결측치 건수 확인 FASLE 2, TRUE 1. 즉 결측치 1개

# 데이터를 파일로 저장하는 방법
write.csv(x, 'ccc.csv', row.names = F) # row.names = F를 안 하면 쓸데없는 행번호가 파일에 같이 저장됨. 현재 저장경로를 따로 지정하지 않아 동일 워킹디렉토리에 저장됨

# R 객체를 그대로 파일로 저장하고 불러오는 함수, RData 확장자
x <- 1:5
y <- 6:10
save(x, y, file = 'xy.RData')

## 현재 메모리상에 있는 모든 객체를 삭제하는 작업
rm(list = ls())

load('xy.RData') # 별도 경로 지정 안 하면 지금 작업하는 경로

# 외부 데이터 가져오기: 엑셀파일
## 별도의 새로운 패키지 설치
install.packages('readxl')
## 패키지 불러오기
library(readxl)
## 엑셀파일 불러오기
ex_data <- read_excel('C:/k_digital/data/ex_data.xlsx')
View(ex_data)

#rbind(), cbind(): 각각 행 or 열 형태로 데이터를 합쳐서 행렬 or 데이터프레임 생성
rbind(c(1:3), c(4:6))
#       [,1] [,2] [,3]
# [1,]    1    2    3
# [2,]    4    5    6

x <- data.frame(id = c(1, 2), name = c('a', 'b'), stringsAsFactors = F)
#   id name
# 1  1    a
# 2  2    b

y <- rbind(x, c(3, 'c'))
#   id name
# 1  1    a
# 2  2    b
# 3  3    c

cbind(c(1:3), c(4:6))

y <- cbind(x, test = c('pass', 'fail'))
#   id name test
# 1  1    a pass
# 2  2    b fail

# apply 계열의 함수들: 벡터, 행렬, 리스트, 데이터프레임에 반복적으로 적용하는 함수
## 종류: apply, lapply, sapply, tapply
### apply(행렬, 방향, 함수): 행 or 열 방향으로 특정 함수를 적용할 때 사용
sum(1:10)
d <- matrix(1:9, ncol = 3)
#       [,1] [,2] [,3]
# [1,]    1    4    7
# [2,]    2    5    8
# [3,]    3    6    9

### 주어진 행렬의 행들의 합을 계산
apply(d, 1, sum) ## 1: 행방향→ [1] 12 15 18
apply(d, 2, sum) ## 2: 열방향↓ [1]  6 15 24

### iris 데이터의 각 컬럼(feature) 합을 계산
apply(iris[, -5], 2, sum)
# Sepal.Length  Sepal.Width Petal.Length  Petal.Width 
# 876.5        458.6        563.7        179.9

### rowSums(), colSums(), rowMeans(), colMeans()
colSums(iris[, 1:4]) # 위와 동일 결과

## lapply(벡터 or 리스트, 함수)
### 결과가 리스트로 반환된다.
result <- lapply(1:3, function(x){x * 2})
# [1] 2
# [[2]]
# [1] 4
# [[3]]
# [1] 6
## 리스트를 벡터로 변환하는 함수
unlist(result) # [1] 2 4 6

# 리스트 생성: 키와 값을 쌍으로 관리하는 자료구조
x <- list(a = 1:3, b = 4:6)
# $a
# [1] 1 2 3
# $b
# [1] 4 5 6
lapply(x, mean)
# $a
# [1] 2
# $b
# [1] 5
lapply(iris[-5], mean)
# $Sepal.Length
# [1] 5.843333
# $Sepal.Width
# [1] 3.057333
# $Petal.Length
# [1] 3.758
# $Petal.Width
# [1] 1.199333
colMeans(iris[, -5])
# Sepal.Length  Sepal.Width Petal.Length  Petal.Width 
# 5.843333     3.057333     3.758000     1.199333 

### 리스트를 데이터 프레임으로 변환할 때
### 1. unlist() 함수로 리스트를 벡터로 변환
unlist(lapply(iris[, -5], mean))
### 2. matrix() 함수로 벡터를 행렬로 변환
matrix(unlist(lapply(iris[, -5], mean)), ncol = 4, byrow = T)
### 3. as.data.frame() 함수로 행렬을 데이터 프레임으로 변환
as.data.frame(matrix(unlist(lapply(iris[, -5], mean)), ncol = 4, byrow = T))
### 4. names() 함수로 리스트로부터 컬럼명을 얻어와 데이터 프레임에 부여
names(iris[-5])

d<- as.data.frame(matrix(unlist(lapply(iris[, -5], mean)), ncol = 4, byrow = T))
names(d) <- names(iris[-5])

# sapply: lapply와 유사하지만 리스트 대신 행렬, 벡터 등으로 결과가 반환된다.
## iris 컬럼별 평균 계산
lapply(iris[, -5], mean) # 리스트 반환
sapply(iris[, -5], mean) # 벡터 변환
class(sapply(iris[, -5], mean)) # [1] "numeric"

x <- sapply(iris[, -5], mean)
as.data.frame(x)
as.data.frame(t(x)) # t() 전치 행렬. 열과 행의 위치가 바뀜

sapply(iris, class)
# Sepal.Length  Sepal.Width Petal.Length  Petal.Width      Species 
# "numeric"    "numeric"    "numeric"    "numeric"     "factor" 

result <- sapply(iris[, -5], function(x){x > 3})
class(result) # [1] "matrix" "array" 

# tapply: 그룹별 처리를 위한 apply 함수
## tapply(데이터, 색인_어떤 그룹에 속하는 지 표현하는 것, 함수)
tapply(1:10, rep(1, 10), sum)
# 1 
# 55

## 홀,짝별로 묶어서 합계를 구하시오.
tapply(1:10, 1:10 %% 2 == 1, sum) # F = 짝, T = 홀
# FALSE  TRUE 
# 30    25 

### 행렬(행- 계절, 열- 성)
m <- matrix(1:8, ncol = 2, dimnames = list(c('spring', 'summer', 'fall', 'winter'),c('male', 'female')))
#         male female
# spring    1      5
# summer    2      6
# fall      3      7
# winter    4      8

### 분기별 남성과 여성 합계를 구하시오.
### 상반기(봄, 여름), 하반기(가을, 겨울)
tapply(m, list(c(1, 1, 2, 2, 1, 1, 2, 2), c(1, 1, 1, 1, 2, 2, 2, 2)), sum) # c()는 5, 6, 7, 8, 1, 2, 3, 4 순서

#doBy 패키지
## summaryBy(), orderBy(), spliyBy(), sampleBy()
install.packages('doBy')
library(doBy)

### summary(): 수치데이터의 기초통계량을 나타내는 함수
summary(iris)

# 사분위수 추출
quantile(iris$Sepal.Length)
quantile(iris$Sepal.Length, seq(0, 1, by = 0.1)) # 사분위를 10% 단위로 출력

## formula식: 독립변수 ~ 종속변수, 독립변수1 + 독립변수2 ~ 종속변수
summaryBy(Sepal.Length + Sepal.Width ~ Species, iris) # 종별로 길이와 넓이의 기초통계 요약
## formula식: .(all) 생략 가능
orderBy( ~ Sepal.Width, iris)
orderBy( ~ Species + Sepal.Width, iris) # 종으로 오름차순 후 넓이로 오름차순

order(iris$Sepal.Width) # 하나의 키 값으로 정렬 결과가 데이터 프레임이 깨져 팩터로 나옴
iris[order(iris$Sepal.Width), ] # order을 조건식으로 []에 넣으면 데이터 프레임으로 나옴

sample(1:10, 5, replace = T) # replace = T 중복 허용
sample(1:10, 20) # 생성되는 수가 뽑는 수보다 적기에 replace 조건을 주지 않으면 오류남

## 데이터를 무작위로 섞어내는 역할을 사용한다.
iris[sample(NROW(iris), NROW(iris)), ] # iris 전체 데이터를 섞음
### 랜덤 샘플릭
sampleBy(~ Species, frac = 0.1, data = iris) # frac = 0.1 적어도 각 품종별로 10% 포함되게 출력

## split(데이터, 분리조건) - 리스트로 반환된다.
split(iris, iris$Species)
lapply(iris[, 1:4], mean)

lapply(split(iris$Sepal.Width, iris$Species), mean) # 리스트로 종별 넓이 평균 출력

# subset(): 소계
subset(iris, Species == 'setosa' & Sepal.Length > 5.0) # 세토사면서 길이가 5.0 이상 출력
subset(iris, select = -c(Sepal.Length, Species)) # 길이와 종을 제외한 값만 출력

# merge(): join과 같은 역할을 수행하는 함수
x <- data.frame(name = c('a', 'b', 'c'), math = c(1, 2, 3))
y <- data.frame(name = c('c', 'b', 'a'), kor = c(4, 5, 6))
cbind(x, y) # 그냥 중복된 상태로 합쳐짐
#     name math name kor
# 1    a    1    c   4
# 2    b    2    b   5
# 3    c    3    a   6
merge(x, y, all = T) # full output join, 일치하지 않더라도 조인(NA) all = T(공통 값)을 찾아 병합됨. 만약 비어있는 값이 있다면 NA가 뜸
#     name math kor
# 1    a    1   6
# 2    b    2   5
# 3    c    3   4

# sort(), order(): 데이터를 정렬하는 함수
x <- c(20, 11, 33, 50, 43)
sort(x, decreasing = T) # 정렬 옵션. 기본갑: 오름차순. decreasing = T, 내림차순
order(-x) # 정렬 후 인덱스 반환. -는 내림차순. [1] 4 5 3 1 2
x[order(x)] # 값이 출력됨 [1] 11 20 33 43 50

# with(), within()
mean(iris$Sepal.Length)
with(iris, mean(Sepal.Length))
with(iris, mean(Sepal.Width))
with(iris, {
  print(mean(Sepal.Length))
  print(mean(Sepal.Width))
})

x <- data.frame(val = c(1, 2, 3, 4, NA, 5, NA))
mean(x$val) # [1] NA
is.na(x$val) # [1] FALSE FALSE FALSE FALSE  TRUE FALSE  TRUE
mean(x$val, na.rm = T) # [1] 3
mean(is.na(x$val)) # [1] 0.2857143

## ifelse(조건식, 참, 거짓)
## 수치데이터의 결측값을 보간하는 방법: 평균값 or 최빈값
x <- within(x, {
  val <- ifelse(is.na(val), median(val, na.rm = T), val)
})
x$val[is.na(x$val)] <- median(x$val, na.rm = T)
iris[1, 1] <- NA
head(iris)

## 결측값이 존재하는 해당 품종의 중앙값으로 대체하는 작업
### step 1. setosa 품종의 Sepal. Length의 중앙값 계산
### step 2. 해당 중앙값으로 결측값 채우기
rs <- sapply(split(iris$Sepal.Length, iris$Species), median, na.rm = T)
iris <- within(iris, {
  Sepal.Length <- ifelse(is.na(Sepal.Length), rs[Species], Sepal.Length)
})

# attach(), detch()
iris$Sepal.Length
attach(iris)
Sepal.Lenght
detach(iris)

# which(), which.max(), which,min()
## which 함수는 벡터나 배열에서 주어진 조건에 만족하는 값이 있는 인덱스 반환
x <- c(2, 4, 6, 7, 10)
which(x %% 2 == 0) # 인덱스 값 [1] 1 2 3 5 출력 x %% 2 [1] 0 0 0 1 0
x[which(x %% 2 == 0)] # [1]  2  4  6 10

which.max(x) # 가장 큰 값의 인덱스인 [1] 5
-sort(-x)[1] # 가장 큰 값 [1] 10
sort(x, decreasing = T)[1] # 위와 동일

which.min(x) # 가장 큰 값의 인덱스인 [1] 1
sort(x)[1] # 가장 작은 값 [1] 2

# aggregate(): 그룹별 연산을 수행하는 함수
## aggregate(데이터, 그룹조건, 함수) or aggregate(formular, 데이터, 함수)
### iris 데이터에서 품종별로 Sepal.Width의 평균 계산
aggregate(Sepal.Width ~ Species, iris, mean)
