# 필요 라이브러리 로딩
library(readxl)
library(dplyr)
library(ggplot2)

# 데이터셋 로딩
raw <- read_excel('C:/k_digital/data/Cafe_Sales.xlsx',col_names = T)

# 데이터 프레임으로 변형
cafe <- as.data.frame(raw)

str(cafe)
head(cafe)

## Date: 날짜를 나타내는 자료형. 1970년 1월 1일 이후 경과된 일 수를 저장한다.
## POSIXct: 날짜와 시간을 나타내는 자료형. 1970년 1월 1일 이후 경과한 초 수와 타임존을 저장한다.
## POSIXlt: 날짜와 시간을 나타내는 자료형. 1970년 1월 1일 이후 경과된 년수, 월, 일, 시간, 분, 초, 타임존 등을 리스트 형태로 저장한다.

class(cafe$order_date)
# 시간
x <- Sys.time()
format(x, '%Y-%m-%d %H:%M:%S') # [1] "2023-08-04 09:08:49"
format(x, '%Y-%j %H:%M:%s') # [1] "2023-216 09:08:1691107729" # j는 365에서 뺀 값
format(x, '%G-%V-%u %H:%M:%S') # [1] "2023-31-5 09:08:49" # u는 요일(1-7 1-월) 5: 금

# 결측치와 이상치 분석
table(is.na(cafe$order_id))
table(is.na(cafe$order_date)) # 이 열만 결측치가 있음
# FALSE  TRUE 
# 62410   171 
table(is.na(cafe$category))
table(is.na(cafe$item))
table(is.na(cafe$price))

## 전체 데이터수에 비해 결측치가 적으면 대체보다는 제거
cafe <- na.omit(cafe) # 결측 행 전체 제거
nrow(cafe) # [1] 62410

# 주문 건수
length(unique(cafe$order_id)) # [1] 34875

# 카페에서 가장 많이 판매된 메뉴
## 내림차순 정렬
sort(table(cafe$item), decreasing = T)

cafe_item <- data.frame(table(cafe$item))
head(cafe_item)

sales_item <- subset.data.frame(cafe, select = c('item', 'price'))
head(sales_item)
sales_item <-unique(sales_item)
sales_item

# 요일별 판매한 메뉴는 무엇인가
## 요일을 담는 파생변수 생성
cafe$weekday <- weekdays(cafe$order_date)
head(cafe)

table(cafe$weekday)
date_info <- data.frame(weekday = c('월요일', '화요일', '수요일', '목요일', '금요일', '토요일', '일요일'), day = c('평일', '평일', '평일', '평일', '평일', '주말', '주말'))

## 두 개의 데이터 프레임 병합
cafe <- merge(cafe, date_info) # 동명의 컬럼이 있으므로 조건 생략
table(cafe$day)

# 계절별로 판매되는 메뉴는 무엇인가
cafe$month <- months(cafe$order_date)
head(cafe)

## 봄(3 ~ 5), 여름(6 ~ 8), 가을(9 ~ 11), 겨울(12 ~ 2)
## 파생변수 season
seasons <- data.frame(month = c('3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월', '1월', '2월'), seoson = c('봄', '봄', '봄', '여름', '여름', '여름', '가을', '가을', '가을', '겨울', '겨울', '겨울'))

cafe <- merge(cafe, seasons)
head(cafe)
table(cafe$seoson, cafe$item)

# 매출현황 시각화
## 카테고리별 판매 건수 시각화
cafe %>% 
  group_by(category) %>% 
  summarise(count = n())
ggplot(cafe, aes(x = category)) +geom_bar(aes(fill = as.factor(item)), position = 'dodge')

## 월별 판매 건수 시각화
cafe %>% 
  group_by(month) %>% 
  summarise(count = n())
ggplot(cafe, aes(x = seoson)) + geom_bar(aes(fill = as.factor(month)), position = 'dodge') +
  scale_x_discrete(limits = c('봄', '여름', '가을', '겨울'))

## 요일별 판매 건수 시각화
cafe %>% 
  group_by(weekday) %>% 
  summarise(count = n())
ggplot(cafe, aes(x = day)) + geom_bar(aes(fill = as.factor(weekday)), position = 'dodge') + geom_text(stat = 'count',  aes(label=..count..), position = position_dodge(width=1.8), vjust= -0.5)
# geom_bar()에는 width=1.8이라고 기재하나 안하나 같은 그래프가 생성되지만, geom_text() 안에서는 반드시 width를 설정해줘야 label이 제대로 표시됨에 유의

# 이 방법보다는 파생변수 생성하는게 더 낫다
cafe %>% 
  filter(as.Date(format(order_date, '%Y-%m-%d')) < '2018-01-01' & item == '아메리카노') %>% 
  summarise(count = n())
