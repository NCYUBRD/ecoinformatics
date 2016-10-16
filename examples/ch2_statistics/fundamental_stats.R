## 基礎統計

# 鴛尾花資料集
iris

# 取得 iris 資料集的摘要
summary(iris)

# 計算

mean(iris$Sepal.Length)
mean(iris$Sepal.Width)

sd(iris$Sepal.Length)


# 資料的聚集(aggregate)
# 針對物種的花瓣長度計算平均
aggregate(iris$Petal.Length, by = list(iris$Species), FUN = mean)
或是
aggregate(Petal.Length ~ Species, data = iris, mean)

# 計算所有變項的平均，使用點(.) 來代表
aggregate(. ~ Species, data = iris, mean)

# 取對數後乘以 10 再加總起來
customLog <- function(x) {
  y <- sum(log10(x) * 10)
  return(y)
}

aggregate(. ~ Species, data = iris, FUN = customLog)

# 使用 data.table 來處理
library(data.table)
# 把 iris data set 轉換成 data.table 的格式
iris.dt <- data.table(iris)
# 把 Species 當成索引值
setkey(iris.dt, Species)
# 計算花瓣的寬度平均
iris.dt[, mean(Petal.Width), by = Species]

## T-test
iris_sv <- iris.dt[iris.dt[, Species == 'setosa' | Species == 'virginica']]
t.test(Sepal.Length ~ Species, data = iris_sv)

