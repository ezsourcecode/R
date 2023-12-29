for (i in 1:100) {
## 데이터셋 생성

train_NN <-train %>% 
  filter(BID==i) %>% 
  select(PC, Temp, Rain, WS, HM, Time, WorkD)

test_NN <- train %>% 
  filter(BID==i) %>% 
  select(PC, Temp, Rain, WS, HM, Time, WorkD)


# 모델 생성
model_NN <- neuralnet(PC~., data=train_NN, hidden=20, linear.output=TRUE) # 은닉층에 10개 뉴런

# 모델을 저장 : model_NN_i
saveRDS(model_NN, file=paste0("model_NN_", i))

# model_NN 요약본
summary(model_NN)

# 실제값 저장 : actual
actual <- test_NN$PC

# 예측값 생성
forecast <- predict(model_NN, test_NN)

#############################################################
## 스코어s ##
score_NN[i,]<-calculate_errors(actual, forecast)

}
