# 산술연산자
1 + 2
(11 + 54 * 2) / 3 - 10
15 %% 3 # 나머지. 값 0
5 %/% 2 # 정수 몫. 값 2
5 / 2 # 몫. 값 2.5
5 ** 3 # 거듭제곱. 값 125
7 ^ 2 # 거듭제곱. 값 49

# 변수
x = 5
print(x)

# R에서 권장하는 대입연산자
x <- 10

# 대입과 출력을 함께할 수 있다.
(x <- 2)

# 변수 삭제
rm(x)

x <- 2
y <- 3

# 현재 사용 중인 변수의 목록을 출력
ls()

# 출력함수: print()

x <- "one"
y <- "two"

print(x, quote = F) # 콘솔창에 큰따옴표가 안 나오는 옵션 #

# 특수상수 NA
aaa <- 100
bbb <- 75
ccc <- 80
ddd <- NA

stu <- c(aaa, bbb, ccc, ddd)

# is.자료형(): 해당 자료형이 맞는가? T / F
# as.자료형(): 해당 자료형으로 형변환하는 함수
is.na(ddd) # 값 TRUE

# 특수상수 NULL (NA는 값을 모르는 것. NULL은 값이 비어있는 것)
x <- NULL
is.null(x) # 값 TRUE
is.null(NA) # 값 FALSE

# vector 내장함수
val <- c(1:9)

## summary(): 수치데이터의 기초 통계량을 한꺼번에 보여주는 함수
summary(val)

x <- 10 # 요소가 1개인 벡터로 취급한다.

x <- 1:5

xy <- rnorm(30) # 정규분포 난수를 생성하는 함수

length(x) # 원소의 길이
range(x) # 최소값, 최대값이 나옴
mean(x) # 평균. 값 3
var(x) # 분산. 값 2.5
sd(x) # 표준편차. 값 1.581139

# 벡터 요소에 접근: [인덱스]
# x의 두 번째 요소에 접근
x[2]
# x의 두 번째 요소를 뺀 나머지
x[-2]
x[3] <- 30 # x의 세번째 요소에 값 30 할당

## [start:end]
x[2:4]
x[c(2, 4)]

# 벡터와 연산: 벡터에 저장된 데이터의 요소 단위로 계산을 수행한다.
## 벡터 합치기: append(a, b) - a, b 두 벡터를 연결하는 함수
## append(a, b, after_index)
x <- c(3, 6, 8, 12, 15)
y <- c(5, 10, 15, 20, 25)
z <- append(x, y) # 값 3, 6, 8, 12, 15, 5, 10, 15, 20, 25
W <- append(x, y, 3) # 벡터x의 3번째 값 다음 y가 바로 옴. 값 3, 6, 8, 5, 10, 15, 20, 25

c(1, 2) + c(4, 5) # 값 5 7
c(1, 2, 3) + 1 # 값 2 3 4

v <- -5:5

#seq = seqence, generation, seq(from, to, by)
q <- seq(1, 5, 0.5) # 1부터 5까지 0.5 간격으로 총 9개의 요소가 생성됨

qq <- seq(10)

x <- c(1, 2, 3)
y <- c(4, 2, 8)
# 두 벡터의 비교연산자
x == y # 값 FALSE  TRUE FALSE



# rep(벡터, times = 반복횟수 or each = 개별 반복 횟수)
(x <- rep(c('a', 'b', 'c'), times = 4))

# 중복값을 제거하고 대표값만 추출하는 함수
y <- unique(x)

xx <- c('a', 'b', 'c', 'd', 'd')

## 문자를 결합하는 함수 paste()
k <- paste(xx[1], xx[2]) # 결합시 결합 문자 사이에 공백이 추가됨. 값 a b

print(xx[1] + xx[2]) # 숫자가 아니라 더할 수 없다고 에러 메세지 출력

paste('hello', 'world') # \n 줄바꿈은 안 됨
cat(paste('hello\n', 'world')) # print 안 됨. cat은 됨

help(paste)
# sep: 구분기호, sep = ' '
paste('aaa', 'bbb', 'ccc') # 기본값이 공백 1칸
paste('aaa', 'bbb', 'ccc', sep = ',') # 쉼표나 공백제거 등 가능

# substring('문자열', 시작위치, 마지막위치): 문자열의 일부분 추출
substring('abcdefghijklmn', 2, 5) # 값 bcde

# 논리값: TRUE(T), FALSE(F)
## 논리연산자: and(&), or(|), not(!)
T & T # TRUE
F & F # FALSE
T | F # TRUE
! TRUE # FALSE

c(TRUE, TRUE) & c(TRUE, FALSE) # 값 TRUE FALSE

# factor < vector
gender <- factor('M', c('M', 'F'))

nlevels(gender) # factor level의 개수. 값 2
levels(gender)[1] # factor의 level 종류. "M" "F" 그 중 첫 번째 값인 M을 출력
levels(gender) <- c('male', 'female', 'genderless') # factor 레벨 이름 바꾸기 종류 추가

ordered(c('a', 'b', 'c')) #  값 Levels: a < b < c
factor(c('a', 'b', 'c'), ordered = T)

# 행렬(Matirx)
matrix(1:9, nrow = 3) # ncol = 3, byrow = F가 생략됨
#       [,1] [,2] [,3]
# [1,]    1    4    7
# [2,]    2    5    8
# [3,]    3    6    9
matrix(1:9, nrow = 3, dimnames = list(c('item1', 'item2', 'item3'), c('att1', 'att2', 'att3')))
#         att1 att2 att3
# item1    1    4    7
# item2    2    5    8
# item3    3    6    9

## 행렬의 데이터에 접근하는 방법: [행 인덱스, 열 인덱스]
x <- matrix(c(1:9), ncol = 3)
x[-3, ] # 1:2행 1:3열 출력
#       [,1] [,2] [,3]
# [1,]    1    4    7
# [2,]    2    5    8
x[-2, -2]
x[c(1, 3), c(1, 3)]
#       [,1] [,2]
# [1,]    1    7
# [2,]    3    9

y <- matrix(1:9, nrow = 3, dimnames = list(c('item1', 'item2', 'item3'), c('att1', 'att2', 'att3')))
y['item1', ]
# att1 att2 att3 
# 1    4    7 

x %*% y # 진짜 행렬 곱
#       att1 att2 att3
# [1,]   30   66  102
# [2,]   36   81  126
# [3,]   42   96  150

# 전치행렬
t(x) # 행과 열을 반대로 바꿈
#       [,1] [,2] [,3]
# [1,]    1    2    3
# [2,]    4    5    6
# [3,]    7    8    9

matrix(1:12, ncol = 4)
array(1:12, dim =c(3, 4))
#       [,1] [,2] [,3] [,4]
# [1,]    1    4    7   10
# [2,]    2    5    8   11
# [3,]    3    6    9   12
x <- array(1:12, dim =c(2, 2, 3))
# , , 1
# 
#       [,1] [,2]
# [1,]    1    3
# [2,]    2    4
# 
# , , 2
# 
#       [,1] [,2]
# [1,]    5    7
# [2,]    6    8
# 
# , , 3
# 
#       [,1] [,2]
# [1,]    9   11
# [2,]   10   12

dim(x) # 배열의 차원 확인
x[1, 2, 3] # 값 11 출력
x[, ,  3] # 3번째 행렬이 출력

# 리스트(list)
x <- list(name = '홍길동', height = 170)
# $name
# [1] "홍길동"
# 
# $height
# [1] 170

x$name # $name [1] "홍길동" 키와 값이 출력

x <- list(name = '홍길동', height = c(170, 187, 163))
# $height
# [1] 170 187 163
x$height[2] # 187 출력

list(a = list(val = c(1:3)), b = list(val = c(1:4)))
# $a
# $a$val
# [1] 1 2 3
# 
# $b
# $b$val
# [1] 1 2 3 4

# list 내 데이터에 접근하는 방법: $
## 리스트명$변수명$키 or 리스트[[인덱스]]
x <- list(name = '홍길동', height = c(1, 3, 5))
x[[2]] # 1 3 5 출력
x[[2]][2] # 3 출력

# 데이터 프레임(Data Frame)
d <- data.frame(x = c(1:5), y = c(2, 4, 6, 8, 10))
d2 <- data.frame(x = c(1:5), y = c(2, 4, 6, 8, 10), z = c('M', 'F', 'M', 'F', 'M'))

## 기존의 데이터 프레임에 특정 컬럼 추가
d2$v <- seq(3, 15, 3)
d2
#   x  y z  v
# 1 1  2 M  3
# 2 2  4 F  6
# 3 3  6 M  9
# 4 4  8 F 12
# 5 5 10 M 15
d2$x # 아래 것과 결과 동일
d2[, 1]
# [1] 1 2 3 4 5

d2[, c('x', 'y')]
#   x  y
# 1 1  2
# 2 2  4
# 3 3  6
# 4 4  8
# 5 5 10
d2[, 'x', drop = F] # drop = F 데이터 구조를 유지하란 옵션
#   x
# 1 1
# 2 2
# 3 3
# 4 4
# 5 5

str(d2)

# data type 확인
## mode(), typeof(), class() - 자료구조의 타입
class(c(1, 2)) # [1] "numeric"
class(matrix(c(1, 2))) # [1] "matrix" "array" 
class(list(c(1, 2))) # [1] "list"
class(data.frame(x = c(1, 2))) # [1] "data.frame"

str(c(1, 2)) # num [1:2] 1 2
str(matrix(c(1, 2))) # num [1:2, 1] 1 2

# is.factor(), is.matrix(), is.data.frame(), is.character()
is.numeric(c(1:3))
is.matrix(matrix(c(1, 2)))

# 형 변환: as.*
x <- c('m', 'f')
is.character(x) # [1] TRUE
as.factor(x)
# [1] m f
# Levels: f m
as.numeric(as.factor(x)) # [1] 2 1
