# 패키지 및 라이브러리
install.packages('lubridate')
library(lubridate)
library(readxl)
library(dplyr)

# 매출 올릴 수 있는 방법
raw <- read_excel('C:/R/data/Cafe_Sales.xlsx',col_names = T)
cafe <- raw
cafe$category <- as.factor(cafe$category)
cafe$item <- as.factor(cafe$item)
cafe2 <- cafe
cafe3 <- cafe2
na.omit(cafe3)
cafe3$strptime <- strptime(cafe$order_date, '%Y-%m-%d %H:%M:%S')
cafe3$date  = as.Date(format(cafe$order_date, '%Y-%m-%d'))
cafe3$time  = format(cafe$order_date, '%H:%M')
cafe2$year <- as.numeric(substr(as.character(cafe$order_date), 1, 4))
cafe2$month <- as.numeric(substr(as.character(cafe$order_date), 6, 7))
cafe2$day <- as.numeric(substr(as.character(cafe$order_date), 9, 10))
cafe2$hour <- as.numeric(substr(as.character(cafe$order_date), 12, 13))
cafe3$mm <- cafe3 %>% ifelse(is.na(month), 0, ifelse(month < 4, 'spring', ifelse(month < 7, 'summer', ifelse(month < 10, 'fall', 'winter'))))
cafe2$hh <- ifelse(cafe3$hour < 12, 'am', 'pm')
table(cafe3$hh)

unique(cafe3$hh)

str(cafe)
summary(cafe)
# order_id           order_date                              category                 item      
# Length:62581       Min.   :2017-09-13 10:05:00.0   Ade/Shake     : 8280   카푸치노      : 4650  
# Class :character   1st Qu.:2018-06-03 15:46:15.0   Bakery        : 2693   비엔나커피    : 4641  
# Mode  :character   Median :2018-11-18 13:10:00.0   coffee        :36144   카페라떼      : 4600  
#                    Mean   :2019-01-07 11:03:39.9   Latte         : 3366   아메리카노    : 4549  
#                    3rd Qu.:2019-09-22 11:35:00.0   Smoothie/Juice: 5629   바니라라떼    : 4533  
#                    Max.   :2020-12-25 23:55:00.0   Tea           : 6469   카라멜마끼아또: 4463  
#                    NA's   :171                                            (Other)       :35145  
#      price      
#  Min.   : 3000  
#  1st Qu.: 4500  
#  Median : 5000  
#  Mean   : 4791  
#  3rd Qu.: 5000  
#  Max.   :11000 

table(cafe$order_id)
table(cafe$order_date)
table(cafe$category)
table(cafe$item)
table(cafe$price)
table(cafe2$year)

# 2017-09-13 10:05:00.00
# 2020-12-25 23:55:00.00
class(cafe$order_date)

# 연도별 매출
y_tot <- cafe2 %>% 
  filter(!is.na(year)) %>% 
  group_by(year) %>% 
  summarise(tot = sum(price))
# year       tot
# <dbl>     <dbl>
# 1  2017  36367000
# 2  2018 132622500
# 3  2019  94399500
# 4  2020  35586500
y_tot <- cafe3 %>% 
  filter(!is.na(strptime$year)) %>% 
  group_by(strptime$year) %>% 
  summarise(tot = sum(price))
head(cafe3$strptime$mon)
head(cafe3$strptime$mday)
head(cafe3$strptime$day)
# 월별 매출
y_tot <- cafe2 %>% 
  filter(!is.na(year)) %>% 
  group_by(year) %>% 
  summarise(tot = sum(price))
m_tot <- cafe3 %>% 
  filter(!is.na(strptime$mon) & !is.na(month)) %>% 
  group_by(month) %>% 
  summarise(tot = sum(price))
m_tot
# month      tot
# <dbl>    <dbl>
# 1     1 22638000
# 2     2 13437500
# 3     3 17423500
# 4     4 14893500
# 5     5 17743000
# 6     6 19701000
# 7     7 19503000
# 8     8 26226500
# 9     9 34396500
# 10    10 45035000
# 11    11 36798500
# 12    12 31179500

# 계절, 시간별 잘 팔리는 메뉴, 안 팔리는 메뉴
s_tot <- cafe2 %>% 
  filter(!is.na(month) < 4) %>% 
  group_by()
# 계절, 시간별 잘 팔리는 메뉴, 안 팔리는 메뉴
# 전체 기간 카테고리별 분석
## 건수로 보는 카테고리 인기 순위
summary(cafe$category)
# Ade/Shake     Bakery         coffee          Latte    Smoothie/Juice        Tea 
# 8280           2693          36144           3366           5629           6469
sort(rank(-summary(cafe$category)))
# coffee      Ade/Shake       Tea   Smoothie/Juice          Latte         Bakery 
# 1              2              3              4              5              6 

# 전체 기간 카테고리별 매출액
a_cate_p <- cafe %>% 
  group_by(category) %>% 
  summarise(totP = sum(price)) %>% 
  arrange(-totP)
a_cate_p
#   <fct>              <dbl>
# 1 coffee         166921000
# 2 Ade/Shake       42345500
# 3 Smoothie/Juice  29537000
# 4 Tea             29110500
# 5 Bakery          16737500
# 6 Latte           15147000

# 카테고리별 제품 종수
a_cate_c <- cafe %>% 
  group_by(category) %>% 
  summarise(toti = n_distinct(item)) %>% 
  arrange(-toti)
a_cate_c
# category        toti
# <fct>          <int>
# 1 Ade/Shake          9
# 2 coffee             8
# 3 Tea                7
# 4 Bakery             6
# 5 Smoothie/Juice     4
# 6 Latte              3

# 전체 기간 제품별 분석
## 건수로 보는 제품 인기 순위
summary(cafe$item)
# 깔라만시      딸기스무디          매실차   믹스베리 와플        민트초코      바니라라떼 
# 824            1450             922             500             967            4533 
# 베이글    복숭아스무디  복숭아아이스티  블루레몬에이드      비엔나커피      생과일주스 
# 401            1380             921             879            4641            1392 
# 아메리카노 아이스크림 와플        아포가또        얼그레이          오레오          요거트 
# 4549             405             912             928             961             893 
# 유자스무디          유자차      자몽에이드          자몽차          자바칩        초코라떼 
# 1407             925             922             972             880            1165 
# 카라멜마끼아또        카페라떼        카페모카        카푸치노        캐모마일        커피콩빵 
# 4463            4600            4436            4650             952             481 
# 크린티라떼        페퍼민트     플레인 와플      허니브레드    헤이즐넛라떼        홍차라떼 
# 1079             946             462             444            4272            1122 
# 히비아이스트 
# 945
sort(rank(-summary(cafe$item)))
# 카푸치노      비엔나커피        카페라떼      아메리카노      바니라라떼  카라멜마끼아또 
# 1.0             2.0             3.0             4.0             5.0             6.0 
# 카페모카    헤이즐넛라떼      딸기스무디      유자스무디      생과일주스    복숭아스무디 
# 7.0             8.0             9.0            10.0            11.0            12.0 
# 초코라떼        홍차라떼      크린티라떼          자몽차        민트초코          오레오 
# 13.0            14.0            15.0            16.0            17.0            18.0 
# 캐모마일        페퍼민트    히비아이스트        얼그레이          유자차          매실차 
# 19.0            20.0            21.0            22.0            23.0            24.5 
# 자몽에이드  복숭아아이스티        아포가또          요거트          자바칩  블루레몬에이드 
# 24.5            26.0            27.0            28.0            29.0            30.0 
# 깔라만시   믹스베리 와플        커피콩빵     플레인 와플      허니브레드 아이스크림 와플 
# 31.0            32.0            33.0            34.0            35.0            36.0 
# 베이글 
# 37.0 

# 가장 매출이 높/낮은 날

# 요일별 매출 인기 상품
# 바니라라떼 오타 보정까지

# order_id 한 번에 얼마나 많이 주문했는지 찾기 가능할듯
