# 특수상수 is.na(), is.null()
x <- NA
is.na(x)
is.null(x)
# 난수 생성 함수
x <- rnorm(5, mean = 10) # 해당 수만큼 난수를 생성함, 뒤에 함수에 가까운 값을 생성함
# 백터 생성 및 인덱스로 값 바꾸기
v1 <- seq(1:5)
v2 <- seq(from = 6, to = 10, by =1)
# 백터 비교
v1 == v2
# 중복값 제거 
x <-rep(1:2, 5, time = 2)
unique(x)
# paste()
paste('abc', 'def', 'ghi', sep = '*') # sep =을 넣어 문자열 사이를 채울 수 있음
paste(v1[3], v2) # [1] "3 6"  "3 7"  "3 8"  "3 9"  "3 10"
# substring()
substring('text blabla~ rstudio', 1, 4) # text 출력
# 논리 연산자
T == F # and &
T | F # or 
! T # not


# 팬시인덱스: 조건에 의해 원하는 값을 추출 # 셋다 [1] "logical"
x <- c(F, T, F, F, T)
y <- c(1:5)
mode(x)
typeof(x)
class(x)
y[x] # 조건인 참인 것만 출력 [1] 2 5


# 반복문
# 1 ~ 10의 수를 더한 결과를 추출
total <- 0 # 누적변수의 초기값
for (i in seq(10)) {
  total <- i +total
  print(total)
}
# 3단 만들기
dan <- 3
for(i in 1:9){
  cat(paste(dan, 'x', i, ' = ', dan * i,'\n'))
}

# 이용자가 입력하는 구구단 만들기
gu <- function(){
  dan <- readline("단을 입력해주세요: ")
  dan <- as.integer(dan)
  for(i in 1:9){
    cat(paste(dan, 'x', i, ' = ', dan * i, '\n'))
  }
}
gu()
# 구구단 전체 출력
for(dan in 2:9){
  cat(paste('\n', dan, '단 결과', '\n'))
  for(i in 1:9){
    cat(paste(dan, 'X', i, ' = ', dan * i, '\n'))
  }
}


# csv 파일 읽어오는 작업 및 한글 안 깨지게
x <- read.csv('C:/k_digital/data/a.csv',header=T,
              fileEncoding = 'euc-kr',
              encoding = 'utf-8')
# 열머리글 없는 파일
y <- read.csv('C:/k_digital/data/b.csv',header=F,
              fileEncoding = 'euc-kr',
              encoding = 'utf-8')


# 파일 입출력
## 벡터 데이터 생성
no <- c(1:4)
name <- c('apple', 'banana', 'peach', 'berry')
price <- c(500, 300, 800, 200)
qty <- c(5, 2, 7, 9)

## 백터 데이터를 이용하여 데이터프레임 생성
fruit <- data.frame(No = no, Name = name, Price = price, Qty = qty)
ls() # 현재 선언된 변수 목록 확인

## no, name, fruit를 test.dat 파일로 저장
save(fruit, file = 'C:/k_digital/r/source/test2.dat')
# 저장된 데이터 불러오기
load('C:/k_digital/r/source/test2.dat')
# txt 파일 읽어오는 작업. 배열 형태로 읽어온다.
## 공백문자, 탭, 줄바꿈 등의 기준으로 단어 단위로 배열에 저장되서 처리된다.
## what = '자료형', 다양한 자료형이 섞여 있을 경우 what = ''
## UTF-8로 저장하면 한글이 깨질 수 있다. 메모장은 windows 한글지원(ms949)
a <- scan('C:/k_digital/data/sample.txt', what = '') # 배열이라 표가 아님

## 데이터 프레임 형태로 읽어오는 작업
## 이때 txt 파일의 커서는 데이터가 없는 마지막줄에 둬야 한다.
c <- read.table('C:/k_digital/data/sample.txt', header = T, sep = '\t')

# 엑셀 파일을 읽어오는 방법
## 외부 패키지 불러오기 readxl
library(readxl)

df_exam <- read_excel("C:/k_digital/data/excel_exam.xlsx")
df_exam_novar <- read_excel("C:/k_digital/data/excel_exam_novar.xlsx", col_names = F) # 첫 행부터 데이터가 시작되는 경우
df_exam_sheet <- read_excel("C:/k_digital/data/excel_exam_sheet.xlsx", sheet = 3) # 시트3에 있는 데이터