# t_test: 두 집단 간 평균 비교
## 정규성 확인 및 검정
## 등분산성 검정

# 단일 표본 t-test(one sample t-test): 특정 그룹에 평균이 특정 값과 같은지 비교
# 독립 표본 t-test(two sample t-test): 서로 다른 두 그룹간의 평균을 비교
# 대응 표본 t-test(paired t-test): 한 그룹 내에서 동일한 대상을 반복 측정해서 전후 평균을 비교

df <- read.spss('C:/k_digital/data/HN18/HN18_ALL.sav', to.data.frame = T, reencode = 'UTF-8')
names(df)
## 추출할 변수: id, 성별, 나이, 당뇨병 유무,(19세 이상), 인슐린 주사, 공복 혈당, 당화혈색소
vars <- c('ID', 'sex', 'age', 'HE_DM', 'DE1_31', 'HE_glu','HE_HbA1c')
data_f <- select(df, vars)
head(data_f, 10)

# 변수별 결측치 확인
introduce(data_f)
#   rows columns discrete_columns continuous_columns all_missing_columns
# 1 7992       7                1                  6                   0
#   total_missing_values complete_rows total_observations memory_usage
# 1                 5232          5853              55944       961336

# 결측치 제거: na.omit() 결측이 존재하는 행을 제거하는 함수
data_f <- na.omit(data_f)

# 가설: 당뇨환자에게 인슐린 투여군과 비투여군의 혈당에 차이가 있다
## 당뇨병 유병 여부(19세 이상): 1(정상), 2(공복혈당장애), 3(당뇨병)
### 재분류: 1(정상), 2(공복혈당장애)이면 0-정상, 3(당뇨병)이면 1-당뇨병
table(data_f$HE_DM)
#   1    2    3 
# 3657 1474  722 
data_f$HE_DM2 <- ifelse(data_f$HE_DM == 3, 1, 0)
table(data_f$HE_DM2)
#   0    1 
# 5131  722 

# 인슐린 투여 DE1_31
## 0(아니오), 1(예), 8(비해당), 9(모름)
## 필요대상 추출
data_subj <- subset(data_f, data_f$HE_DM2 == 1 & data_f$DE1_31 == 0 | data_f$DE1_31 == 1)
nrow(data_subj) # [1] 506

## 데이터 확인
head(data_subj, 10)

# t검정 수행시 사전에 정규성을 띄고 있어야 한다는 전제 조건
## 시각적인 방법(히스토그램 + 밀도선)과 통계량을 이용하는 방법
### histogram
hist(data_subj$HE_glu, freq = F, ylim = c(0, 0.02), xlab = 'HE_glu(공복혈당)')
### kernel density plot
lines(density(data_subj$HE_glu), col = 'orange', lwd = 2)

## Q-Q plot
qqnorm(data_subj$HE_glu, col = 'green')
qqline(data_subj$HE_glu, col = 'orange', lwd = 2) # 정규분포를 나타내는 선 #

### Shapiro-Wilk test: 정규성 검정(표본 크기가 5,000을 넘을 경우 오류가 발생한다.)
#### 귀무가설(H0): 정규분포를 따른다.
#### 대립가설(H1, 연구가설, 나의 가설): 정규분포를 따르지 않는다.
shapiro.test(data_subj$HE_glu)
# W = 0.92158, p-value = 1.43e-15 # p값이 0.05보다 작아 대립가설이 채택됨. 귀무가설 기각. 정규분포를 따르지 않는다 #

# Kolmogorov-Smirnov test
ks.test(data_subj$HE_glu, y = 'pnorm', alternative = 'two.sided')

# 등분산성 검정
## 귀무가설: 두 그룹의 분산은 차이가 없다.
## 대립가설: 두 그룹의 분산은 차이가 있다.
var.test(data_subj$HE_glu ~ data_subj$DE1_31)
# p-value = 2.38e-08 # p값이 0.05보다 작다 정규분포를 따르지 않는다. # 

# 데이터 분석 결과
## 정규분포를 따르지 않고, 인슐린 투여 그룹 간 분산이 달랐다.
t.test(data_subj$HE_glu ~ data_subj$DE1_31, paired = F, var.equal = F, conf.level = 0.5)
# p-value = 0.1676 # p값이 0.05보다 큼. 인슐린 투여 여부에 따라 공복혈당이 다르지 않다고 할 수 있다.

# 일원배치 분산분석(one-way ANOVA)
## 세개 이상의 집단간의 평균 차이가 통계적으로 유의미한지 비교할 때 사용
## 가정: 정규성, 등분산성, 독립성
### 귀무가설: 모든 모집단의 평균은 동일하다.
### 대립가설: 모든 모집단의 평균은 동일하지 않다.
study <- read.csv('C:/k_digital/data/ANOVA 예제.csv', header = T)

# 정규성 확인
shapiro.test(subset(study, group == 'A')$time) # p-value = 0.4412
shapiro.test(study[study$group == 'B', 'time']) # p-value = 0.6307
shapiro.test(study[study$group == 'C', ]$time) # p-value = 0.2647
# 모든 그룹의 p값이 0.05보다 크므로 귀무가설 채택, 대립가설 기각

## 등분산성 확인
install.packages('lawstat')
library(lawstat)
levene.test(study$time, study$group, location = 'mean')
# p-value = 0.801 > 0.05 귀무가설 채택, 분산이 동일한다.

## ANOVA
result <- aov(time ~ group, data = study)
result
#                     group Residuals
# Sum of Squares  10091.975   224.397
# Deg. of Freedom         2        62
# 
# Residual standard error: 1.902447
# Estimated effects may be unbalanced
summary(result)
#                 Df Sum Sq Mean Sq F value Pr(>F)    
# group        2  10092    5046    1394 <2e-16 ***
# Residuals   62    224       4
### p 값이 0.05보다 작아 귀무가설 기각
### 세 고등학교 학생들의 평균 공부시간은 유의미한 차이가 있다
