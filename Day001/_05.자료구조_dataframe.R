# 데이터프레임(dataframe): 데이터베이스의 표(table)
## 단일 자료형을 사용하는 자료구조: 벡터, 팩터, 행렬, 배열
## 다중 자료형을 사용하는 자료구조: 데이터프레임, 리스트
## 데이터 분석의 기본 자료형: 행(record, 관측데이터), 열(attribute, feature, 특성)
help(data.frame)

## 데이터프레임 생성, ex) as.data.frame(matrix) 행렬을 데이터프레임으로 바꾼다. 하지만 데이터프레임은 다양한 데이터 형태를 담을 수 있기에 모든 데이터프레임을 행렬로 못 바꿈
## data.frame(data, matrix)
aa = data.frame(x = c(1:5), y = c('a', 'b', 'c', 'd', 'e')) # 자료의 개수가 일치해야 함
#   x y
# 1 1 a
# 2 2 b
# 3 3 c
# 4 4 d
# 5 5 e

## 여러 개의 벡터를 이용한 데이터프레임 생성
names = c ('홍길동', '이순신', '장보고', '임꺽정', '김유신')
ages = c(20, 23, 31, 28, 35)
scores = c(80, 95, 87, 100, 79)
gender = c('F', 'M', 'M', 'F', 'F')

student = data.frame(names, ages, scores, gender)
#     names ages scores gender
# 1 홍길동   20     80      F
# 2 이순신   23     95      M
# 3 장보고   31     87      M
# 4 임꺽정   28    100      F
# 5 김유신   35     79      F

stu = data.frame(name = names, age = ages, gender = gender, score = scores)
#     name age gender score
# 1 홍길동  20      F    80
# 2 이순신  23      M    95
# 3 장보고  31      M    87
# 4 임꺽정  28      F   100
# 5 김유신  35      F    79
str(stu)
stu$name # name의 속성을 출력해라
stu$name[3] # 장보고 추출
stu[4, 2] # 28 추출
stu[, 3:4] # gender, score만 추출

