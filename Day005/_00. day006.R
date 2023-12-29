library(stringr)
v <- c('A', 'B', 'C')
str_c(v, '_1') # [1] "A_1" "B_1" "C_1"
paste(v, '_1') # [1] "A _1" "B _1" "C _1"
paste0(v, '_1') # [1] "A_1" "B_1" "C_1"

paste(v, '1') # [1] "A 1" "B 1" "C 1"
paste(v, '1', sep = '_') # [1] "A_1" "B_1" "C_1"
str_c(v, '1', sep = '_') # [1] "A_1" "B_1" "C_1"

# Character 개수 카운트
## nchar(x)
## str_length(x)
s <- "Hello"
nchar(s) # [1] 5
str_length(s) # [1] 5

# 소문자 변환
## tolower(x)
tolower(s) # [1] "hello"

# 대문자 변환
##toupper()
toupper(s) # [1] "HELLO"

# 2개의 문자 벡터에 중복 항목 없이 합치기
## union(x, y)
x <- c('hello', 'world', 'r', 'program')
y <- c('hi', 'world', 'r', 'coding')
union(x, y) # [1] "hello"   "world"   "r"       "program" "hi"      "coding" 

## intersect(x, y) 교집합
intersect(x, y) # [1] "world" "r" 

## setdiff(x, y) 차집합, 공통되지 않는 값만 추출
setdiff(x, y) # x에서 추출 [1] "hello"   "program"

## setequal(x, y)
setequal(x, y) # 논리값으로 출력됨 [1] FALSE

## 문자 공백 제거: trim
### str_trim(x, side = 'both'나 'left'나 'right')
s2 <- c("     Hellow World     ", "          Hi R           ")
str_trim(s2)
str_trim(s2, side = 'left')
str_trim(s2, side = 'right')

## String 반복해서 추출
### rep(x, times, each, length.out)
rep(1:3, times = 2)
# [1] 1 2 3 1 2 3
rep(1:3, times = 2, each = 3)
# [1] 1 1 1 2 2 2 3 3 3 1 1 1 2 2 2 3 3 3
rep(1:3, times = 2, each = 3, len = 4)
# [1] 1 1 1 2
rep('Hello', 3)

### str_dup(x, times)
str(str_dup(1:3, times =2)) # chr [1:3] "11" "22" "33"
str_dup('Hello', 3) # [1] "HelloHelloHello"

# 문자열 일부분 추출
## substr(x, start, stop)
s3 <- 'Hello world!'
substr(s3, 7, 9) # [1] "wor"

string <- 'Today is Sunday'
substr(string, 10, 12) # [1] "Sun"
substring(string, 10, 12) # 동일 결과

# 함수(Function)
## 함수명 <- function(매개변수){함수 몸체}
fibo <- function(n){
  if(n %% 2 == 0){
    print("짝수")
  }else
    print("홀수")
}
fibo(1)


# plot => qplot => ggplot
library(ggplot2)
barplot(mpg$hwy)
qplot(hwy, mpg) # ggplot2 3.4.0.이하까지만 지원하는 기능이라 못 씀. 결론 사장됨

# plot(x, y, xlab, ylab, main)
# 점의 종류(pch)
# 점의 크기(cex)
# 점의 색상(col), col = #FFFF00 or 'yellow'

install.packages('mlbench')
library(mlbench)
data(Ozone)
str(Ozone)

plot(Ozone$V8, Ozone$V9,
     xlab = 'Sandburg Temp', ylab = 'El Monte Temp', # 축 제목
     main = 'Ozone', # 차트 제목
     pch = 20, # 점의 종류
     cex = 1.5, # 점의 크기
     col = '#0f00ff') # 색상

# 축값 범위(xlim, ylim) xlim =  c(최소값, 최대값)
max(Ozone$V8, na.rm = T) # [1] 93
max(Ozone$V9, na.rm = T) # [1] 82.58

plot(Ozone$V8, Ozone$V9,
     xlab = 'Sandburg Temp', ylab = 'El Monte Temp', # 축 제목
     main = 'Ozone', # 차트 제목
     pch = 20, # 점의 종류
     cex = 1.5, # 점의 크기
     col = '#0f00ff',# 색상
     xlim = c(0, 100), ylim = c(0,90)) 
