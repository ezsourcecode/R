
for (i in 1:100) {

train_SVM <-train %>% 
  filter(BID==i) %>% 
  select(PC, Temp, Rain, WS, HM, Time, WorkD)
test_SVM <- test %>% 
  filter(BID==i) %>% 
  select(PC, Temp, Rain, WS, HM, Time, WorkD)

# 모델 생성  
model_SVM <- svm(PC~., data=train_SVM, type = "eps-regression", kernel = "linear")

# 모델을 저장 : model_SVM_i
saveRDS(model_SVM, file=paste0("model_SVM_", i))

# 실제값 저장 : actual
actual <- test_SVM$PC


# 예측값 생성
forecast <- predict(model_SVM, test_SVM)


#############################################################
## 스코어s ##

score_SVM[i,]<-calculate_errors(actual, forecast)

} # for문 끝
