


for(i in 1:100) {

train_kNN <-train %>% 
  filter(BID==i) %>% 
  select(PC, Temp, Rain, WS, HM, Time, WorkD, WC, DI)

test_kNN <- test %>% 
  filter(BID==i) %>% 
  select(PC, Temp, Rain, WS, HM, Time, WorkD, WC, DI)

# 모델 생성
model_kNN <- train.kknn(PC ~ ., train_kNN, kmax = 2, kernel = "optimal")

# 모델을 저장 : model_kNN_i
saveRDS(model_kNN, file=paste0("model_kNN_", i))

# 실제값 저장 : actual
actual <- test_kNN$PC

# 예측값 생성 : forecast
forecast <- predict(model_kNN, test_kNN)

#############################################################
## 스코어s ##

score_kNN[i,]<-calculate_errors(actual, forecast)

} # for문 끝
