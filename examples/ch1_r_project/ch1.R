# this is comments
# this is also a comment
# test
# test2

# 設定工作目錄
# 如果你使用 Mac 或 GNU/Linux作業系統
setwd('/Users/psilotum/Documents/Dropbox/Courses/生態資訊學/demo')
# 假設你使用 windows 作業系統，路徑要改成 \\ (兩個反斜線)
# 
setwd('C:\\Users\\psilotum\\Documents\\Dropbox\\Courses\\生態資訊學\\demo')
# 或是使用選單中的 Session 選擇 set working directory

# 四則運算
3 + 5

5 - 3

# sequence

A <- matrix(c(1,3,2,4,2,3,2,3,1),3,3)
B <- matrix(c(2,1,3,4,1,5,1,2,2),3,3)

# A dot B
A %*% B

# A multiplies B
A * B


5 > 1
5 < 1
5 == 1

a <- d <- 5
b <- 13
c <- 7
a == d
a == c
a > c
a != b
rn <- rnorm(5)
rn > 1

rn[rn < 1]
