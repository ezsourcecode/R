# 변수
# 벡터(vector): 1차원 배열
## c(), start:end, seq(from, to, by), rep(vector, times or each)
x <- c(1:5)
y <- 1:5
z <- seq(1, 5, 1) # seq(1, 5), seq(5) 모두 동일
a <- c("1", "2", "3", 4, 5, 6) # 뒤에 숫자 문자 취급
xx<- c(1:3, c(4:6))

# 접근방법: [index], [condition], [-index]
xx[4] # [1] 4

## xx에 저장된 데이터 중 짝수에 해당하는 값만 추출
xx[xx %% 2 == 0]

yy <- c('a', 'b', 'c')
## a, b만 출력
yy[-3] # [1:2], [c(1, 2)]와 동일

## 벡터의 각 요소에 이름 부여
names(yy) <- c('kim', 'lee', 'park')
names(yy)[2] # [1] "lee"

# 벡터의 길이: length() or NROW() - 대문자임을 주의 소문자는 행렬에서 쓰는 것
x <- c('a', 'b', 'c')
length(x) # NROW(x)와 동일한 결과 [1] 3
nrow(x) #  NULL

# 벡터 연산
## %in%
'a' %in% x # 벡터x에 'a'가 있나 [1] TRUE

# 리스트(List): 파이썬의 딕셔너리(사전) 자료형과 동일
## 키 = 값의 형태로 데이터를 관리한다.
## 키는 중복불가, 값은 중복가능
x <- list(name = 'foo', height = 70)
# $name
# [1] "foo"
# $height
# [1] 70

## 리스트를 구성하고 있는 각 요소는 크기와 자료형이 달라도 가능하다.
x <- list(name = 'foo', height = c(1, 2, 3))
x[[2]][2] # x$height[2]와 동일 결과 [1] 2

y <- list(a =list(val = c(1, 2, 3)), b = list(val = c(1, 2, 3, 4)))
# $a
# $a$val
# [1] 1 2 3
# $b
# $b$val
# [1] 1 2 3 4

# 행렬(matrix): 여러 개의 벡터가 결합되어 있는 상태
## matrix(data, nrow, ncol, byrow = T/F)
matrix(1:9, nrow = 3)
matrix(1:9, ncol = 3)
#       [,1] [,2] [,3]
# [1,]    1    4    7
# [2,]    2    5    8
# [3,]    3    6    9
matrix(1:9, nrow = 3, byrow = T)
#       [,1] [,2] [,3]
# [1,]    1    2    3
# [2,]    4    5    6
# [3,]    7    8    9

## 행과 열에 이름을 부여 dimnames(list()) 주의 꼭 list타입이어야 함
matrix(1:9, nrow = 3, byrow = T,
       dimnames = list(c('행1', '행2', '행3'), c('열1', '열2', '열3')))

## 행렬에 접근: [행 인덱스, 열 인덱스] or [행 조건, 열 조건]
m <- matrix(1:9, nrow = 3, byrow = T,
       dimnames = list(c('행1', '행2', '행3'), c('열1', '열2', '열3')))
### 1, 2행 추출
m[1:2, ]
### 3행 제외
m[-3, ]
### 1행, 3행, 1열, 3열 추출
m[-2, -2]

# 데이터 프레임: 행렬과 유사한 구조
df <- data.frame(x = c(1:5), y = seq(2, 10, 2))
df$z <- c('M', 'F', 'M', 'F', 'M')
#   x  y z
# 1 1  2 M
# 2 2  4 F
# 3 3  6 M
# 4 4  8 F
# 5 5 10 M
df$x
# [1] 1 2 3 4 5
df[-1, -c(2:3)]
# [1] 2 3 4 5
df[, c('x', 'z')]
#   x z
# 1 1 M
# 2 2 F
# 3 3 M
# 4 4 F
# 5 5 M
df[, 'x', drop = F]
#   x
# 1 1
# 2 2
# 3 3
# 4 4
# 5 5