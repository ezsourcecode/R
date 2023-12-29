# Xgboost 사용
install.packages("xgboost") # xgboost 패키지가 설치되어 있으면 제외
library(xgboost)               # xgboost 패키지 로딩

# LightGBM 패키지에 있는 bank 데이터 가져오기
data(bank, package = "lightgbm")
dim(bank) # 4521개의 데이터와 17개의 변수 보유

head(bank) # 데이터 구조 확인
#     age         job marital education default balance housing loan  contact day month duration
# 1:  30  unemployed married   primary      no    1787      no   no cellular  19   oct       79
# 2:  33    services married secondary      no    4789     yes  yes cellular  11   may      220
# 3:  35  management  single  tertiary      no    1350     yes   no cellular  16   apr      185
# 4:  30  management married  tertiary      no    1476     yes  yes  unknown   3   jun      199
# 5:  59 blue-collar married secondary      no       0     yes   no  unknown   5   may      226
# 6:  35  management  single  tertiary      no     747      no   no cellular  23   feb      141
#     campaign pdays previous poutcome  y
# 1:        1    -1        0  unknown no
# 2:        1   339        4  failure no
# 3:        1   330        1  failure no
# 4:        4    -1        0  unknown no
# 5:        1    -1        0  unknown no
# 6:        2   176        3  failure no

colSums(is.na(bank)) # 결측 데이터(NA) 유무 확인
# age       job   marital education   default   balance   housing      loan   contact       day 
# 0         0         0         0         0         0         0         0         0         0 
# month  duration  campaign     pdays  previous  poutcome     y 
# 0         0         0         0         0         0         0 

# 범주형 변수와 숫자형 변수 확인
str(bank)
# Classes ‘data.table’ and 'data.frame':	4521 obs. of  17 variables:
# $ age      : int  30 33 35 30 59 35 36 39 41 43 ...
# $ job      : chr  "unemployed" "services" "management" "management" ...
# $ marital  : chr  "married" "married" "single" "married" ...
# $ education: chr  "primary" "secondary" "tertiary" "tertiary" ...
# $ default  : chr  "no" "no" "no" "no" ...
# $ balance  : int  1787 4789 1350 1476 0 747 307 147 221 -88 ...
# $ housing  : chr  "no" "yes" "yes" "yes" ...
# $ loan     : chr  "no" "yes" "no" "yes" ...
# $ contact  : chr  "cellular" "cellular" "cellular" "unknown" ...
# $ day      : int  19 11 16 3 5 23 14 6 14 17 ...
# $ month    : chr  "oct" "may" "apr" "jun" ...
# $ duration : int  79 220 185 199 226 141 341 151 57 313 ...
# $ campaign : int  1 1 1 4 1 2 1 2 2 1 ...
# $ pdays    : int  -1 339 330 -1 -1 176 330 -1 -1 147 ...
# $ previous : int  0 4 1 0 0 3 2 0 0 2 ...
# $ poutcome : chr  "unknown" "failure" "failure" "unknown" ...
# $ y        : chr  "no" "no" "no" "no" ...

#17개의 변수 중 숫자형 변수 7개, 범주형 변수 9개, Target변수 1개로 구성되어 있음

# Target변수를 0과 1로 변환하기
dt_xgboost <- bank    # 원본 데이터를 변경하지 않기 위해 복사
dt_xgboost$y <- ifelse(dt_xgboost$y == 'no', 0 ,1)  # Target변수를 0과 1로 변환
str(dt_xgboost$y) #  num [1:4521] 0 0 0 0 0 0 0 0 0 0 ...
table(dt_xgboost$y)
#    0    1 
# 4000  521 

install.packages("Matrix") # sparse matrix 생성에 필요한 패키지 설치, 이미 설치되어 있으면 생략
library(Matrix)      # Matrix 패키지 로드
# sparse matrix 생성
dt_xgb_sparse_matrix <- sparse.model.matrix(y~. -1, data = dt_xgboost)

# train data set sampling index 정의
train_index <- sample(1:nrow(dt_xgb_sparse_matrix), 2500)

# train 및 test data set 및 label data 생성  
train_x <- dt_xgb_sparse_matrix[train_index,]
test_x <- dt_xgb_sparse_matrix[-train_index,]
train_y <- dt_xgboost[train_index,'y']
test_y <- dt_xgboost[-train_index,'y']

dim(train_x)
# [1] 2500   43
dim(test_x)
# [1] 2021   43
# 범주형 변수들의 dummy화로 변수의 개수가 17개에서 43개로 증가함

## xgboost 알고리즘 사용을 위한 데이터 형태 변환
dtrain <- xgb.DMatrix(data = train_x, label= as.matrix(train_y))
dtest <- xgb.DMatrix(data = test_x, label= as.matrix(test_y))



# 파라미터 세팅
dt_param <- list(max_depth = 3,
              eta = 0.1, 
              verbose = 0, 
              nthread = 2,
              objective = "binary:logistic", 
              eval_metric = "auc")

# xgboost 알고리즘 적용
xgb <- xgb.train(params = dt_param,
                 data = dtrain, 
                 nrounds=10, 
                 subsample = 0.5,
                 colsample_bytree = 0.5,
                 num_class = 1
)

# 테스트 세트의 확률 값 예측
# train data 확률 값 산출
train_y_pred <- predict(xgb, dtrain)

# test data 확률값 산출
test_y_pred <- predict(xgb, dtest)

install.packages("MLmetrics")  # MLmetrics 패키지가 설치되어 있으면 생략 가능
library(MLmetrics)  # MLmetrics 패키지 로드

# train data에 대한 KS 통계량 산출
KS_Stat(train_y_pred,train_y)

# test data에 대한 KS 통계량 산출
KS_Stat(test_y_pred,test_y)



# 실제 나무가 어떻게 생겼는지....
dt_model <- xgb.dump(xgb, with_stats = T)
dt_model[1:10]   # 모델의 상위 10개 노드를 인쇄합니다.
# [1] "booster[0]"                                                               
# [2] "0:[f41<-9.53674316e-07] yes=1,no=2,missing=1,gain=51.0396118,cover=317.25"
# [3] "1:[f0<60.5] yes=3,no=4,missing=3,gain=19.190979,cover=306.25"             
# [4] "3:[f13<-9.53674316e-07] yes=7,no=8,missing=7,gain=3.2902832,cover=296.25" 
# [5] "7:leaf=-0.143333331,cover=119"                                            
# [6] "8:leaf=-0.171949506,cover=177.25"                                         
# [7] "4:[f13<-9.53674316e-07] yes=9,no=10,missing=9,gain=5.41414118,cover=10"   
# [8] "9:leaf=0.100000001,cover=2"                                               
# [9] "10:leaf=-0.0555555597,cover=8"                                            
# [10] "2:[f32<-9.53674316e-07] yes=5,no=6,missing=5,gain=3.78362894,cover=11"  

# 모형에 활용된 feature명 확인
names <- dimnames(dtrain)[[2]]
names
# [1] "age"                "jobadmin."          "jobblue-collar"     "jobentrepreneur"   
# [5] "jobhousemaid"       "jobmanagement"      "jobretired"         "jobself-employed"  
# [9] "jobservices"        "jobstudent"         "jobtechnician"      "jobunemployed"     
# [13] "jobunknown"         "maritalmarried"     "maritalsingle"      "educationsecondary"
# [17] "educationtertiary"  "educationunknown"   "defaultyes"         "balance"           
# [21] "housingyes"         "loanyes"            "contacttelephone"   "contactunknown"    
# [25] "day"                "monthaug"           "monthdec"           "monthfeb"          
# [29] "monthjan"           "monthjul"           "monthjun"           "monthmar"          
# [33] "monthmay"           "monthnov"           "monthoct"           "monthsep"          
# [37] "duration"           "campaign"           "pdays"              "previous"          
# [41] "poutcomeother"      "poutcomesuccess"    "poutcomeunknown"   

# feature importance matrix 계산
importance_matrix <- xgb.importance(names, dt_model = xgb)
importance_matrix
#               Feature         Gain        Cover  Frequency
# 1:           duration 0.4922300799 0.3218577331 0.25757576
# 2:    poutcomesuccess 0.1725146332 0.1510983200 0.07575758
# 3:                age 0.0923112192 0.1806156129 0.15151515
# 4:           monthmar 0.0603710331 0.0757310802 0.04545455
# 5:                day 0.0359471946 0.0448353389 0.10606061
# 6:              pdays 0.0323390341 0.0424738517 0.03030303
# 7:           previous 0.0238297640 0.0142667834 0.03030303
# 8:           monthnov 0.0119689266 0.0051498894 0.03030303
# 9:     maritalmarried 0.0107374595 0.0359144899 0.03030303
# 10:           monthoct 0.0089238726 0.0258808327 0.01515152
# 11:         housingyes 0.0083484785 0.0059648681 0.01515152
# 12:    poutcomeunknown 0.0073873957 0.0283404735 0.01515152
# 13:           monthaug 0.0064484413 0.0032031879 0.01515152
# 14:           monthmay 0.0046673465 0.0012899898 0.01515152
# 15: educationsecondary 0.0046486906 0.0003709964 0.01515152
# 16:  educationtertiary 0.0046201001 0.0024239359 0.01515152
# 17:   educationunknown 0.0039572425 0.0010847642 0.01515152
# 18:          jobadmin. 0.0038955923 0.0051578112 0.01515152
# 19:      jobtechnician 0.0034952356 0.0018558206 0.01515152
# 20:     contactunknown 0.0029898535 0.0011657360 0.01515152
# 21:   jobself-employed 0.0029475110 0.0017267454 0.01515152
# 22:         defaultyes 0.0018718407 0.0231826615 0.01515152
# 23:            balance 0.0016320444 0.0015569180 0.01515152
# 24:           monthfeb 0.0013179644 0.0240069318 0.01515152
# 25:   contacttelephone 0.0005990461 0.0008452277 0.01515152
#               Feature         Gain        Cover  Frequency

# feature importance matrix 그래프 그리기
xgb.plot.importance(importance_matrix[1:10,])


# https://zzinnam.tistory.com/entry/R%EC%97%90%EC%84%9C-XGBoost-%EC%95%8C%EA%B3%A0%EB%A6%AC%EC%A6%98%EC%9D%84-%EC%82%AC%EC%9A%A9%ED%95%9C-%EB%B6%84%EB%A5%98%EC%98%88%EC%B8%A1%EB%AA%A8%EB%8D%B8-%EC%A0%81%ED%95%A9-%EC%98%88%EC%8B%9C