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



