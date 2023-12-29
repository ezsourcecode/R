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
save(no, name, fruit, file = 'C:/k_digital/data/test.dat')
# 변수 삭제: rm()
rm(no, name, fruit)
# 저장된 데이터 불러오기
load('C:/k_digital/data/test.dat')

# csv 파일 읽어오는 작업 및 한글 안 깨지게
x <- read.csv('C:/k_digital/data/a.csv',header=T,
              fileEncoding = 'euc-kr',
              encoding = 'utf-8')
# 열머리글 없는 파일
y <- read.csv('C:/k_digital/data/b.csv',header=F,
              fileEncoding = 'euc-kr',
              encoding = 'utf-8')

# txt 파일 읽어오는 작업
## 텍스트 파일은 배열 형태로 읽어온다.
## 공백문자, 탭, 줄바꿈 등의 기준으로 단어 단위로 배열에 저장되서 처리된다.
## what = '자료형', 다양한 자료형이 섞여 있을 경우 what = ''
## UTF-8로 저장하면 한글이 깨질 수 있다. 메모장은 windows 한글지원(ms949)
a <- scan('C:/k_digital/data/sample.txt', what = '') # 배열이라 표가 아님

## 데이터 프레임 형태로 읽어오는 작업
## 이때 txt 파일의 커서는 데이터가 없는 마지막줄에 둬야 한다.
c <- read.table('C:/k_digital/data/sample.txt', header = T, sep = '\t')

# 엑셀 파일을 읽어오는 방법
## 외부 패키지 불러오기 readxl
install.packages('readxl')
library(readxl)

df_exam <- read_excel("C:/k_digital/data/excel_exam.xlsx")
df_exam_novar <- read_excel("C:/k_digital/data/excel_exam_novar.xlsx", col_names = F)
df_exam_sheet <- read_excel("C:/k_digital/data/excel_exam_sheet.xlsx", sheet = 3)
