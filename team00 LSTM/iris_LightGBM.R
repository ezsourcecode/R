library(lightgbm)

data(iris)
str(iris)


new_iris <- lgb.convert_with_rules(data = iris)
str(new_iris$data)


data(iris) # iris dataset 삭제
iris$Species[1L] <- "NEW FACTOR" # Introduce junk factor (NA)

# 알려진 규칙을 사용하여 변환
# 알 수 없는 요인은 0이 되며 희소 데이터 세트에 적합
newer_iris <- lgb.convert_with_rules(data = iris, rules = new_iris$rules)
head(newer_iris$data)

# (첫번째 데이터의 Species 값이 0으로 변환됨)

newer_iris$data[1, 5] <- 1.0 # 실제 초기값 되돌리기

# 새로 생성된 데이터 세트가 동일한가요? YES!
all.equal(new_iris$data, newer_iris$data)
# [1] TRUE

# 우리 자신의 규칙을 테스트할 수 있습니까?
data(iris) # Erase iris dataset

# 값을 다르게 재 맵핑
personal_rules <- list(
  Species = c(
    "setosa" = 3L
    , "versicolor" = 2L
    , "virginica" = 1L
  )
)
newest_iris <- lgb.convert_with_rules(data = iris, rules = personal_rules)
str(newest_iris$data) # 성공


# https://zzinnam.tistory.com/entry/Data-IO-for-LightGBM-with-R

