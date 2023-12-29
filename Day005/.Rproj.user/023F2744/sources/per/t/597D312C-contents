# 필요한 패키지 로딩
library(readxl)
# 데이터셋 로딩
raw <- read_excel('C:/k_digital/r/source/Day005/Sample1.xlsx')
# 데이터 사본 생성
data <- raw
str(data)

## id만 추출
data$ID
select(data, ID)
## id, area, age 추출
data[, c('ID', 'AREA', 'AGE')]
select(data, ID, AREA, AGE)
## area를 제외하고 추출
data[, -1]
select(data, -ID)
## area가 서울인 자료만 추출
filter(data, AREA == '서울')
## area가 서울이면서 Y21_CNT 거래 건수가 10 이상인 자료만 추출
filter(data, AREA == '서울' & Y21_CNT >= 10)
## age를 기준으로 오름차순 정렬
arrange(data, AGE)
## Y21_AMT를 기준으로 내림차순 정렬
arrange(data, desc(Y21_AMT))
## age 오름차순, Y21_AMT는 내림차순 정렬
arrange(data, AGE, desc(Y21_AMT))
## 21년도 이용금액(Y21_AMT)의 합산 결과(tot_21) 추출
summarise(data, tot_21 = sum(Y21_AMT))
## 지역별 21년도 이용금액의 합계 추출
summarise(group_by(data, AREA), area_sum = sum(Y21_AMT))
