rm( list = ls() )


forecast <- function() {
  # 建立一個「天氣」的向量
  x <- c('下雨', '颱風', '下雪', 
         '晴天', '陰天', '冰雹')
  action <- c('帶傘', '宅在家', '出門玩')
  # 隨機排列，並且取出第一個「天氣」現象
  # 並命名為 weather (變數)
  weather <- sample(x)[1]

  # 更複雜的判斷與行動
  if ( weather == '冰雹' | weather == '颱風' ) {
    # 宅在家
    print(paste('現在天氣是', weather, 
                '，所以', action[2], sep=""))
  } else if ( weather == '下雨' ) {
    # 帶傘
    print(paste('現在天氣是', weather, 
                '，所以', action[1], sep=""))
  } else {
    # 出門玩
    print(paste('現在天氣是', weather, 
                '，所以', action[3], sep=""))
  }
}  

forecast()

#### part 2: 迴圈
print(1)
print(2)
print(3)
print(4)
print(5)
print(6)
print(7)
print(8)
print(9)
print(10)

# for 迴圈的作法
for ( i in 1:6 ) {
  print(i)
}

i <- 1
while ( i <= 6 ){
  print(i)
  # i 自動加 1
  i <- i + 1
}

# Fibonacci 數列
# 1 2 3 4 5 6 7  8  9 10
# 0 1 1 2 3 5 8 13 21 34
fib <- integer(10)
fib <- vector(mode = 'integer', length = 10)

fib[1] <- 0
fib[2] <- 1
fib[3] <- fib[1] + fib[2]
fib[4] <- fib[2] + fib[3]
fib[5] <- fib[3] + fib[4]
fib[6] <- fib[4] + fib[5]
fib[7] <- fib[5] + fib[6]
fib[8] <- fib[6] + fib[7]
fib[9] <- fib[7] + fib[8]
fib[10] <- fib[8] + fib[9]

# 用迴圈的方式
fib <- integer(15)
fib[1] <- 0
fib[2] <- 1
for ( i in 3:15 ){
  fib[i] <- fib[i-2] + fib[i-1]
}
fib

# function 的作法
fibonacci <- function(n){
  # 先建立 n 個位置等待填滿數值 
  fib <- integer(n)
  # 如果 n 為 1 的話，直接傳回 0 
  if ( n == 1 ){
    return(0)
  # 若 n 為 2 的話，傳回 0, 1
  } else if ( n == 2 ){
    return(c(0, 1))

  } else {
    fib[1] <- 0
    fib[2] <- 1
    for ( i in 3:n ){
      fib[i] <- fib[i-2] + fib[i-1]
    }
    return(fib)
  }
}

fibonacci(5)
fibonacci(15)
fibonacci(23)
fibonacci(3)
