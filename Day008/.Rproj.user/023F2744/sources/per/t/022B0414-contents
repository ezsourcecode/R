# classification과 classifier / 분류 - 분류(지도학습)와 군집(비지도학습)
# 필요 패키지 설치 및 로딩
library(dplyr)
library(ggplot2)

# 데이터 불러오기와 데이터 확인하는 방법
install.packages('readr') # read_csv
install.packages('descr') # 빈도표 만들어주는 #
library(readr)
library(descr)

# 데이터 불러오기
train <- readr::read_csv('C:/k_digital/data/titanic/train.csv') # read.csv()보다 메모리도 적게 쓰고 데이터를 더 빠르게 불러옴 #
test <- read_csv('C:/k_digital/data/titanic/test.csv')

head(train)
head(test)
str(train)

full <- bind_rows(train, test) # rbind()와 cbind() 이것들은 무조건 합쳐서 데이터가 어긋남. 하지만 이건 속성이 하나 빠져 있어도 데이터가 맞게 합쳐짐 #

# 변수의 의미 파악
names(train)
names(test)
## PassengerId
## Survive 생존여부 0(사망), 1(생존)
## Pclass 선실의 등급 1, 2, 3
## Name 
## Sex
## Age
## SibSp 동반가족수(형제 or 배우자)
## Parch 동반가족수(부모 or 자녀)
## Ticket 티켓번호
## Fare 승선비
## Cabin 선실
## Embarked 승선항 C, Q, S

# 사본 titanic
titanic <- train[, c(2, 3, 5:8, 12)]

# 변수 속성 변경
table(titanic$Survived)
table(titanic$Pclass)
table(titanic$Embarked)

titanic <- titanic %>% 
  mutate(Survived = factor(Survived), 
         Pclass = factor(Pclass),
         Sex = factor(Sex),
         Embarked = factor(Embarked)) # 변수들을 한 번에 팩터로 변환함 # 

str(titanic)
titanic <- as.data.frame(titanic)
summary(titanic)
# Age 의 경우 NA's   :177  결측치가 많으니 평균값으로 채운다.
# Embarked  
# C   :168  
# Q   : 77  
# S   :644  
# NA's:  2   최빈값인 S로 바꾼다

# 문제정의
## 전처리: 결측치와 이상치 처리
sapply(titanic, FUN = function(x) {
  sum(is.na(x)) # T = 1, F = 0로 결측값이 있으면 T가 더해서 나옴 # 
})
# Survived   Pclass      Sex      Age    SibSp    Parch Embarked 
#        0        0        0        0        0        0        0 

# 결측치 비율
titanic %>% 
  dplyr::summarise_all(funs(sum(is.na(.))/n()))
install.packages('tidyvers')


### 결측치 대체 - 보간법
mean(titanic$Age, na.rm = T)
titanic$Age <- ifelse(is.na(titanic$Age), mean(titanic$Age, na.rm = T), titanic$Age)
titanic$Embarked <- ifelse(is.na(titanic$Embarked), 3, titanic$Embarked) # 'S'를 넣어도 되어야 하는데 왜 안 되는지 모름 #

head(titanic, 10)
## 1. 생존비율 - 사망과 생존의 비율
proportions(table(titanic$Survived))* 100
ggplot(titanic, aes(Survived)) + geom_point()

## 2. 성별에 따라
gender <- ggplot(titanic , aes(x = Survived, fill = Sex, width = .8)) + geom_bar()
gender
xtabs(~ Sex + Survived, titanic)
titanic %>% 
  group_by(Sex) %>% 
  count(Survived)


## 3. 선실 등급에 따른 생존여부
xtabs(~Pclass + Survived, titanic)
pclass <- ggplot(titanic, aes(x = Survived, fill = Pclass)) + geom_bar()
pclass

c <- titanic %>% 
  group_by(Pclass) %>% 
  count(Survived)
pie(c$n)


## 4. 동반가족 수에 따른 생존여부
xtabs(~SibSp + Parch + Survived, titanic)
familysi <- ggplot(titanic, aes(x = Survived, fill = factor(SibSp))) + geom_bar()
ggplot(titanic, aes(x = Survived, fill = factor(Parch))) + geom_bar()
ggplot(titanic, aes(x = Survived, fill = fam)) + geom_bar()

fam <- titanic$SibSp + titanic$Parch
titanic$fam <- as.factor(fam)

b <- titanic %>% 
  group_by(fam) %>% 
  count(Survived)

pie(b$n)

## 5. 승선항에 따른 생존여부
xtabs(~ Survived + Embarked, titanic)
ggplot(titanic, aes(x = Survived, fill = Embarked)) + geom_bar()

a <- as.data.frame(titanic %>% 
                     group_by(Embarked) %>% 
                     count(Survived))
ggplot(a, aes(x = a$Embarked, y = a$n, fill = Survived)) + geom_col()

# 분류 분석(Classification Analysis)
## 학습을 통해 분류 모델을 학습하고 이를 통해 분류 예측하는 분석 기법
## 의사결정트리(Decision Tree), 나이브 베이스 분류, 신경망(ANN), 서포트 벡터(SVM)
