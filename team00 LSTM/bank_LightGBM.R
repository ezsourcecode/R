# 사용 예시
# LightGBM 패키지 로드
library(lightgbm)
# MLmetrics 패키지 로드
library(MLmetrics)

# LightGBM 패키지에 있는 bank 데이터 가져오기 
data(bank, package = "lightgbm")

# 데이터 전처리 
data_lightgbm <- bank
data_lightgbm$job <- as.factor(data_lightgbm$job)
data_lightgbm$marital <- as.factor(data_lightgbm$marital)
data_lightgbm$education <- as.factor(data_lightgbm$education)
data_lightgbm$default <- as.factor(data_lightgbm$default)
data_lightgbm$housing <- as.factor(data_lightgbm$housing)
data_lightgbm$loan <- as.factor(data_lightgbm$loan)
data_lightgbm$contact <- as.factor(data_lightgbm$contact)
data_lightgbm$month <- as.factor(data_lightgbm$month)
data_lightgbm$poutcome <- as.factor(data_lightgbm$poutcome)
data_lightgbm$y <- as.factor(data_lightgbm$y)
y <- as.numeric(data_lightgbm$y == "yes")

data_lightgbm_final <- lgb.convert_with_rules(data_lightgbm)

# test data set sampling index 정의
train_index <- sample(1:dim(data_lightgbm_final$data)[1], 2000)

# train 및 test data 생성 
train_lgbm <- data_lightgbm_final$data[-train_index,]
test_lgbm <- data_lightgbm_final$data[train_index,]

# train data 숫자형 변환
x_train <- as.matrix(train_lgbm[,-"y"])
# > str(x_train)
# int [1:2521, 1:16] 30 35 30 59 35 36 39 39 43 31 ...
# - attr(*, "dimnames")=List of 2
# ..$ : NULL
# ..$ : chr [1:16] "age" "job" "marital" "education" ...
# > head(x_train)
#       age job marital education default balance housing loan contact day month duration campaign
# [1,]  30  11       2         1       1    1787       1    1       1  19    11       79        1
# [2,]  35   5       3         3       1    1350       2    1       1  16     1      185        1
# [3,]  30   5       2         3       1    1476       2    2       3   3     7      199        4
# [4,]  59   2       2         2       1       0       2    1       3   5     9      226        1
# [5,]  35   5       3         3       1     747       1    1       1  23     4      141        2
# [6,]  36   7       2         3       1     307       2    1       1  14     9      341        1
#        pdays previous poutcome
# [1,]    -1        0        4
# [2,]   330        1        1
# [3,]    -1        0        4
# [4,]    -1        0        4
# [5,]   176        3        1
# [6,]   330        2        2

# train data target 세팅
y_train <- y[-train_index]
# > head(y_train)
# [1] 0 0 0 0 0 0
# > str(y_train)
# num [1:2521] 0 0 0 0 0 0 0 0 0 0 ...

# test data 숫자형 변환
x_test <- as.matrix(test_lgbm[,-"y"])
# > str(x_test)
# int [1:2000, 1:16] 35 33 55 34 37 49 27 36 49 44 ...
# - attr(*, "dimnames")=List of 2
# ..$ : NULL
# ..$ : chr [1:16] "age" "job" "marital" "education" ...
# > str(x_test)
# int [1:2000, 1:16] 35 33 55 34 37 49 27 36 49 44 ...
# - attr(*, "dimnames")=List of 2
# ..$ : NULL
# ..$ : chr [1:16] "age" "job" "marital" "education" ...
# > head(x_test)
# age job marital education default balance housing loan contact day month duration campaign
# [1,]  35  10       2         2       1       0       1    1       1  27     2      106        4
# [2,]  33   5       2         4       1   18347       2    1       3  23     9      415        1
# [3,]  55   8       1         2       1     218       2    1       3  29     9      200        2
# [4,]  34   5       2         3       1     -73       2    1       1  11     6       90        1
# [5,]  37   1       3         2       1       0       2    1       1  16     1      640        2
# [6,]  49   5       2         2       1     321       1    1       3   9     7      135        3
# pdays previous poutcome
# [1,]    -1        0        4
# [2,]    -1        0        4
# [3,]    -1        0        4
# [4,]    -1        0        4
# [5,]    -1        0        4
# [6,]    -1        0        4

# test data target 세팅
y_test <- y[train_index]
# > str(y_test)
# num [1:2000] 0 0 0 0 0 0 0 0 0 0 ...
# > head(y_test)
# [1] 0 0 0 0 0 0


# LightGBM 적용
# -----------------------------------------------------------
dtrain <- lgb.Dataset(x_train, label = y_train)
dtest <- lgb.Dataset.create.valid(dtrain, x_test, label = y_test)

bank_params <- list(
  objective = "binary"
  , metric = "auc"
  , min_data = 50
  , learning_rate = 0.3
)
valids <- list(test = dtest)
bank_model <- lgb.train(
  params = bank_params
  , data = dtrain
  , nrounds = 10
  , valids = valids
  , early_stopping_rounds = 1
)

# [LightGBM] [Info] Number of positive: 313, number of negative: 2208
# [LightGBM] [Warning] Auto-choosing row-wise multi-threading, the overhead of testing was 0.001387 seconds.
# You can set `force_row_wise=true` to remove the overhead.
# And if memory is not enough, you can set `force_col_wise=true`.
# [LightGBM] [Info] Total Bins 809
# [LightGBM] [Info] Number of data points in the train set: 2521, number of used features: 15
# [LightGBM] [Info] [binary:BoostFromScore]: pavg=0.124157 -> initscore=-1.953639
# [LightGBM] [Info] Start training from score -1.953639
# [1] "[1]:  test's auc:0.827846"
# [1] "[2]:  test's auc:0.834575"
# [1] "[3]:  test's auc:0.83488"
# [1] "[4]:  test's auc:0.842995"
# [1] "[5]:  test's auc:0.848324"
# [1] "[6]:  test's auc:0.848146"

# predict(<lgb.Booster>): LightGBM 모델에 대한 예측 방법
# lgb.Booster 클래스를 기반으로 한 예측 값
preds <- predict(bank_model, x_test)
preds
# [1] 0.02848969 0.08119732 0.04958936 0.02901464 0.32187584 0.03603261 0.08514950 0.04246045
# [9] 0.02670046 0.10986127 0.02813136 0.02860220 0.02709775 0.25046561 0.18476861 0.03764677
# [17] 0.07976574 0.02710770 0.02710840 0.02710770 0.27857127 0.20731222 0.02780615 0.11171954
# [25] 0.02710840 0.04476491 0.11377850 0.05222384 0.18338823 0.02938786 0.47316207 0.04521091
# [33] 0.03318453 0.03603261 0.14453860 0.49471512 0.02711498 0.03191460 0.03877522 0.02901464
# [41] 0.39457047 0.51762124 0.49403014 0.38285716 0.04100746 0.28401883 0.08904497 0.02855979
# 행이 많아 일부만 발췌

# lgb.cv(): Cross validation logic used by LightGBM
bank2_model <- lgb.cv( params = bank_params , data = dtrain , nrounds = 5 , nfold = 3 )
# [LightGBM] [Info] Number of positive: 194, number of negative: 1486
# [LightGBM] [Warning] Auto-choosing row-wise multi-threading, the overhead of testing was 0.000722 seconds.
# You can set `force_row_wise=true` to remove the overhead.
# And if memory is not enough, you can set `force_col_wise=true`.
# [LightGBM] [Info] Total Bins 809
# [LightGBM] [Info] Number of data points in the train set: 1680, number of used features: 15
# [LightGBM] [Info] Number of positive: 216, number of negative: 1465
# [LightGBM] [Warning] Auto-choosing row-wise multi-threading, the overhead of testing was 0.000581 seconds.
# You can set `force_row_wise=true` to remove the overhead.
# And if memory is not enough, you can set `force_col_wise=true`.
# [LightGBM] [Info] Total Bins 809
# [LightGBM] [Info] Number of data points in the train set: 1681, number of used features: 15
# [LightGBM] [Info] Number of positive: 216, number of negative: 1465
# [LightGBM] [Warning] Auto-choosing row-wise multi-threading, the overhead of testing was 0.000629 seconds.
# You can set `force_row_wise=true` to remove the overhead.
# And if memory is not enough, you can set `force_col_wise=true`.
# [LightGBM] [Info] Total Bins 809
# [LightGBM] [Info] Number of data points in the train set: 1681, number of used features: 15
# [LightGBM] [Info] [binary:BoostFromScore]: pavg=0.115476 -> initscore=-2.035985
# [LightGBM] [Info] Start training from score -2.035985
# [LightGBM] [Warning] No further splits with positive gain, best gain: -inf
# [LightGBM] [Info] [binary:BoostFromScore]: pavg=0.128495 -> initscore=-1.914332
# [LightGBM] [Info] Start training from score -1.914332
# [LightGBM] [Warning] No further splits with positive gain, best gain: -inf
# [LightGBM] [Info] [binary:BoostFromScore]: pavg=0.128495 -> initscore=-1.914332
# [LightGBM] [Info] Start training from score -1.914332
# [LightGBM] [Warning] No further splits with positive gain, best gain: -inf
# [1] "[1]:  valid's auc:0.851476+0.00471144"
# [LightGBM] [Warning] No further splits with positive gain, best gain: -inf
# [LightGBM] [Warning] No further splits with positive gain, best gain: -inf
# [LightGBM] [Warning] No further splits with positive gain, best gain: -inf
# [1] "[2]:  valid's auc:0.866928+0.00879337"
# [LightGBM] [Warning] No further splits with positive gain, best gain: -inf
# [LightGBM] [Warning] No further splits with positive gain, best gain: -inf
# [LightGBM] [Warning] No further splits with positive gain, best gain: -inf
# [1] "[3]:  valid's auc:0.872293+0.013794"
# [LightGBM] [Warning] No further splits with positive gain, best gain: -inf
# [LightGBM] [Warning] No further splits with positive gain, best gain: -inf
# [LightGBM] [Warning] No further splits with positive gain, best gain: -inf
# [1] "[4]:  valid's auc:0.874971+0.0109863"
# [LightGBM] [Warning] No further splits with positive gain, best gain: -inf
# [LightGBM] [Warning] No further splits with positive gain, best gain: -inf
# [LightGBM] [Warning] No further splits with positive gain, best gain: -inf
# [1] "[5]:  valid's auc:0.885409+0.0087061"




# lgb.get.eval.result(): 부스터로부터 평가 결과 얻기
# 유효한 data_name 값 검사
print(setdiff(names(bank_model$record_evals), "start_iter")) # [1] "test"

# 데이터세트 "test"에 대한 유효한 eval_name 값 검사
print(names(bank_model$record_evals[["test"]])) # [1] "auc"

# "test" 데이터 세트에 대한 auc 값 가져오기
lgb.get.eval.result(bank_model, "test", "auc") # [1] 0.8278460 0.8345746 0.8348805 0.8429948 0.8483243 0.8481459





# lgb.importance(): Compute feature importance in a model
# 모델의 feature importance에 대한 data.table을 생성합니다.
tree_imp1 <- lgb.importance(bank_model, percentage = TRUE)
tree_imp1
#     Feature        Gain       Cover   Frequency
# 1:  duration 0.538827775 0.303775398 0.213333333
# 2:     pdays 0.133132005 0.096680070 0.093333333
# 3:       age 0.079974815 0.184808265 0.166666667
# 4:   contact 0.047589972 0.048381549 0.053333333
# 5:     month 0.047477736 0.104555860 0.100000000
# 6:       day 0.033780922 0.089183836 0.120000000
# 7:   balance 0.032404638 0.049769301 0.100000000
# 8:  poutcome 0.024694231 0.001494502 0.006666667
# 9:   housing 0.018446022 0.055735449 0.040000000
# 10: education 0.014362666 0.005551009 0.013333333
# 11:       job 0.011059425 0.017376555 0.033333333
# 12:   marital 0.007525791 0.025786096 0.033333333
# 13:      loan 0.007092832 0.011778102 0.013333333
# 14:  campaign 0.003631171 0.005124008 0.013333333

tree_imp2 <- lgb.importance(bank_model, percentage = FALSE)
tree_imp2
#       Feature       Gain Cover Frequency
# 1:  duration 844.754757 25611        32
# 2:     pdays 208.719557  8151        14
# 3:       age 125.381631 15581        25
# 4:   contact  74.609842  4079         8
# 5:     month  74.433882  8815        15
# 6:       day  52.960511  7519        18
# 7:   balance  50.802823  4196        15
# 8:  poutcome  38.714725   126         1
# 9:   housing  28.919007  4699         6
# 10: education  22.517269   468         2
# 11:       job  17.338567  1465         5
# 12:   marital  11.798664  2174         5
# 13:      loan  11.119887   993         2
# 14:  campaign   5.692819   432         2



# lgb.interprete(): Compute feature contribution of prediction
# 원시 점수 예측(rawscore prediction)의 기능 기여 구성 요소(feature contribution components)를 계산합니다.
tree_interpretation <- lgb.interprete(bank_model, x_test, 1:4)
tree_interpretation
# [[1]]
# Feature Contribution
# 1: duration  -0.98555944
# 2:  housing   0.25329017
# 3:      day  -0.23310606
# 4:      age  -0.19288191
# 5:    pdays  -0.16749800
# 6:    month  -0.09785415
# 7: campaign  -0.08258377
# 8:  marital  -0.06476689
# 9:  balance  -0.06386194
# 10:      job   0.04211716
# 11:  contact   0.01703454
# 
# [[2]]
# Feature Contribution
# 1:  contact  -0.73279368
# 2: duration   0.54910348
# 3:    pdays  -0.27807611
# 4:  balance   0.15002121
# 5:    month  -0.10718723
# 6:      day  -0.05729864
# 7:  marital  -0.04645553
# 8:     loan   0.03672380
# 9:      age   0.01341274
# 
# [[3]]
# Feature Contribution
# 1: duration -0.957825457
# 2:      age  0.394389361
# 3:  housing -0.242383880
# 4:    month -0.097854151
# 5:    pdays -0.065028708
# 6:  contact -0.020610189
# 7:  marital -0.010085184
# 8:  balance -0.005037628
# 9:      day  0.004957161
# 
# [[4]]
# Feature Contribution
# 1: duration -0.980148554
# 2:  housing -0.382236355
# 3:      age -0.122334429
# 4:      day  0.096515325
# 5:    month -0.082424341
# 6:    pdays -0.060595451
# 7:      job -0.024360451
# 8:  contact  0.017034542
# 9:  marital -0.013284281
# 10:  balance -0.005037628





# lgb.plot.importance(): feature importance를 막대 그래프로 표시
# 위에서 계산된 feature importance(Gain, Cover 및 Frequency)를 막대그래프로 표시합니다.
tree_imp <- lgb.importance(bank_model, percentage = TRUE)
lgb.plot.importance(tree_imp, top_n = 5, measure = "Gain")





# lgb.plot.interpretation(): Plot feature contribution as a bar graph
# 이전에 계산된 feature contribution을 막대 그래프로 플로팅 합니다
tree_interpretation <- lgb.interprete( model = bank_model , data = x_test , idxset = 1:4 )
tree_interpretation

lgb.plot.interpretation( tree_interpretation_dt = tree_interpretation[[1]] , top_n = 3 )
