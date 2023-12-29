# 시각화 ggplot2 패키지를 이용
## 패키지 설치 - 외부 패키지
install.packages('ggplot2')
## 패키지 로딩 - 패키지가 제공하는 다양한 함수를 사용
library(ggplot2)

# 기본 문법 - 레이어 구조 이용
## style 1. ggplot(data, aes())배경 + geom_point()
## style 2. ggplot(data) + geom_point(aes())
## maapping(매핑) - 연결, a <- 1
## aes(): x, y축에 관한 값을 매핑

# 내장 데이터셋 airquality
str(airquality)
## x - Day, y - Temp
## 산점도(산포도): 두 관측 데이터의 상관관계를 분석할 때 효율적으로 사용
ggplot(airquality, aes(x = Day, y = Temp)) + geom_point()
## 볼릿(심볼)의 크기와 색상을 변경하는 작업. 기본 점의 크기는 1.5
ggplot(airquality, aes(x = Day, y = Temp)) + geom_point(color = 'red', size = 3)
ggplot(airquality, aes(x = Day, y = Temp, color = 'red', size = 3)) + geom_point()

## 선 그래프: 시계열 데이터, geom_line()
ggplot(airquality, aes(x = Day, y = Temp)) + geom_line()

# 막대 그래프: 빈도(크기), geom_bar()
## 실린더 종류에 따른 차종의 빈도수 확인
str(mtcars)
table(mtcars$cyl) # 도수분포표
ggplot(mtcars, aes(x = cyl)) + geom_bar(width = 0.5)
## factor
ggplot(mtcars, aes(x = factor(cyl))) + geom_bar(width = 0.5)

# 누적 막대 그래프: geom_
table(mtcars$gear)
## gear의 빈도값을 포함한 누적 막대 그래프
## fill - 해당 축 값을 색상으로 채움(factor 사용 안 했더니 색 안 나옴)
# 빈 값이 있어 factor를 사용함 #
ggplot(mtcars, aes(x = factor(cyl))) + geom_bar(aes(fill = factor(gear)))

## 누적 막대 그래프 선버스트(계층 구조) 차트를 이용
# theta = 'y' 옵션은 도넛모양 같음 #
ggplot(mtcars, aes(x = factor(cyl))) + geom_bar(aes(fill = factor(gear))) + coord_polar(theta = 'y')

# 상자 수염 그래프: geom_boxplot()
## 전체 데이터의 분포를 확인하려는 시각화 도구로 이상치를 판단할 때 유용
## 날짜별로 온도의 분포를 확인하기 위해 날짜별 그룹이 필요 group = Day
ggplot(airquality, aes(x = Day, y = Temp, group = Day)) + geom_boxplot()

# 히스토그램: geom_histogram()
ggplot(airquality, aes(Temp)) + geom_histogram()

ggplot(airquality, aes(Temp)) + geom_bar()

## 구간 조정: binwidth
ggplot(airquality, aes(Temp)) + geom_histogram(binwidth = 0.5)

# 선 추가: geom_abline(intercept = 절편, slope = 기울기)
str(economics)
help(economics)
## 날짜별 저축률을 선 그래프로 구현 후 그 위 사선 추가
ggplot(economics, aes(x = date, y = psavert)) + geom_line() + geom_abline(intercept = 12.1867, slope = -0.0005444)

# 평행선 추가: geom_hline(yintercept = y절편(평균값))
ggplot(economics, aes(x = date, y = psavert)) + geom_line() + geom_hline(yintercept = mean(economics$psavert))

# 수직선 추가: geom_vline(xintercept = x절편)
## 개인 저축률이 가장 낮은 시기를 알아보려 한다.
## 개인 저축률이 낮은 시기를 이용해서 수직선을 추가
min_psavert <- min(economics$psavert) # 2.2
min_date <- economics[economics$psavert == min_psavert, 'date']
min_date <- as.numeric(min_date)# 1 2005-07-01
ggplot(economics, aes(x = date, y = psavert)) + geom_line() + geom_vline(xintercept = as.Date('2005-07-01'))
ggplot(economics, aes(x = date, y = psavert)) + geom_line() + geom_vline(xintercept = min_date)

# 레이블 추가: geom_text(aes(label = 레이블, vjust = 세로 위치, hjust = 가로 위치))
## 세로와 가로의 위치 값이 모두 0이면 점의 오른쪽 위
## 세로와 가로의 위치 값이 + 값은 왼쪽/아래, - 값은 오른쪽/위
ggplot(airquality, aes(x = Day, y = Temp)) + geom_point() + geom_text(aes(label = Temp, vjust = 0, hjust = 0))

# 도형이나 화살표 추가: annotate('모양', xmin = x축 시작, xmax = x축 끝, ymin = y축 시작, ymax = y축 끝, alpha = 투명도)
## 그래프 영역에 투명 박스나 화살표를 이용하여 특정 영역을 강조하는 역할
## mtcars 데이터셋에 무게와 연비를 기준으로 산점도 그래프를 구현한다.
ggplot(mtcars, aes(x = wt, y = mpg)) + geom_point() + annotate('rect', xmin = 3, xmax = 4, ymin = 12, ymax = 20, alpha = 0.5, fill = 'skyblue')

## annotate() 함수의 모양 부분에 segment(화살표 쓰기 위한), x, xend, y, yend를 추가
ggplot(mtcars, aes(x = wt, y = mpg)) + geom_point() + annotate('rect', xmin = 3, xmax = 4, ymin = 12, ymax = 20, alpha = 0.5, fill = 'skyblue') + annotate('segment', x = 2.5, xend  = 3.7, y = 10, yend = 17, arrow = arrow(), color = 'red') + annotate('text', x = 2.5, y = 10, label = 'point')

# 그래프 제목, 축 제목 추가: labs()
## labs(x = 'x축 제목', y = 'y축 제목', title = '그래프 제목')
ggplot(mtcars, aes(x = gear)) + geom_bar() + labs(x = '기어 수', y = '자동차 수', title = '기어별 자동차 수')

# 디자인 테마: theme()
theme_gray()
