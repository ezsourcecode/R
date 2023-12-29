library(dplyr)
library(lubridate)

## 데이터 불러오기
train_df = read.csv('C:/k_digital/data/teamproject_01/train.csv')
building_info = read.csv('C:/k_digital/data/teamproject_01/building_info.csv')
test_df = read.csv('C:/k_digital/data/teamproject_01/test.csv')

## 데이터 구조 확인
str(train_df)
str(building_info)
str(test_df)

## head
head(train_df)
head(building_info)
head(test_df)

## 사본만들기
train <- train_df
build <- building_info
test <- test_df

## 컬럼확인
names(train_df)
names(test_df)
names(building_info)
### test에는 일조, 일사, 전력소비량이 없다

## 컬럼이름 영어로 바꾸기
train <- rename(train_df, 
                building_number = `건물번호`, 
                date_time = `일시`, 
                temperature = "기온.C.", 
                rainfall = "강수량.mm.", 
                windspeed = `풍속.m.s.`, 
                humidity = `습도...`, 
                sunshine = `일조.hr.`, 
                solar_radiation = `일사.MJ.m2.`, 
                power_consumption = `전력소비량.kWh.`)

test <- rename(test_df,
               building_number = `건물번호`, 
               date_time = `일시`, 
               temperature = "기온.C.", 
               rainfall = "강수량.mm.", 
               windspeed = `풍속.m.s.`, 
               humidity = `습도...`)

building <- rename(building_info,
                   building_number = '건물번호',
                   building_type = '건물유형',
                   total_area = '연면적.m2.',
                   cooling_area = '냉방면적.m2.',
                   solar_power_capacity = '태양광용량.kW.',
                   ess_capacity = 'ESS저장용량.kWh.',
                   pcs_capacity = 'PCS용량.kW.')

## 건물유형들 한글->영어
building$building_type <- ifelse(building[, 'building_type'] == '건물기타', 'Other Buildings',
                                 ifelse(building[, 'building_type'] == '공공', 'Public',
                                        ifelse(building[, 'building_type'] == '대학교', 'University',
                                               ifelse(building[, 'building_type'] == '데이터센터', 'Data Center',
                                                      ifelse(building[, 'building_type'] == '백화점및아울렛', 'Department Store and Outlet',
                                                             ifelse(building[, 'building_type'] == '병원', 'Hospital',
                                                                    ifelse(building[, 'building_type'] == '상용', 'Commercial',
                                                                           ifelse(building[, 'building_type'] == '아파트', 'Apartment',
                                                                                  ifelse(building[, 'building_type'] == '연구소', 'Research Institute',
                                                                                         ifelse(building[, 'building_type'] == '지식산업센터', 'Knowledge Industry Center',
                                                                                                ifelse(building[, 'building_type'] == '할인마트', 'Discount Mart',
                                                                                                       ifelse(building[, 'building_type'] == '호텔및리조트', 'Hotel and Resort',
                                                                                                building[, 'building_type']))))))))))))

## 날짜 데이터처리
train$date <- as.Date(train$date_time, '%Y%m%d')
train$month <- as.numeric(substr(as.character(train$date_time), 5, 6))
train$day <- as.numeric(substr(as.character(train$date_time), 7, 8))
train$hour <- as.numeric(substr(as.character(train$date_time), 10, 11))
train$weekday <- weekdays(train$date)
train <- train[,-1]

## 건물 결측치 변경
building$solar_power_capacity <- ifelse(building$solar_power_capacity=='-', 0, building$solar_power_capacity)
building$ess_capacity <- ifelse(building$ess_capacity=='-', 0, building$ess_capacity)
building$pcs_capacity <- ifelse(building$pcs_capacity=='-', 0, building$pcs_capacity)
building$solar <- ifelse(building$solar_power_capacity==0,0,1)
building$ess <- ifelse(building$ess_capacity==0,0,1)
building$pcs <- ifelse(building$pcs_capacity==0,0,1)

## NA 결측치 변경
train$sunshine <- ifelse(is.na(train$sunshine), 0, train$sunshine)
train$solar_radiation <- ifelse(is.na(train$solar_radiation), 0, train$solar_radiation)
train$rainfall <- ifelse(is.na(train$rainfall), 0, train$rainfall)

### windspeed와 humidity 결측치 변경
library(zoo)
train$windspeed <- na.approx(train$windspeed)
train$humidity <- na.approx(train$humidity)

## 건물 데이터 변환
train$building_number <- as.factor(train$building_number)
train$weekday <- as.factor(train$weekday)
building$building_number <- as.factor(building$building_number)
building$building_type <- as.factor(building$building_type)
building$solar_power_capacity <- as.numeric(building$solar_power_capacity)
building$ess_capacity <- as.numeric(building$ess_capacity)
building$pcs_capacity <- as.numeric(building$pcs_capacity)


## 건물별로 데이터 보기
total <- left_join(train, building, by = "building_number")
names(total)
str(total)
total$building_number <- as.numeric(total$building_number)
str(total)
total$holiday <- 1
total$holiday <- ifelse(total$weekday %in% c("토요일", "일요일"), 0, ifelse(total$date %in% c("2022-06-01", "2022-06-06", "2022-08-15"), 0, 1))

## total로 t1, t2 사본 생성
t1 <-total
t1 <- t1 %>% 
  select(!weekday&!date)
t2 <- t1 %>% 
  select(!building_type)
a <- cor(t2)
t2_cor <- as.data.frame(a)
t2_cor
## t2 상관분석 저장
write.csv(t2_cor, "C:/k_digital/data/t2_cor.csv", row.names = TRUE)

# 평일전력 - 주말전력
t1 <- t1 %>% 
  select(!ess_capacity&!ess)
# 연면적 제외
t1 <- t1 %>% 
  select(!total_area)

# 그래프 건물별 전력사용량 이미지 100개 생성
library(ggplot2)
for (i in 1:100){
  t1 %>%
    filter(building_number == i) %>%
    ggplot(aes(x=power_consumption)) +
    geom_density(fill="#69B3A2", color="#E9ECEF", alpha=0.8) +
    ggtitle(paste("건물별 에너지 소비량 분포", "건물번호", i))
  ggsave(paste0("건물별 전력사용량_", i, ".jpg"))
}


# 건물별 전력사용량 시계열 그래프 생성 및 저장2
for (i in 1:100){
  t1 %>%
    filter(building_number == i) %>%
    ggplot(aes(x=power_consumption)) +
    geom_density(fill="#69B3A2", color="#E9ECEF", alpha=0.8) +
    ggtitle(paste("건물별 에너지사용량 시계열", "건물번호", i))
  ggsave(paste0("건물별 전력사용량 시계열(시 단위)_", i, ".jpg"))
}


## 상관성이 높은 변수들 골라내기
total <- total %>%
  select(!ess_capacity&!ess&!cooling_area&!sunshine)
## 건물번호 별로 리스트 만들기
total_list <- split(total, total$building_number)
as.data.frame(total_list)
for(i in 1:100) {
  assign(paste0("b", i), total_list[[as.character(i)]])
}
#  각 건물의 시간대별 평균 (연면적 대비 전력) 소비량 계산하기
avg_power_list <- lapply(total_list, function(bldg) {
  bldg$power_per_area <- bldg$power_consumption / bldg$total_area
  avg_power <- aggregate(power_per_area ~ hour, data = bldg, mean)
})
# 각 건물의 시간대별 평균 (연면적 대비)전력 소비량을 하나의 데이터 프레임으로 합칩니다.
avg_power_df <- do.call(rbind, avg_power_list)
as.data.frame(avg_power_df)
# 클러스터 결과를 데이터 프레임에 추가합니다.
set.seed(123)  # 재현성을 위한 seed 설정
clusters <- kmeans(avg_power_df, centers = 7)
avg_power_df$cluster <- as.factor(clusters$cluster)
######## avg_power_df의 열은 3개뿐이라 원래있던 데이터에 병합을 해야합니다.
######## b1~b100에 병합기준 공통열 'no'을 만듭니다. (나중에 봤더니 avg_power_df에서 공통 열로 할 수 있는 열의 이름은 'hour'라서 이후에 고칩니다.)
for(j in 1:100) {
  # 문자열을 사용하여 동적 변수 이름 생성
  data_name <- paste0("b", j)
  # 해당 데이터 프레임 가져오기
  df <- get(data_name)
  # hour 값을 no 열에 할당
  for(i in 0:24) {
    df$no[df$hour == i] <- i
  }
  # 변경된 데이터 프레임 할당
  assign(data_name, df)
}
##### avg_power_df를 건물별로 0~24시로 나눠 b1~b100에 할당할 수 있게 만듭니다.
# 데이터프레임 리스트 초기화
df_list <- list()
# 데이터프레임 분할
num_chunks <- nrow(avg_power_df) / 24
for(i in 1:num_chunks) {
  df_list[[i]] <- avg_power_df[((i-1)*24 + 1):(i*24), ]
}
# df_list에는 각 24행씩 분할된 데이터프레임들이 저장되어 있습니다.
##### b1~b100에 원래 있던 hour을 삭제하고 아까 만든 no를 hour로 바꿔줍니다.
df_list[[1]]
for (i in 1:100) {
  df_name <- paste0("b", i)
  # hour 열 삭제
  assign(df_name, subset(get(df_name), select = -hour))
  # no 열 이름을 hour로 변경
  assign(df_name, rename(get(df_name), hour = no))
}
####### 공통 열 hour를 통해 조인을 b1~b100까지 반복합니다.
merged_dfs <- list()
for (i in 1:100) {
  b_df <- get(paste0("b", i))  # b1부터 b100까지 데이터프레임 가져오기
  merged_df <- inner_join(b_df, df_list[[i]], by = "hour")  # hour를 기준으로 합치기
  merged_dfs[[i]] <- merged_df  # 결과를 리스트에 저장
}
####### 최종 b1~ b100을 하나의 데이터프레임으로 합칩니다.
final_merged_df <- bind_rows(merged_dfs)
####### 건물 번호, pcs 유무, holiday, solar장치 유무는 1과 0이기에 factor로 바꿉니다.
final_merged_df$building_number <- as.factor(final_merged_df$building_number)
final_merged_df$pcs <- as.factor(final_merged_df$pcs)
final_merged_df$holiday <- as.factor(final_merged_df$holiday)
final_merged_df$solar <- as.factor(final_merged_df$solar)
####### 이후 cluster 그룹번호로 데이터를 분할합니다.
split_df_list <- split(final_merged_df, final_merged_df$cluster)
####### 데이터 분할한 것을 a1~a7까지로 지정합니다.
for (i in 1:7) {
  assign(paste0("a", i), split_df_list[[as.character(i)]])
}
for (i in 1:7) {
  as.data.frame(paste0("a", i))
} 



# 기본 회귀분석부터 해보기
# 변수
# 에너지 사용량(power_consumptino), 워킹데이(w_day), 기온(평균), 강수(합계), 습도(평균)
# 데이터
# b5_test(테스트용)
################################################################################
## 데이터셋 생성(1시간대) b5_test2
b5_test2 <- b5 %>%
  group_by(hour) %>%
  summarise(
    pc=mean(power_consumption),
    working = mean(holiday == 1),
    temp=mean(temperature),
    rain=sum(rainfall),
    humi=mean(humidity)
  )
b5_test2$holiday <- ifelse(b5_test2$hour >= 6 & b5_test2$hour < 20, 1, 0)
b5_test2
cor(b5_test2$pc, b5_test2$holiday) # => 0.7911621
cor(b5_test2$pc, b5_test2$temp) # => 0.8399843
cor(b5_test2$pc, b5_test2$rain) # => 0.1608836
cor(b5_test2$pc, b5_test2$humi) # => -0.8321016
b5_glm2 <- lm(pc~., data=b5_test2)
summary(b5_glm2)
step(b5_glm2, direction='both')
b5_glm2 <- lm(pc~hour + temp + rain + hoilday, data=b5_test2)
summary(b5_glm2)
################################################################################
## 데이터셋 생성(일별) : b5_test1
library(dplyr)
b5_test1 <- b5 %>%
  group_by(date) %>%
  summarise(
    pc=mean(power_consumption),
    working = mean(holiday == 1),
    temp=mean(temperature),
    rain=sum(rainfall),
    humi=mean(humidity)
  )
# 상관분석
cor(b5_test1$pc, b5_test1$holiday) # => 0.2285323
cor(b5_test1$pc, b5_test1$temp) #=> 0.3492352
cor(b5_test1$pc, b5_test1$rain) # => -0.09229047
cor(b5_test1$pc, b5_test1$humi) # => 0.1588382
b5_glm <- lm(pc~., data=b5_test)
summary(b5_glm)
step(b5_glm, direction='both')













#내 사본 만들기#
ej <- t1
# 시계열로 쓸 PSTIXct 타입 추가
ej$date_time <- format(as.POSIXct(train$date_time, format = "%Y%m%d %H"), "%Y%m%d%H")
ej$date_time <- as.POSIXct(train$date_time, format = "%Y%m%d%H")

for (i in 1:100){
  ej %>%
    filter(building_number == i) %>%
    ggplot(aes(x=date_time, y=power_consumption)) +
    geom_line(color="#69B3A2") +
    ggtitle(paste("건물별 에너지사용량 시계열", "건물번호", i))
  ggsave(paste0("건물별 전력사용량 시계열(시 단위)_", i, ".jpg"))
}



ej %>%
  filter(building_number == 68) %>%
  ggplot(aes(x=date_time, y=power_consumption)) +
  geom_line(color="#69B3A2")


ggplot(data = ej, aes(x=date_time, y= temperature)) +
  geom_bar(color="#69B3A2")

ej2 <- ej
ej2_list <- split(ej2, ej2$building_number)
ej2_list$'1'
as.data.frame(ej2_list)
summary(ej2_list$'1')

# DI지수
ej2$DI <- 0.81 * ej2$temperature + 0.01 * ej2$humidity * (0.99 * ej2$temperature - 14.3) + 46.3
corrplot(cor(ej3), method = 'number')
ej3$building_type <- as.numeric(ej3$building_type)

c_a1 <- a1[, -c(1,8,11,12,21)]
c_a1$DI <- 0.81 * c_a1$temperature + 0.01 * c_a1$humidity * (0.99 * c_a1$temperature - 14.3) + 46.3
corrplot(cor(c_a1), method = 'number')
c_a2 <- a2[, -c(1,9,12,13,25)]
c_a2$DI <- 0.81 * c_a2$temperature + 0.01 * c_a2$humidity * (0.99 * c_a2$temperature - 14.3) + 46.3
corrplot(cor(c_a2), method = 'number')
c_a3 <- a3[, -c(1,9,12,13,25)]
c_a3$DI <- 0.81 * c_a3$temperature + 0.01 * c_a3$humidity * (0.99 * c_a3$temperature - 14.3) + 46.3
corrplot(cor(c_a3), method = 'number')
c_a4 <- a4[, -c(1,9,12,13,25)]
c_a4$DI <- 0.81 * c_a4$temperature + 0.01 * c_a4$humidity * (0.99 * c_a4$temperature - 14.3) + 46.3
corrplot(cor(c_a4), method = 'number')
c_a5 <- a5[, -c(1,9,12,13,25)]
c_a5$DI <- 0.81 * c_a5$temperature + 0.01 * c_a5$humidity * (0.99 * c_a5$temperature - 14.3) + 46.3
corrplot(cor(c_a5), method = 'number')
c_a6 <- a6[, -c(1,9,12,13,25)]
c_a6$DI <- 0.81 * c_a6$temperature + 0.01 * c_a6$humidity * (0.99 * c_a6$temperature - 14.3) + 46.3
corrplot(cor(c_a6), method = 'number')
c_a7 <- a7[, -c(1,9,12,13,25)]
c_a7$DI <- 0.81 * c_a7$temperature + 0.01 * c_a7$humidity * (0.99 * c_a7$temperature - 14.3) + 46.3
corrplot(cor(c_a7), method = 'number')

library(caret)
#####################################





# 인터랙티브 그래프 예시
# install.packages('dygraphs')
library(dygraphs) # 인터랙티브 그래프
library(xts) # 그래프에 맞는 자료형 변환
# 그래프 표시 변수들
ej_power <- xts(ej$power_consumption, order.by = ej$date_time)
ej_temp <- xts(ej$temperature, order.by = ej$date_time)
ej_rain <- xts(ej$rainfall, order.by = ej$date_time)
ej_humi <- xts(ej$humidity, order.by = ej$date_time)
ejdygraphs <- cbind(ej_temp, ej_rain, ej_humi)
head(ejdygraphs)
dygraph(ejdygraphs) %>% dyRangeSelector() # 아래 섹터 생성

# 특정 번호만 보기
ej_b68 <- ej %>% subset(building_number == 68)
ej_b68 <- xts(ej_b68$power_consumption, order.by = ej_b68$date_time)
head(ej_b68)
dygraph(ej_b68) %>% dyRangeSelector() # 아래 섹터 생성


# 상관관계 히트맵
library(corrplot)
corrplot(cor(t2), method = 'number')

boxplot(mean(train$power_consumption), building_list)

## 건물별로 그룹데이터
as.factor(building$building_number)
building_list <- split(train, train$building_number)

## train, building total로 병합하기
#total <-merge(train, building)#


summary(a1$building_number)



C_b1 %>% group_by(b1.hour) %>% summarise(mean_hour=mean(power_consumption))


# 건물별 온도 평균기온 빌딩넘버
building_tmp_mean <- aggregate(train$temperature, by = list(train$building_number), mean)
boxplot(power_consumption ~ building_number, data = train)

# 건물별 온도 평균 기온 빌딩타입
buildingtype_tmp_mean <- aggregate(total$temperature, by = list(total$building_type), mean)
boxplot(temperature ~ building_type, data = total)

month.avg <- aggregate(ds$avg_temp, # 평균기온 입력                       
                       by=list(ds$month),median)[2] # 월별로 묶어서
# 평균기온 순위 계산 (내림차순) 
odr <- rank(-month.avg) # rank함수를 활용

# 월별 기온분포 
boxplot(avg_temp~month, data=ds, # 기온과 월별로 입력        
        col=heat.colors(12)[odr], # 상자의 색을 지정         
        ylim=c(-20,40), # 기본 범위 지정        
        ylab="기온", # 축 제목 설정        
        xlab="월",   # 축 제목 설정      
        main="서울 월별기온분포 (2017)") # 메인 제목 설정

cor(total_list[[2]]$'power_consumption', total_list[[2]]$'total_area')

cor(t1$power_consumption, as.numeric(t1$building_type))



#########################################################
# 사본 cca1 lightGBM 분석 테스트
cca1 <- a1
y<-as.numeric(cca1$power_consumption)

# LightGBM 패키지 로드
library(lightgbm)
# MLmetrics 패키지 로드
library(MLmetrics)
head(cca1)
dim(cca1)
25500
# test data set sampling index 정의
cca1_train_index <- sample(1:dim(cca1)[1], nrow(cca1) * 0.7)

# train 및 test data 생성
cca1_train_lgbm <- cca1[-cca1_train_index,]
cca1_test_lgbm <- cca1[cca1_train_index,]
dim(cca1_train_lgbm)

head(cca1_y_train)
# train data 숫자형 변환
cca1_x_train <- as.matrix(cca1_train_lgbm[,-7])

# train data target 세팅
cca1_y_train <- y[-cca1_train_index]

# test data 숫자형 변환
cca1_x_test <- as.matrix(cca1_test_lgbm[,-7])

# test data target 세팅
cca1_y_test <- y[cca1_train_index]


# LightGBM 적용
# -----------------------------------------------------------
cca1_dtrain <- lgb.Dataset(cca1_x_train, label = cca1_y_train)
cca1_dtest <- lgb.Dataset.create.valid(cca1_dtrain, cca1_x_test, label = cca1_y_test)

cca1_params <- list(
  objective = "multiclass"
  , metric = "multi_logloss"
  , min_data = 50
  , learning_rate = 0.3
)
valids <- list(test = cca1_dtest)

fcca1_model <- lgb.train(
  params = cca1_params
  , data = cca1_dtrain
  , nrounds = 10
  , valids = valids
  , early_stopping_rounds = 1
)


