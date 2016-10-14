#### Ecoinformatics --- part 1: R
## 1. 資料的輸出入
library(data.table)
library(curl)
library(plyr)

setwd('~/Documents/Dropbox/Courses/生態資訊學/gitbook/examples/ch1_r_project/')

# 使用 curl 來下載資料
# 設定國家公園面積的 URL 當成變數 np_raw_url
np_raw_url <- 'http://statis.moi.gov.tw/micst/~w10510149314549017757021-c0820101.csv' 
# 使用 curl_download 儲存資料
curl::curl_download(np_raw_url, 'data/np_raw.csv')

# 使用 read.csv 來讀取資料
np_raw <- read.csv('data/np_raw.csv', skip = 1)
# 使用 data.table 中的 fread 來讀取資料
np_raw <- data.table::fread('data/np_raw.csv', skip = 1)

# 轉成西元年
#    1. 先將資料欄位中有「年」的文字取代掉
roc_year <- gsub('年', '', np_raw[,1])
#    2. 再轉換成西元年
np_raw[,1] <- as.numeric(roc_year) + 1911
np_raw[,1]




## 2. 聚合資料


# 讀取中央氣象局自動測站 2015/10 的資料
cwb201510 <- fread('data/201510_auto_hr.txt', skip=74)
# 看資料的維度，顯示的為「列數(rows)」、「行數(columns)」
dim(cwb201510)
# 看前幾筆長什麼樣子
head(cwb201510)
# 查詢欄位名稱 stno 中，有哪些測站？
factor(cwb201510$stno)

# 處理時間
cwb201510_timestamp <- 
  as.POSIXct(strptime(cwb201510$yyyymmddhh, '%Y%m%d%H'))
# 存成一個新的欄位稱為 timestamp
cwb201510[, timestamp:=cwb201510_timestamp]

ctime <- as.POSIXct(strptime('201610141147', '%Y%m%d%H%M'))
mday(ctime)
yday(ctime)
week(ctime)

## 處理氣象資料計算統計值
# https://gist.github.com/mutolisp/4d0046a5423343988bab0a69b6c5747e
# 使用 ddply 的前置作業
# 統計時要排除 NA 值，所以另外寫 function 加上 fread 之後當成 character，要把它轉成 numeric
# 以下的 function 用在 calc_monthly_stats() 中的 ddply()
mean_omit_na = function(x){
  x = as.numeric(x)
  return(mean(x, na.rm=T))
}
sum_omit_na = function(x){
  x = as.numeric(x)
  return(sum(x, na.rm=T))
}
cmax = function(x) {
  x = as.numeric(x)
  return(max(x, na.rm=T))
}
cmin = function(x) {
  x = as.numeric(x)
  return(min(x, na.rm=T))
}


proc_cwb_autostns_stats = function(cwb_auto_data, station_list, period='m') { 
  
  ## 資料輸入
  # 把自動氣象測站資料用 fread 餵進去，io 速度比較快
  # 先設定欄位名稱(names)和類別(classes)
  col_names = c('stno','yyyymmddhh','PS01','TX01','RH01','WD01','WD02','PP01','SS01')
  col_classes = c('character', 'integer', 'float', 'float', 'integer', 'float','integer', 'float','float')
  # 前 75 行都是欄位說明，所以去除，特殊值當成 NA
  df1 = fread(cwb_auto_data, skip=74, header=FALSE, colClasses=col_classes, 
              na.strings = c('-9991','-9995','-9996','-9997','-9998','-9999'))
  # 設定名稱
  setnames(df1, col_names)
  df1[,timestamp:=as.POSIXct(strptime(df1$yyyymmddhh, format='%Y%m%d%H'))]
  df1[,date:=as.POSIXct(strptime(df1$yyyymmddhh, format='%Y%m%d'))]
  df2 <- df1[hour(df1$timestamp) >= 20  & hour(df1$timestamp) <=23]
  
  # m: 為逐月資料
  # d: 為逐日資料
  if ( period == 'm' ){
    aggr_var = .(stno)
    # append 日期(YYYYmm)
    cdate = unique(substr(df1$yyyymmddhh, 1, 6))
  } else if ( period == 'd' ){
    aggr_var = .(stno, date)
  }
  
  # ddply 來 aggregate 資料，計算出每個月/日的平均{氣壓、氣溫、濕度、風向、風速等}及累積雨量
  # 因為 min(numeric(0)) 即整個站都是 NA 值的時候，就會 return -Inf (反之 max 則 return 為 Inf)
  # 對計算上沒有影響，所以用 suppressWarnings() 來略過不理它
  # http://stackoverflow.com/questions/24282550/no-non-missing-arguments-warning-when-using-min-or-max-in-reshape2/24328604#24328604
  df2 = suppressWarnings(ddply(df1, aggr_var, summarize,
                               ps = mean_omit_na(PS01),
                               tx = mean_omit_na(TX01),
                               tmax = cmax(TX01),
                               tmin = cmin(TX01),
                               rh = mean_omit_na(RH01),
                               wd01 = mean_omit_na(WD01),
                               wd02 = mean_omit_na(WD02),
                               pp = sum_omit_na(PP01),
                               ss = mean_omit_na(SS01)
  ))
  
  # <dirty_code>
  if ( period == 'm' ){
    df2 = merge(cdate, df2)
    colnames(df2)[1] = "date"
  }
  # </dirty_code>
  
  if ( length(station_list) > 0 ) {
    final_df = df2[which(df2$stno %in% station_list),]
  } else {
    final_df = df2 
  }
  
  
  return(final_df)
}

proc_cwb_autostns_stats('data/201510_auto_hr.txt', 'C0A520', 'm')
