
for (i in 1:100) {

  # 훈련세트 : train_LR
train_LR <-train %>% 
  filter(BID==i)

# 테스트 세트 : test_LR
test_LR <- test %>% 
  filter(BID==i)

# 모델 생성  
model_LR <- lm(PC~Temp+Rain+WS+HM+WorkD+WC+DI, data=train_LR)

# 스텝와이즈로 최적의 모델 생성(최종 모델)
model_LR <- step(model_LR, direction="both")

# 모델을 저장 : model_LR_i
saveRDS(model_LR, file=paste0("model_LR_", i))

# 실제값 저장 : actual
actual <- test_LR$PC

# 예측값 생성
forecast <- predict(model_LR, test_LR)

#############################################################
## 스코어s ##

score_LR[i,]<-calculate_errors(actual, forecast)

} # for문 끝

