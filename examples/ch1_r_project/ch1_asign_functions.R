# 匯率換算

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