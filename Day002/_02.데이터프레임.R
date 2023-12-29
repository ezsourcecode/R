# 데이터 프레임의 내용에 접근
## [인덱스], [행 인덱스, 열 인덱스], [행 인덱스, 열 인덱스, 면 인덱스]
## [조건식]

### 팬시인덱스: 조건에 의해 원하는 값을 추출
x <- c(F, T, F, F, T)
y <- c(1:5)
mode(x)
typeof(x)
class(x)
# 셋다 [1] "logical"

y[x] # 조건에서 참인것만 추출함

a <- matrix(1:9, nrow =3)
#       [,1] [,2] [,3]
# [1,]    1    4    7
# [2,]    2    5    8
# [3,]    3    6    9
# a에서 4보다 큰 값을 찾기
a[ , ] > 4
#       [,1]  [,2] [,3]
# [1,] FALSE FALSE TRUE
# [2,] FALSE  TRUE TRUE
a[a[ , ] > 4, ]
# [1] 5 6 7 8 9

x <- 1:3
a[x %% 2 == 1, ]
#       [,1] [,2] [,3]
# [1,]    1    4    7
# [2,]    3    6    9

# 데이터프레임 내용의 접근 $변수명
d <- data.frame(x = c(1:5), y = seq(2, 10, 2))
d$x # [1] 1 2 3 4 5
d[, 'x', drop = F]
#   x
# 1 1
# 2 2
# 3 3
# 4 4
# 5 5

# 데이터 프레임의 열이름(colnames) = names()
colnames(d)
names(d)
# 둘다 [1] "x" "y"
rownames(d) # 기본 생성되는 행 숫자가 문자로 나타남 [1] "1" "2" "3" "4" "5"

# 여러 개의 벡터를 이용하여 데이터프레임을 생성
name = c('홍길동', '장보고', '유관순', '이순신', '강감찬')
age = c(20, 25, 19, 22, 31)
gender = factor(c('M', 'F', 'F', 'M', 'F'))
blood.type = factor(c('A', 'O', 'AB', 'B', 'O'))

p <- data.frame(name, age, gender, blood.type)
p2 <- data.frame(name = c('홍길동', '장보고', '유관순', '이순신', '강감찬'),
                 age = c(20, 25, 19, 22, 31),
                 gender = factor(c('M', 'F', 'F', 'M', 'F')),
                 blood.type = factor(c('A', 'O', 'AB', 'B', 'O')))

p[1, ]
#     name age gender blood.type
# 1 홍길동  20      M          A
p[, 2] # 데이터 형식이 깨짐 [1] 20 25 19 22 31
p[p$name == '유관순', ] # 유관순의 정보만 출력
#     name age gender blood.type
# 3 유관순  19      F         AB
# 이순신의 나이와 혈액형만
p[p$name == '이순신', c('age', 'blood.type')]
#     age blood.type
# 4  22          B

# 데이터프레임에 유용한 함수
## R에 내장된 데이터셋 data()
data(cars) ## 내장데이터 cars 사용
# 자동차의 속도와 제동거리의 상관관계를 분석하기 위해 수집된 데이터 셋
cars

str(cars) ## 구조확인
cars$speed # 속도
cars$dist # 제동거리

## 데이터프레임의 속성명을 변수명으로 사용
## attach - 설정, detach - 해제
attach(cars) # speed, dist 속성을 바로 변수로 바꿔 speed, dist만 써도 나오게 함
detach(cars)

# 평균 자동차 속도
mean(cars$speed)

# with(데이터셋, 변수명)
with(cars, mean(speed))

# 데이터 프레임의 일부분 추출
head(cars) # 앞 부분 기본 6개 추출
tail(cars, 10) # 뒤 10개 추출

# subset(데이터프레임, 조건식, select)
## cars 데이터셋에서 속도가 20을 초과하는 데이터만 추출
cars[cars$speed > 20, ] 
subset(cars, speed > 20)

## 속도가 20이상, 23이하인 데이터 추출
subset(cars, speed >= 20 & speed <= 23)

## 속도가 20이상인 데이터의 dist만 추출
subset(cars, speed > 20, dist) # 데이터 형태 유지됨
cars[cars$speed >=20 & cars$speed <= 23, 'dist'] # drop = F를 써야 형태가 유지됨
