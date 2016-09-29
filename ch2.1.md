## R console 及指令稿執行

R 一開啟的時候會出現類似[終端機](https://zh.wikipedia.org/wiki/終端)的介面顯示，
如下圖 2-1 所示，

![R Console](img/ch1_r_console.png)
圖 2-1、R console (這裡以 RStudio 為例)

圖 2-1 是使用 RStudio 開啟 R console。上半部顯示 R 的版本、平台(platform)、
版權的宣告及相關資訊等。最下面有個大於(>)符號，後方游標閃爍，
在這個「大於」符號後面是接受輸入命令區，你可以在這邊輸入 R 的指令。
在解釋 R console 使用之前，先解釋電腦程式語言的兩大類群，分別為編譯式語言(compiled language)及直譯式語言(interpreted language)。編譯式語言需要透過[編譯器(compiler)](https://zh.wikipedia.org/wiki/編譯器)把程式碼翻譯成機器能懂得二進位碼，而直譯式語言則直接在直譯器中輸入程式碼即可。R 語言就是一種直譯式的語言，只要把指令輸入在 R console 中，R 就會直接執行不需要額外再透過編譯器。

在 R console 中，隨時都可以接受指令的輸入，原則上 R 會一行一行的執行，
你可以把這裡當成計算機，例如你可以試著輸入 $$ 3 \times 128 $$
(相乘使用 「*」符號)。

```R
> 3 * 128
[1] 384
```

另外在你輸入有關函式(function)的指令時，如果沒有加上括號「()」，
R 預設就會把其原始碼在螢幕上印出，例如我們輸入```ls```:

```R
> ls
function (name, pos = -1L, envir = as.environment(pos), all.names = FALSE,
    pattern, sorted = TRUE)
{
    if (!missing(name)) {
    ... 中間省略 ...
            }
        }
        grep(pattern, all.names, value = TRUE)
    }
    else all.names
}
<bytecode: 0x1039a66e0>
<environment: namespace:base>
```

若輸入的指令為 ```ls()``` 時才會正確去執行該函式，即：

```R
> ls()
character(0)
```

