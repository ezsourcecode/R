
# 복지 패널 데이터를 이용한 데이터 분석 - 한국인의 삶을 파악하라

## step 1. 필요 패키지 설치와 로딩
install.packages('foreign') ## spss 전용 파일 등 외부파일을 불러올 때
library(foreign)
library(readxl)
library(ggplot2)
library(dplyr)
## step 2. 데이터셋 로딩
raw <- read.spss(file = 'C:/k_digital/data/Koweps_hpc10_2015_beta1.sav', to.data.frame = T)
## step 3. 사본
welfare <- raw
## step 4. 기본 데이터 분석 - 데이터 기본 정보 확인
dim(welfare)
str(welfare)
## step 5. 파생변수 생성 or 변수 이름 변경 - 가독성
welfare <- rename(welfare,
           gender= h10_g3,
           year = h10_g4,
           marriage = h10_g10,
           religion = h10_g11,
           code_job = h10_eco9,
           income = p1002_8aq1,
           code_region = h10_reg7)


## 1. 성별에 따른 급여의 차이는 있을까?
### 성비 분석: 도수분포표
table(welfare$gender)
addmargins(table(welfare$gender)) # addmargins는 합계까지 나옴
### M(1) F(2)
welfare$gender <- ifelse(welfare$gender == 1, 'M', 'F')
ggplot(welfare, aes(gender)) + geom_bar()

### 급여정보 데이터 분석
summary(welfare$income) # 결측값이 너무 많음
# 결측치 처리, 0
gender_income <- welfare %>%
  filter(!is.na(income)) %>%
  group_by(gender) %>% 
  summarise(mean_income = mean(income))
gender_income

# 시각화 자료 추가

## 2. 나이와 급여의 관계는 있을까?
### 파생변수 (age) = 현재년도(2015) - 출생년도 +1
summary(welfare$year)
table(welfare$year)
welfare$age <- 2015 - welfare$year + 1
summary(welfare$age)
age_income <- welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(age) %>% 
  summarise(mean_income = mean(income))
head(age_income, 20)

## 시계열 분석
ggplot(age_income, aes(x = age, y = mean_income)) + geom_line()

## 3. 연령대에 따른 급여의 차이는 있을까?
## 연령대: 청소년(30세 미만) - young, 중장년(60세 미만) - middle, 노년(60세 이상) - old
welfare$gen <- ifelse(welfare$age < 30, 'young', ifelse(welfare$age < 60, 'middle', 'old'))
table(welfare$gen)
ages_income <- welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(gen) %>% 
  summarise(mean_income = mean(income))
ages_income

## 시각화


## 4. 연령대와 성별에 따른 급여의 차이는 있을까?
age_gender_income <- welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(gen, gender) %>% 
  summarise(mean_income = mean(income))
age_gender_income
## 5. 직업별 급여의 차이는 있을까?
job_income <- welfare %>% 
  filter(!is.na(code_job) & !is.na(income)) %>% 
  group_by(job) %>% 
  summarise(mean_income = mean(income))
job_income

## 6. 성별에 따라 선호하는 직군이 있는가?
### 엑셀 파일에서 특정 시트에 있는 내용을 불러오는 작업
jobList <- read_excel('C:/k_digital/data/Koweps_Codebook.xlsx', sheet = 2, col_names = T)
dim(jobList)
### welfare 데이터 프레임에 열 추가, 하나의 데이터 프레임으로 합치는 작업
welfare <- left_join(welfare, jobList, by = 'code_job')

male_job <- welfare %>% 
  filter(!is.na(code_job) & gender == 'M') %>% 
  group_by(job) %>% 
  summarise(count = n()) %>% 
  arrange(-count)
male_job
female_job <- welfare %>% 
  filter(!is.na(code_job) & gender == 'F') %>% 
  group_by(job) %>% 
  summarise(count = n()) %>% 
  arrange(-count)
female_job
## 7. 직군별 급여의 차이는 있는가?
## 8. 종교 유무에 따른 이혼율의 차이는 있는가?
### 종교 유무 1: Y(있다) 2: N(없다)
### 결혼 상태 1: FAM(유배우) 2: DEATH(사별) 3: DIV(이혼) 4: SEP(별거) 5: NO(미혼, 18세미만), 6: ETA(기타)
welfare$religion <- ifelse(welfare$religion == 1, 'Y', 'N')
summary(welfare$marriage)
welfare$marriage <- ifelse(welfare$marriage < 2, 'FAM', ifelse(welfare$marriage < 3, 'DEATH', ifelse(welfare$marriage < 4, 'DIV', ifelse(welfare$marriage < 5, 'SEP', ifelse(welfare$marriage < 6, 'NO', 'ETA')))))
