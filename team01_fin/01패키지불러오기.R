
# 프로젝트 라이브러리 관리
dir.create("C:/k_digital/r/source/team01_fin")
.libPaths("C:/k_digital/r/source/team01_fin")

## install
install.packages("dplyr")
install.packages("kknn")
install.packages("neuralnet")
install.packages("Metrics") # 평가 지표 계산 calculate_errors(actual, forecast) 함수
install.packages("e1071")
install.packages("gbm")


## library
library(dplyr)
library(kknn)
library(e1071)
library(neuralnet)
library(Metrics)
library(gbm)

