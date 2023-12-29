library(foreign)
raw <- read.spss('C:/k_digital/data/HN21/HN21_ALL.sav', to.data.frame = T)
View(raw)

dat <- read.spss('C:/k_digital/data/HN21/test3.sav', to.data.frame = T, reencode = 'utf-8') # reencode = 'utf-8' 이 옵션은 한글을 불러올 때 깨지지 않게 해줌 #
View(dat)

# 방대한 데이터의 형태를 파악하는 패키지
install.packages('DataExplorer')
library(DataExplorer)
introduce(raw)
# rows columns(행수) discrete_columns(이산형) continuous_columns(연속형) all_missing_columns(결측행)
# 1 7090     869               63                806                   0
# total_missing_values(결측값 수) complete_rows total_observations memory_usage
# 1              1084952             0            6161210     50359280

# 변수별 결측률 확인
profile_missing(raw) # 결측이 이런 식으로 나옴 #
#           feature num_missing pct_missing
# 1        mod_d           0  0.00000000
# 2           ID           0  0.00000000
# 3       ID_fam           0  0.00000000
# 4         year           0  0.00000000
# 5       region           0  0.00000000
# 6       town_t           0  0.00000000
# 7        apt_t           0  0.00000000
# 8          psu           0  0.00000000
# 9          sex           0  0.00000000
# 10         age           0  0.00000000
# 11   age_month        6773  0.95528914

# 결측률이 90% 이상인 데이터만 추출
raw_missing <- profile_missing(raw)
library(dplyr)
arrange(subset(raw_missing, pct_missing > 0.9), desc(pct_missing))

install.packages('psych')
psych::describe(raw) # 모든 변수 이런 식으로 나옴 #
#             vars    n     mean       sd   median  trimmed     mad     min       max
# mod_d*        1 7090     1.00     0.00     1.00     1.00    0.00    1.00      1.00
# ID*           2 7090  3545.50  2046.85  3545.50  3545.50 2627.91    1.00   7090.00
# ID_fam*       3 7090  1689.72   978.83  1656.00  1682.36 1214.25    1.00   3425.00
# year          4 7090  2021.00     0.00  2021.00  2021.00    0.00 2021.00   2021.00