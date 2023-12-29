### apply(행렬, 방향, 함수): 행 or 열 방향으로 특정 함수를 적용할 때 사용
d <- matrix(1:9, ncol = 3)
#       [,1] [,2] [,3]
# [1,]    1    4    7
# [2,]    2    5    8
# [3,]    3    6    9
### 주어진 행렬의 행들의 합을 계산
apply(d, 1, sum) # 1: 행방향→ [1] 12 15 18 #
apply(d, 2, sum) # 2: 열방향↓ [1]  6 15 24 #
### iris 데이터의 각 컬럼(feature) 합을 계산
data(iris)
apply(iris[, -5], 2, sum)
colSums(iris[, 1:4]) # 동일 결과. 이런 것도 있음 rowSums(), rowMeans(), colMeans() #
# Sepal.Length  Sepal.Width Petal.Length  Petal.Width 
# 876.5        458.6        563.7        179.9
## lapply(벡터 or 리스트, 함수) 결과가 리스트로 반환된다.
la <- lapply(2:4, function(x){x / 2})
# [[1]]
# [1] 1
# 
# [[2]]
# [1] 1.5
# 
# [[3]]
# [1] 2
## 리스트를 벡터로 변환하는 함수
unlist(la)
## 리스트 생성: 키와 값을 쌍으로 관리하는 자료구조
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
colMeans(iris[, -5]) # 위와 같은 값이 나오나 리스트처럼 일렬로 출력은 안 됨 #
### 리스트를 데이터 프레임으로 변환할 때
### 1. unlist() 함수로 리스트를 벡터로 변환
unlist(lapply(iris[, -5], mean))
# Sepal.Length  Sepal.Width Petal.Length  Petal.Width 
# 5.843333     3.057333     3.758000     1.199333 
### 2. matrix() 함수로 벡터를 행렬로 변환
matrix(unlist(lapply(iris[, -5], mean)), ncol = 4, byrow = T)
#           [,1]     [,2]  [,3]     [,4]
# [1,] 5.843333 3.057333 3.758 1.199333
### 3. as.data.frame() 함수로 행렬을 데이터 프레임으로 변환
as.data.frame(matrix(unlist(lapply(iris[, -5], mean)), ncol = 4, byrow = T))
#         V1       V2    V3       V4
# 1 5.843333 3.057333 3.758 1.199333
### 4. names() 함수로 리스트로부터 컬럼명을 얻어와 데이터 프레임에 부여
na <- names(iris[, -5])
df <- as.data.frame(matrix(unlist(lapply(iris[, -5], mean)), ncol = 4, byrow = T))
names(df) <- na # 변수 지정 안 하고 names(iris[-5])로 해도 됨 #
# sapply: lapply와 유사하지만 리스트 대신 행렬, 벡터 등으로 결과가 반환된다.
## iris 컬럼별 평균 계산
sapply(iris[, -5], mean) # lapply와 달리 리스트가 아닌 벡터 형식으로 반환된다 #
# Sepal.Length  Sepal.Width Petal.Length  Petal.Width 
# 5.843333     3.057333     3.758000     1.199333 
class(sapply(iris[, -5], mean)) # [1] "numeric"
as.data.frame(sapply(iris[, -5], mean)) # 열과 행이 바뀜 #
# Sepal.Length                 5.843333
# Sepal.Width                  3.057333
# Petal.Length                 3.758000
# Petal.Width                  1.199333
as.data.frame(t(sapply(iris[, -5], mean))) # t()를 써서 전치시킴 #
#   Sepal.Length Sepal.Width Petal.Length Petal.Width
#      5.843333    3.057333        3.758    1.199333
# tapply(데이터, 색인_어떤 그룹에 속하는 지 표현하는 것, 함수): 그룹별 처리를 위한 apply 함수
tapply(1:5, rep(2, 5), sum)
# 2 
# 15
## 홀,짝별로 묶어서 합계를 구하시오.
tapply(1:10, 1:10 %% 2 == 0, sum) # F = 홀, T = 짝 #
### 행렬(행- 계절, 열- 성)
m <- matrix(1:8, ncol = 2, dimnames = list(c('spring', 'summer', 'fall', 'winter'),c('male', 'female')))
#         male female
# spring    1      5
# summer    2      6
# fall      3      7
# winter    4      8
### 분기별 남성과 여성 합계를 구하시오.
### 상반기(봄, 여름), 하반기(가을, 겨울)
tapply(c(m[1:2, 1]), c(m[1:2, 2]), sum)
tapply(m, list(c(1, 1, 2, 2, 1, 1, 2, 2), c(1, 1, 1, 1, 2, 2, 2, 2)), sum)
#   1  2
# 1 3 11
# 2 7 15





