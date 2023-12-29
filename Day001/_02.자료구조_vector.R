# 자료형(data type): 변수와 상수의 크기를 규정해 놓은 예약어

## 변수(variable): 변하는 수, 기억장소
### 변수명을 작성하는 규칙(명명법): 영문자(대, 소문자), 숫자, 특수문자, 첫 글자 문자, _, $

## 상수(constant): 변하지 않는 수, 값(data)
## R의 기본 자료형: 수치형(numeric),문자형(character), 논리형(logical), 복소수형(complex)


## 대입연산자 or 치환연산자: 좌변 = 우변, v = c, v, 수식(일반적인 경우 변수 = 상수 대입됨), <-(R에서 권장), ->

### 변수
x <- 5
x
y = 10
y

## 출력함수 print()
print(x)

## 변수 대입과 동시에 출력
(z <- 2)

# 변수 제거: rm(변수명), rm = remove
rm(x, xx) #이후 x를 출력하면, 콘솔창에 object 'x' not found 문구가 나옴

xx <- print # 객체복사
xx('안녕하세요') # print('안녕하세요')와 동일한 결과 출력

## 현재 메모리에 저장된 변수의 목록을 확인하는 명령
ls() # 현재 변수 목록 확인

x<- "one"
print(x, quote = F) # quote = F 큰따옴표 안 나오는 옵션. 옵셥은  Ctrl + Space 입력하면 뜬다

# 출력서식을 지정하며 출력하는 함수 sprintf() = string print format
## 서식기호: %s 문자열, %f 실수형, %i 정수형
### 홍길동의 나이는 낭랑 18세입니다.
print("%s의 나이는 낭랑")
sprintf("%s의 나이는 낭랑 %i세입니다.", "이순신", 23)

# 자료구조: 데이터를 효율적으로 저장하기 위한 틀
## 벡터(vector): 하나 이상의 데이터를 관리하는 자료구조, 요소
## 벡터의 특징: R에서 하나 이상의 데이터를 관리하는 자료구조, scalar로 벡터로 취급
## 벡터의 생성함수: c()
## 벡터의 인덱스 시작값 1부터
## 하나의 벡터에는 하나의 자료형만 사용가능(숫자 문자 혼용시 문자로 취급)
## NA: 결측값(벡터에 결측값을 담기 가능)
v1 <- c(1, 2, 3, 4, 5) # num#
v2 <- 1:5 # int#
v3 <- c(1.5, 10, 'two', 5, 'five')
v4 <- c(100, "one", T, FALSE, 3.14)

## start:end, step=1 생략
x2 = 1:15

x3 = c('one', 'two', 'three')

x1 = c(1, 2, 3, 4)

# 벡터 합치기: append(변수1, 변수2)
x3 = append(x1, x2)
x4 = c(x1, 0, x2)

# vector(length = n): 요소가 n개인 비어있는 벡터를 생성하는 함수
vector(length = 5) # mode = "logical" 기본형

# 벡터 안에 또 다른 벡터를 담을 수 있다.
c(1, 2, 3, c(4:6))
y = c()
y = c(y, c(1:3)) # append 추가하는 것

# seq(start, stop, by), 생략하면 기본 값 by = 1. 파이썬 seq(from = , to = , by)
xx = seq(1, 5)
yy = c(1, 2, 3, 4, 5)
zz = 1:5

print(xx, yy, zz) # 첫 번째 값만 인식됨. 2개 이상의 변수는 인식 못 함. paste(), cat() 사용하면 모두 인식 가능

seq(0, 1, length.out = 11) # length.out - 요소의 개수. 값 0.0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0

a = seq(10) # 10개의 요소를 갖고 있는 벡터

## rep(벡터, times = 반복횟수),  each = 요소별 반복횟수
rep(c(1:3), times = 3)
rep(c(1:3), each = 2) # 값 1 1 2 2 3 3

# 자료형을 이용한 벡터의 생성
### numeric(integer, double). character, logical

integer(length = 10) # 정수형의 기본값은 0 실수형은 0.0 논리형은 FALSE. 값 0 0 0 0 0 0 0 0 0 0

## 벡터를 구성하는 자료를 요소(item)라고 부른다.
## 요소의 위치를 인덱스(index)라고 부른다.
## 인덱스의 시작은 1부터다.
### 인덱스를 이용한 요소에 접근 [], [조건식]
x = 1:11
x[5] # 특정 위치
x[2:5]# 2~5번째 연속된 인덱스 출력
x[c(1, 3, 5)] # 컴바인 함수에 속한 인덱스 출력

# 벡터의 각 셀에 이름을 부여할 수 있다.
y = c(a=1, b=10, c=7)
y['a']
y[c('b','c')] # R은 두 개 이상을 출력할 때 꼭 c()를 사용해야 한다. 안 그럼 출력 안 됨

xx = c(1, 3, 5)
names(xx) = c('lee', 'kim', 'park')
xx

xx[c('lee', 'park')]
names(xx) # xx의 요소 이름들만 다 출력
names(xx)[2] # xx의 2번째 요소 이름만 출력

## 벡터의 주요 내장함수
typeof(xx) # 자료형 확인
mode(xx) # 기본 자료형 4개중 하나인 걸 확인

### 벡터의 길이 = 벡터를 구성하는 요소의 개수, length()
a = c('x', 'y', 'z')
a[-2] # 해당 인덱스를 제외 여기선 2번째 인덱스 제외하고 출력
length(a)

## NROW() 모두 대문자로, 행렬과 벡터에서 모두 사용 가능. 행의 수
## nrow() 모두 소문자로, 행렬(matrix)에서 행의 개수를 추출하는 함수

NROW(a)
nrow(a) # matrix만 출력이 가능해서 NULL값이 출력됨

## 통계함수
### cor(): 상관계수, cumsum(): 누적함수, length(): 요소의 개수
### max(): 최대값, mean(): 평균값, min(): 최소값, range(): 범위
### rank(): 순위, sd(): 표준편차, sum(): 합계, summary(): 기초통계량

## 데이터 분석에서 주로 사용되는 함수: matrix(행과 열을 구 성- 다 똑같은 자료형이어야함)나 dataframe(표, table - 서로 다른 자료형도 됨)
## head(), tail(), summary()

# R에 내장된 데이터셋 - data()
data()
help(iris)
iris
data('iris')

# 데이터 구조
str(iris)

head(iris, 10) # 기본 앞에 데이터 6개 출력. 파이썬은 5개 출력. 뒤 숫자가 보고 싶은 데이터 수
tail(iris)

summary(iris)

x = 1:10

# 총합 sum()
sum(x) # 값 55
# 평균 mean()
mean(x) # 값 5.5
# 분산 var()
var(x) # 값 9.166667
# 표준편차 sd()
sd(x) # 값 3.02765

median(c(1, 2, 3, 4)) # 값 2.5

range(x) # 범위를 알려줌. 값 1 10

quantile(x) # 사분위 값을 알려줌
# 0%   25%   50%   75%  100% 
# 1.00  3.25  5.50  7.75 10.00 

## 벡터의 연산: 벡터의 요소들을 이용하여 수정, 삭제, 추가
## 사칙연산과 내장함수

## 스칼라(scalar): 하나의 요소로 구성된 자료구조
## 벡터(vector): 하나 or 그 이상의 요소로 구성된 자료구조

# 자료구조의 시작은 변수 x=10은 스칼라이자 벡터. 즉, 요소가 1개인 벡터#
y = c(1:5)

length(y) # 벡터 요소의 개수

x = c(1:5)
y = c(6:10)
x + y # 벡터화 연산. 값 7  9 11 13 15
z = c(1:3)
z + x # 값 2 4 6 5 7과 오류 메세지가 출력됨 1 2 3 1 2 + 1 2 3 4 5
x - 9 # 값 -8 -7 -6 -5 -4과 오류 메세지 출력됨. 위와 같이 작은 걸 큰 개수로 맞춤
x * 3 # 값 3 6 9 12 15 출력

x[3] = 30 # x의 3번째 값을 30으로 바꿔라
x[c(2, 4)] = 9 # x의 2, 4번째 값을 9로 바꿔라


## 벡터 x의 모든 요소의 값을 1로 변경하시오
x[1:5] = 1 # 연속되는 값을 바꿀 땐 이렇게해도 출력되나, 컴바인 권장함

## 벡터 x의 첫 번째 요소 자리에 0을 추가
x = c(0, x)

## append(벡터, 벡터)로 마지막 요소 자리에 0을 추가
x = append(x, 0)
help(append)
v_a = c('A', 'B', 'C', 'F', 'G')
v_b = c('D', 'E')
append(v_a, v_b, 3) -> v_c # v_a 3번째 위치 뒤에 v_b추가

## 벡터 요소 삭제: - 
v_a = 11:20

# v_a의 1, 3, 5, 6 위치의 값만 화면에 표시
v_a[c(1, 3, 5, 6)]

# v_a의 1, 3, 5, 6 뺀 값만 화면에 표시
v_a[-c(1, 3, 5, 6)]


# v_a의 마지막 요소 값 추출
length(v_a)
v_a[10]
# v_a의 마지막 요소 값 빼고 추출
v_a[-10]
v_a[-length(v_a)]

# 논리형 벡터: 논리형(logical) - TRUE(T), FALSE(F)
v_b = c(F, T, T, F, F)

# and/ &, or/ |, not/ !
!v_b #  벡터화 연산으로 T, F, F, T, T 출력됨
v_b[-c(2:3)]

# 펜시인덱스
## 논리값을 이용하여 인덱스 처리하는 기능
v_t = c('첫번째', '두번째', '세번째', '네번째', '다섯번째')


## 두번째, 세번째 요소만 추출
v_t[c(2:3)]
# 논리값으로 팩터의 인덱스로 쓸 수 있음 #
v_t[v_b]

## %in%: ~안에 포함여부를 판단(TRUE or FALSE)하여 출력하는 연산자
'a' %in% c('a', 'b', 'c') # 하나라도 있음 TRUE가 출력됨

## 합집합(union), 교집합(intersect), 차집합(setdiff)
setdiff(c('a', 'b', 'c'), c('a', 'd')) # b, c 출력
intersect(c('a', 'b', 'c'), c('a', 'd')) # a 출력
union(c('a', 'b', 'c'), c('a', 'd')) # a, b, c, d 출력

## 집합간의 비교연산
setequal(c('a', 'b', 'c'), c('a', 'd')) # FALSE 출력 
setequal(c('a', 'b', 'c'), c('a', 'b', 'b', 'c')) # TRUE 출력 

## all() and의 의미, any() or의 의미
x = 1:10
x > 5 # FALSE FALSE FALSE FALSE FALSE  TRUE  TRUE  TRUE  TRUE  TRUE 출력됨
all(x > 5) # 모든 요소가 5보다 큰가. 값 FALSE 출력
any(x > 5) # 하나라도 5보다 큰가. 값 TRUE 출력

head(x)
tail(x, 3)
