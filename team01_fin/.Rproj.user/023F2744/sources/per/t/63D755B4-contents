# 오차 측정 함수 정의
calculate_errors <- function(actual, predicted) {
  
  # SMAPE (Symmetric Mean Absolute Percentage Error)
  smape <- 100 * mean(2 * abs(predicted - actual) / (abs(predicted) + abs(actual)), na.rm = TRUE)
  
  # RMSE (Root Mean Squared Error)
  rmse <- rmse(actual, predicted)
  
  # MAE (Mean Absolute Error)
  mae <- mae(actual, predicted)
  
  # MSE (Mean Squared Error)
  mse <- mse(actual, predicted)
  
  return(data.frame(BID = i, SMAPE = smape, RMSE = rmse, MAE = mae, MSE = mse))
}

