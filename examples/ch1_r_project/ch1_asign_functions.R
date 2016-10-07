## 指定變數

x <- 1
y <- "1"
LETTERS[25]
1:50

# 匯率換算
# 指定變數名稱為 USDTWD，其值為 31.53
USDTWD <- 31.53
# 15 USD 等於多少新臺幣呢？
15 * 31.53
15 * USDTWD

# usdtwdConv function
# arguments:
#   * usd 美金的數目
#   * USDTWD 新臺幣的匯率，預設值是 31.5
usdtwdConv <- function(usd, USDTWD = 31.5){
  twd <- usd * USDTWD
  # return 代表傳回的數值或資料
  return(twd)
}