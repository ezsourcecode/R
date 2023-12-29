# 함수(Function)
## 내장 함수와 사용자 정의 함수
### R에서 함수를 정의하는 방법

gugu <- function(){
  dan <- readline('단을 입력하세요: ')
  dan <- as.integer(dan)
  for(i in 1:9){
     cat(paste(dan, 'X', i, ' = ', dan * i, '\n'))
  }
}
gugu()

# 구구단 출력
for(dan in 2:9){
  cat(paste('\n', dan, '단 결과값', '\n'))
  for(i in 1:9){
    cat(paste(dan, 'X', i, ' = ', dan * i, '\n'))
  }
}

## 1 ~ 10의 합을 계산하여 출력하는 프로그램
tot <- 0
for(i in 1:10){
  tot <- tot + i
}
tot

while(i < 11){
  tot <- tot + i
  i <- i + 1
}
tot

## repeat
tot <- 0
i <- 1
repeat{ # 무한loop를 벗어나는 break를 꼭 써줘야 함
  tot <- tot + i
  i <- i + 1
  if(i > 10) break
}
