# if 조건문
## 조건문은 주어진 조건이 참일때 실행할 문장을 제어할 때 사용하는 문장
x <- runif(1) # 0 ~ 1 사이의 난수

## x가 0보다 크면 절대값을 추출하는 조건문
if(x > 0) print(abs(x))
## x가 0.5보다 작으면 1 - x가 출력되고, 그렇지 않으면 x가 출력되는 조건문
if(x < 0.5) print(1 - x) else print(x)
## 위와 동일, 삼항연산자
ifelse(x < 0.5, 1 - x, x)

y <- -9
if(y %% 2 == 0) print('짝수') else print('홀수')

z <- -11
if(z %% 2 == 0){
  print(z)
  print('짝수입니다.')
  print(abs(z))
} else{
  print(z)
  print('홀수입니다.')
  print(abs(z))
}

# 양수, 음수, 0인지 판정하는 작업
data <- -10
ifelse(data > 0, '양수', ifelse(data < 0, '음수', '0이다'))

# 학점을 판정하는 프로그램
### 90점 이상 'A', 80점 이상 'B', 70점 이상 'C', 60점 이상 'D' 이외 'F'
point <- 75
grade <- point %/% 10
ifelse(grade >= 9, 'A', ifelse(grade >= 8, 'B', ifelse(grade >= 7, 'C', ifelse(grade >= 6, 'D', 'F')))) 
### switch ~ case
switch(as.character(grade),
       '10' = print('A학점'),
       '9' = print('A학점'),
       '8' = print('B학점'),
       '7' = print('C학점'),
       '6' = print('D학점'),
       print('F학점')
       )

# 반복문: 동일하거나 일정한 규칙을 가지고 있는 문장을 반복해서 처리한다.
# 개별변수 in 집합변수
for(i in seq(1, 5)){
  print(1)
}
# [1] 1
# [1] 1 2
# [1] 1 2 3
# [1] 1 2 3 4
# [1] 1 2 3 4 5

for(i in seq(5)){
  print(i)
}
for (i in 10) { 
  print(1:5)
}
# 1 ~ 10의 수를 더한 결과를 추출
total <- 0 # 누적변수의 초기값
for(i in seq(1, 10)){
  total = total + i
}
total

## 1부터 10까지 출력
for (i in 1:10) { 
  print(i)
}

i <- 1
while(i < 11){
  print(i)
  i <- i + 1
}

i <- 0
while(i < 10){
  i <- i + 1
  print(i)
}

## 3단 출력
dan <- 3

for(i in 1:9){
  cat(paste(dan, 'x', i, ' = ', dan * i, '\n'))
}
# 3 x 1  =  3 
# 3 x 2  =  6 
# 3 x 3  =  9 
# 3 x 4  =  12 
# 3 x 5  =  15 
# 3 x 6  =  18 
# 3 x 7  =  21 
# 3 x 8  =  24 
# 3 x 9  =  27 
