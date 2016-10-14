## 檔案的輸入

把外部資料輸入進 R 的時候，可使用 csv (逗號分隔檔案)或是
txt 資料表的格式。如果你習慣使用 Microsoft Excel 的話，也可以安裝
```xlsx``` 這個套件來讀取 Excel 的檔案格式。

假設我們有個資料表需要輸入進 R 分析，這個資料表長得像這樣：

| id  |  plot  |  species  |  cover  |
| --: | ------ | --------- | ------: |
|  1  |  A01   |  A        |   5     |
|  2  |  A01   |  B        |  10     |
|  3  |  A02   |  A        |   1     |
|  4  |  A02   |  C        |   2     |
|  5  |  A02   |  D        |   3     |
|  6  |  A02   |  E        |  15     |
|  7  |  A03   |  F        |  25     |
|  8  |  A04   |  F        |  10     |
|  9  |  A04   |  G        |   5     |
| 10  |  A05   |  A        |   1     |
| 11  |  A05   |  E        |   1     |
| 12  |  A05   |  F        |   1     |
| 13  |  A06   |  A        |   1     |
| 14  |  A07   |  A        |   1     |
| 15  |  A07   |  B        |   1     |
| 16  |  A07   |  C        |   5     |
| 17  |  A08   |  C        |  10     |
| 18  |  A08   |  D        |   1     |
| 19  |  A08   |  G        |   2     |
| 20  |  A08   |  H        |   1     |

原始資料的樣貌(csv 檔案請參見 ```examples/ch1_r_project/data/datainput_example.csv```):

```
id,plot,species,cover
1,A01,A,5
2,A01,B,10
3,A02,A,1
4,A02,C,2
5,A02,D,3
6,A02,E,15
7,A03,F,25
8,A04,F,10
9,A04,G,5
10,A05,A,1
11,A05,E,1
12,A05,F,1
13,A06,A,1
14,A07,A,1
15,A07,B,1
16,A07,C,5
17,A08,C,10
18,A08,D,1
19,A08,G,2
20,A08,H,1
```


總共有 20 筆資料，四個欄位，第一列(row)是欄位的名稱。
在把資料輸入進 R 時，記得要先使用 Excel 或是 LibreOffice 看一下，
因為有些資料可能沒有清理乾淨(例如分隔符號不統一、空白行、空白欄位等)。
讀取資料時，也有可能碰到編碼的問題，例如 Windows 都用 Big5 編碼，
碰到 Unicode (萬國碼，通常是 UTF-8)的資料時會出現錯誤亂碼等。
這些問題我們先略過不提，在「資料清理」的部份會再詳細解說。

讀取資料使用 ```read.table()``` 或是 ```read.csv()```:

```R
# 在讀資料之前，請先確定資料的位置
# 是絕對路徑或是相對路徑，例如在 Windows 中
# "C:\Users\User\Desktop\data\example.csv" 是絕對路徑
# "data\example.csv" 是相對路徑
> rawdata <- read.csv('data/datainput_example.csv')
```

常用的參數有 ```header``` (欄位名稱的有無)、```sep```(分隔符號)、
```na.strings``` (沒有資料的字串，例如 -9999)、```skip``` (省略的行數)等。
例如預設讀入 csv 時，會把第一列當成欄位名稱，若你的資料中沒有欄位名稱，
就可以使用 ```header=FALSE``` 來關掉讀取第一列當成欄位名稱。
分隔符號則是當你在讀取以 Tab、pipeline (|) 所需要輸入的符號，
例如以 Tab 分隔，參數則為 ```sep = "\t"``` (```\t``` 代表 Tab 鍵)。
另外還有個常用的是編碼(encodings)，如果編碼是 unicode，
參數為```encoding = "UTF-8"```。

### 大檔案的讀取

不管你是使用 ```read.table()``` 或是 ```read.csv()``` 等輸入指令，
碰到大檔案的時候，我會建議使用 ```data.table``` 套件底下的
```fread()``` 來讀取資料。舉例來說，有個 csv 檔案約 20 MB，
如果使用 ```read.csv()``` 來讀取大概要 3.4 秒：

```R
# proc.time() 來取得計算的時間
> ptm <- proc.time()
>   a_csvread <- read.csv('data/testdata.csv')
> proc.time() - ptm
   user  system elapsed
  3.438   0.086   3.695
```
但如果使用 ```fread()```，則只需要 0.132 秒。

```R
> ptm <- proc.time()
>    a_fread <- fread('data/testdata.csv')
> proc.time() - ptm
   user  system elapsed
  0.132   0.015   0.452
```

因此當你如果有讀取大檔案的需求，請使用 ```fread()```
來讀取檔案。


## 檔案的輸出

和 ```read.csv``` 相同，有 read 就有 write，例如：

```R
> write.csv(x, 'file/path/to/output/file.csv', row.names = FALSE)
```

```write.csv()``` 預設會輸出列數，若你沒有這個需求的話，
可以把它關閉(```row.names=FALSE```)。
