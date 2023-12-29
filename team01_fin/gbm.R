


 for ( i in 1:100 ){
  
  train_gbm <-train %>% 
    filter(BID==i)
  
  test_gbm <- test %>% 
    filter(BID==i)
  
  train_gbm$BID <- NULL
  train_gbm$DateTime <- NULL
  train_gbm$WeekD <- NULL
  train_gbm$DILv <- NULL
  test_gbm$BID <- NULL
  test_gbm$DateTime <- NULL
  test_gbm$WeekD <- NULL
  test_gbm$DILv <- NULL
  
  # 모델 생성
  model_gbm <- gbm(PC ~ ., data=train_gbm, distribution="gaussian", n.trees = 100, interaction.depth = 5,
                   shrinkage = 0.05, n.minobsinnode=23)
  
  # 모델을 저장 : model_kNN_i
  saveRDS(model_gbm, file=paste0("model_gbm_", i))
  
  # 실제값 저장 : actual
  actual <- test_gbm$PC
  
  # 예측값 생성 : forecast
  forecast <- predict(model_gbm, test_gbm)
  
  #############################################################
  ## 스코어s ##
  
  score_gbm[i,]<-calculate_errors(actual, forecast)
  
} # for문 끝
