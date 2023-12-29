# 데이터 시각화: plot(), barplot(), boxplot(), hist(), pie() => ggplot2
## plot(): 산점도 그래프
## plot(y축 데이터, 옵션) or plot(x축 데이터, y축 데이터, 옵션)
y <- c(1, 1, 2, 2, 3, 3, 4, 4, 5, 5)
plot(y)

## pch: 심볼모양 0= 빈 네모, 1= 빈 동그라미, 2= 빈 세모 3= +, 4= x, 5= 빈 마름모 등 0 ~ 25.
plot(y, pch = 18)

x <- 1:10
y <- 1:10
plot(x, y)

plot(cars$speed, cars$dist)

# xlab, ylab - x, y축 이름
# main - 그래프 제목
# sub - 그래프 부제목
# ann - F/T, 제목 지정 여부
# axes - F/T, 축 표시 여부
# axis - 사용자 지정 축값
# type - 그래프 종류(l = line, p = point, b = both)
# lty(line style): 0(' blank)
plot(x, y, pch = '*', type = 'l', lty = 'dashed', col = 2)

x <- runif(100)
y <- runif(100)

## y 값이 0.5보다 크면 1, 아니면 18
plot(x, y, pch =  ifelse(y > 0.5, 1, 18))

## 산점도 + 텍스트 추가
library(MASS)
str(Animals)
Animals
plot(Animals$body, Animals$brain, pch = 16, col = 'blue', xlab = 'Body weight(kg)', ylab = 'Brain weight(g)', xlim = c(0, 250), ylim = c(0, 1400))
text(x = Animals$body, y = Animals$brain, labels = row.names(Animals), pos = 4)

plot(~ Sepal.Length + Sepal.Width, data = iris, pch = rep(15:17, each = 50), col = c('red', 'green', 'blue')[iris$Species], cex = 1.5)
legend('topright', legend = levels(iris$Species), pch = 15:17, col = c('red', 'green', 'blue'), cex = 1.2, bty = 2)

# 막대그래프: barplot(), 도수분포표, 빈도
sales <- c(0.12, 0.3, 0.26, 0.16, 0.04, 0.12)
barplot(sales, names.arg = c('berry', 'cheery', 'apple', 'banana', 'candy', 'cream'), horiz = T)

# 누적 막대그래프
xx <- matrix(1:6, nrow = 3)
barplot(xx)

# 시즌별 티켓판매량을 그래프로 표현
aaa <- c(110, 300, 150, 280, 310)
bbb <- c(180, 200, 210, 190, 170)
ccc <- c(210, 150, 260, 210, 70)
data <- matrix(c(aaa, bbb, ccc), nrow = 5)
#       [,1] [,2] [,3]
# [1,]  110  180  210
# [2,]  300  200  150
# [3,]  150  210  260
# [4,]  280  190  210
# [5,]  310  170   70
barplot(data, main = '스포츠 경기별 티켓 판매량', xlab = '종목', ylab = '판매량', beside = T,
        names.arg = c('야구', '축구', '농구'), border = 'blue', col = rainbow(5), ylim = c(0, 400))
legend(16, 400, c('야구', '축구', '농구'), cex = 0.8, fill = rainbow(5))

# ggplot2
library(ggplot2)

# 단순하게 그래프를 그리는 qplot(x, y, 옵션)
qplot(Sepal.Length, Petal.Length, data = iris)

# 꽃잎 그래프(sun flower graph)
x <- c(1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 3, 3, 4, 5, 6)
y <- c(2, 1, 4, 2, 3, 2, 2, 2, 2, 2, 2, 1, 1, 1, 1)
df <- data.frame(x, y)
sunflowerplot(df)

stars(mtcars[1:4], flip.labels = F, key.loc = c(13, 1.5))

# ggolot 시각화 단계 - 레이어 구조
## step 1. 도화지(캔버스-배경) - 축을 그린다.
ggplot(data = mpg, aes(x = displ, y = hwy))
## step 2. 그래프의 종류
### geom_bar(): 막대그래프, geom_histogram(): 히스토그램, geom_boxplot(): 박스플롯, geom_line(): 선 그래프, geom_point(): 산점도 그래프
ggplot(data = mpg, aes(x = displ, y = hwy)) + geom_point()
## step 3. 기타 옵션을 지정해 그래프르 정교하게 표현
ggplot(data = mpg, aes(x = displ, y = hwy)) + geom_point() + xlim(3, 6) + ylim(10, 30)
