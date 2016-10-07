# R 資料結構
# 取 50 個整數
x <- sample(50)
x
# 轉換成矩陣
x.m <- matrix(x, nrow = 10)
# 轉換成資料框架
x.df <- data.frame(x.m)
x.m
# 第三行取 log10 ，並取代原本的資料
x.m[,3] <- log10(x.m[,3])
