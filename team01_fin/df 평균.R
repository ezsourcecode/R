df <- data.frame(mean(score_LR$SMAPE), mean(score_SVM$SMAPE), mean(score_gbm$SMAPE), mean(score_kNN$SMAPE))
df <- unlist(df)

library(ggplot2)

barplot(df,names=c("LR","SVM","GBM", "KNN"), col= "purple")
str(df)
df
