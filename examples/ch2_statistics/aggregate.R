library(data.table)

ts <- '2016102111'
ts_formated <- strptime(ts, '%Y%m%d%H')
timestamp <- as.POSIXct(ts_formated)

a200601 <- fread('~/Downloads/cwb2006-2015/raw/200601_auto_hr.txt', 
      skip = 75,
      na.strings = c('-9991','-9995','-9996','-9997','-9998','-9999'))

setnames(a200601, 1:9, 
         c('stno', 'yyyymmddhh', 'PS01', 'TX01', 'RH01', 
           'WD01', 'WD02', 'PP01', 'SS01'))
a200601$yyyymmddhh <- a200601$yyyymmddhh-1

a200601[, timestamp:=as.POSIXct(strptime(yyyymmddhh, '%Y%m%d%H'))]

mean_omit_na <- function(x){
  x <- as.numeric(x)
  return(mean(x, na.rm = T))
}

library(plyr)
tx <- plyr::ddply(a200601, .(stno), summarize,
            tx = mean_omit_na(TX01),
            wd = mean_omit_na(WD01))

v1 <- c(1, 3, NA, 5, 7)
mean_omit_na(v1)
