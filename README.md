


1-1-1 請列出您所使用的系統、版本，再列出與 bash 有關的版本、檔案、路徑、組態、文件。

```bash
# 列出所使用的系統、版本
user@user-virtual-machine:~$ uname -a
Linux user-virtual-machine 5.13.0-28-generic #31~20.04.1-Ubuntu SMP Wed Jan 19 14:08:10 UTC 2022 x86_64 x86_64 x86_64 GNU/Linux

# 列出與 bash 有關的版本
user@user-virtual-machine:~$ /bin/bash --version
GNU bash，版本 5.0.17(1)-release (x86_64-pc-linux-gnu)
Copyright (C) 2019 Free Software Foundation, Inc.
授權條款 GPLv3+: GNU GPL 授權條款第三版或者更新版本 <http://gnu.org/licenses/gpl.html>

本軟體是自由軟體，您可以自由地變更和重新發布。
在法律許可的情況下特此明示，本軟體不提供任何擔保。

# 列出與 bash 有關的檔案、路徑、組態、文件
user@user-virtual-machine:~$ whereis bash
bash: /usr/bin/bash /etc/bash.bashrc /usr/share/man/man1/bash.1.gz
```


1-1-4 請試說明 type 指令以何方式判別為內或外部指令。

>用是否使用執行檔判斷，通常在bin底下。


1-1-10 請說明五個於 env中的環境變數以及用途。

>
SHELL：當前使用者用的是哪種Shell
LANGUGE：和語言相關的環境變數，使用多種語言的使用者可以修改此環境變數
LOGNAME：指當前使用者的登入名
HOME：指定使用者的主工作目錄（即使用者登陸到Linux系統中時，預設的目錄）
PATH：指定命令的搜尋路徑


1-2-5 請說明 Shell Script 第一行 ( #!/bin/bash ) 意義與辨識方式。

>
第一行的 `#!` 是對指令碼的直譯器程式路徑



1-2-10 請試說明並舉例其它課堂未說明之 EXIT Code。

[ExitCodesWithSpecialMeanings.md](./assets/ExitCodesWithSpecialMeanings.md)

| Exit Code Number | Meaning | Example | Comments |
| --- | --- | --- | --- |
| 1 | Catchall for general errors | let "var1 = 1/0" | Miscellaneous errors, such as "divide by zero" and other impermissible operations |
| 2 | Misuse of shell builtins (according to Bash documentation) | empty\_function() {} | [Missing keyword](chrome-extension://cjedbglnccaioiolemnfhjncicchinao/debugging.html#MISSINGKEYWORD) or command, or permission problem (and [_diff_ return code on a failed binary file comparison](chrome-extension://cjedbglnccaioiolemnfhjncicchinao/filearchiv.html#DIFFERR2)). |
| 126 | Command invoked cannot execute | /dev/null | Permission problem or command is not an executable |
| 127 | "command not found" | illegal\_command | Possible problem with $PATH or a typo |
| 128 | Invalid argument to [exit](chrome-extension://cjedbglnccaioiolemnfhjncicchinao/exit-status.html#EXITCOMMANDREF) | exit 3.14159 | **exit** takes only integer args in the range 0 - 255 (see first footnote) |
| 128+n | Fatal error signal "n" | _kill -9_ $PPID of script | **$?** returns 137 (128 + 9) |
| 130 | Script terminated by Control-C | _Ctl-C_ | Control-C is fatal error signal 2, (130 = 128 + 2, see above) |
| 255\* | Exit status out of range | exit \-1 | **exit** takes only integer args in the range 0 - 255 |



1-2-14 請說明管線「 |  」功能並舉例。

管線命令的使用方式是透過 `|` 這個符號來連結前一個命令的輸出和下一個命令的輸入。如下 :
```
[command1] | [command2] | [command3] | ...
```
所以 `command2` 會處理 `command1` 所傳進來的資料，而 `command3` 會再處理 `command2` 傳進來的資料，以此類推。



2-1-12、2-1-13、2-1-14、2-1-15、2-1-16

[printPic.sh](./assets/printPic.sh)
```bash

user@user-virtual-machine:~$ bash printPic.sh
ParameterNums=[0] 參數數量錯誤
 Purpose: Print picture
 Usage: bash printPic.sh [印出項目] [寬度<1~20>]
  exp1: bash printPic.sh 2-1-12 5
  exp2: bash printPic.sh 2-1-13 6
  exp3: bash printPic.sh 2-1-14 7
  exp4: bash printPic.sh 2-1-15 8
  exp5: bash printPic.sh 2-1-16 9
[retcode=1101]
user@user-virtual-machine:~$ bash printPic.sh 2-1-12 5
        SH1001_start 2022-02-09 16:11:40
* * * * *
* * * *
* * *
* *
*

        SH1001_end 2022-02-09 16:11:40
        SH1001_執行時間:0分0秒
[retcode=0]
user@user-virtual-machine:~$ bash printPic.sh 2-1-13 6
        SH1001_start 2022-02-09 16:11:46
          *
        * *
      * * *
    * * * *
  * * * * *
* * * * * *

        SH1001_end 2022-02-09 16:11:46
        SH1001_執行時間:0分0秒
[retcode=0]
user@user-virtual-machine:~$ bash printPic.sh 2-1-14 7
        SH1001_start 2022-02-09 16:11:52
* * * * * * *
*           *
*           *
*           *
*           *
*           *
* * * * * * *

        SH1001_end 2022-02-09 16:11:52
        SH1001_執行時間:0分0秒
[retcode=0]
user@user-virtual-machine:~$ bash printPic.sh 2-1-15 8
        SH1001_start 2022-02-09 16:11:57
* * * * * * * *
  * * * * * *
    * * * *
      * *
    * * * *
  * * * * * *
* * * * * * * *


        SH1001_end 2022-02-09 16:11:57
        SH1001_執行時間:0分0秒
[retcode=0]
user@user-virtual-machine:~$ bash printPic.sh 2-1-16 9
        SH1001_start 2022-02-09 16:12:02
        *
      * * *
    * * * * *
  * * * * * * *
* * * * * * * * *
  * * * * * * *
    * * * * *
      * * *
        *

        SH1001_end 2022-02-09 16:12:02
        SH1001_執行時間:0分0秒
[retcode=0]


```



2-2-3 舉三個例子使用 %* 或 %%* 於系統中的應用，並說明之。

>
1.分析出網域
2.檔案路徑
3.分析居住位置



2-2-7 使用 shell 的呼叫並傳遞身高、體重參數計算身體質量指數 ( BMI ) 評估程式。

[SH1002.sh](./assets/SH1002.sh)
[SH1002_BMI.sh](./assets/SH1002_BMI.sh)

```bash

user@user-virtual-machine:~$ bash SH1002.sh
ParameterNums=[0] 參數數量錯誤
 Purpose: Print BMI
 Usage: bash SH1002.sh [身高(cm)] [體重(kg)]
  exp1: bash SH1002.sh 180 80
[retcode=1101]
user@user-virtual-machine:~$ bash SH1002.sh 180.5 69.6
        SH1002_start 2022-02-15 10:59:42
身高 180.5 cm
體重 69.6 kg
BMI 21.48
18.5-24.0    | 標準

        SH1002_end 2022-02-15 10:59:42
        SH1002_執行時間:0分0秒
[retcode=0]



```


2-2-8 使用 shell 的呼叫並傳遞參數設計男、女鞋碼對照程式 ( JP、US、UK、TW、KR、CN )。

[SH1003.sh](./assets/SH1003.sh)
[SH1003_shoe.sh](./assets/SH1003_shoe.sh)
[SH1003_shoe_F.data](./assets/SH1003_shoe_F.data)
[SH1003_shoe_M.data](./assets/SH1003_shoe_M.data)

```bash
user@user-virtual-machine:~$ bash SH1003.sh
ParameterNums=[0] 參數數量錯誤
 Purpose: Print shoe
 Usage: bash SH1003.sh [性別<m|f>] [鞋碼種類<us|gb|eu|jp|tw>] [尺寸]
  exp1: bash SH1003.sh m us 10.5
  exp2: bash SH1003.sh f eu 40
  exp3: bash SH1003.sh m gb 10.5
[retcode=1101]
user@user-virtual-machine:~$ bash SH1003.sh f eu 40
        SH1003_start 2022-02-16 18:28:14
🇺🇸美國 : 7
🇬🇧英國 : 6.5
🇪🇺歐洲 : 40
🇯🇵日本 : 25
🇹🇼台灣 : 82

        SH1003_end 2022-02-16 18:28:14
        SH1003_執行時間:0分0秒
[retcode=0]

```

3-1-1 請修改 while2nl.sh，輸入檔名時可以檢查當案是  否存在，不存時在應輸出錯誤提示並停止執行。

[while2nl_fix.sh](./assets/while2nl_fix.sh)

```bash
user@user-virtual-machine:~$ bash while2nl_fix.sh
Please enter File-Name:while2nl_fix.sh
         1 #!/bin/bash
         2 #Description: Use the loop (while) to simulate "nl" command.
         3 #Write by 350 (weilin.jang@gmail.com)
         4 #Version: v1.00
         5
         6 read -p "Please enter File-Name:" varFileName
         7 [ ! -f $varFileName ] && { echo "$varFileName file not found"; exit 99; }
         8
         9 noLine=1
         10
         11 while read txtLine
         12 do
         13 echo -e "t $noLine $txtLine"
         14 let noLine=$noLine+1
         15 done < $varFileName
         16
         17 exit 0
user@user-virtual-machine:~$ bash while2nl_fix.sh
Please enter File-Name:345
345 file not found
```


3-1-2 請以 while 與 for 寫印出一個九九成法表。

[SH1004.sh](./assets/SH1004.sh)

```bash
user@user-virtual-machine:~$ bash SH1004.sh
        SH1004_start 2022-02-17 10:10:56
1 * 1 = 1       2 * 1 = 2       3 * 1 = 3
1 * 2 = 2       2 * 2 = 4       3 * 2 = 6
1 * 3 = 3       2 * 3 = 6       3 * 3 = 9
1 * 4 = 4       2 * 4 = 8       3 * 4 = 12
1 * 5 = 5       2 * 5 = 10      3 * 5 = 15
1 * 6 = 6       2 * 6 = 12      3 * 6 = 18
1 * 7 = 7       2 * 7 = 14      3 * 7 = 21
1 * 8 = 8       2 * 8 = 16      3 * 8 = 24
1 * 9 = 9       2 * 9 = 18      3 * 9 = 27

4 * 1 = 4       5 * 1 = 5       6 * 1 = 6
4 * 2 = 8       5 * 2 = 10      6 * 2 = 12
4 * 3 = 12      5 * 3 = 15      6 * 3 = 18
4 * 4 = 16      5 * 4 = 20      6 * 4 = 24
4 * 5 = 20      5 * 5 = 25      6 * 5 = 30
4 * 6 = 24      5 * 6 = 30      6 * 6 = 36
4 * 7 = 28      5 * 7 = 35      6 * 7 = 42
4 * 8 = 32      5 * 8 = 40      6 * 8 = 48
4 * 9 = 36      5 * 9 = 45      6 * 9 = 54

7 * 1 = 7       8 * 1 = 8       9 * 1 = 9
7 * 2 = 14      8 * 2 = 16      9 * 2 = 18
7 * 3 = 21      8 * 3 = 24      9 * 3 = 27
7 * 4 = 28      8 * 4 = 32      9 * 4 = 36
7 * 5 = 35      8 * 5 = 40      9 * 5 = 45
7 * 6 = 42      8 * 6 = 48      9 * 6 = 54
7 * 7 = 49      8 * 7 = 56      9 * 7 = 63
7 * 8 = 56      8 * 8 = 64      9 * 8 = 72
7 * 9 = 63      8 * 9 = 72      9 * 9 = 81


        SH1004_end 2022-02-17 10:10:56
        SH1004_執行時間:0分0秒
[retcode=0]
```


3-1-14 請寫一身分證字號驗證程式 (驗證英文、性別與檢查碼，需使用 function, 傳值, return)。

[SH1005.sh](./assets/SH1005.sh)

```bash
user@user-virtual-machine:~$ bash SH1005.sh
ParameterNums=[0] 參數數量錯誤
 Purpose: verify ID card
 Usage: bash SH1005.sh [身分證字號]
  exp1: bash SH1005.sh A123456789
  exp2: bash SH1005.sh K233265200
[retcode=1101]
user@user-virtual-machine:~$ bash SH1005.sh dfdsf
身分證字號=[dfdsf] 請輸入正確的身分證字號
 Purpose: verify ID card
 Usage: bash SH1005.sh [身分證字號]
  exp1: bash SH1005.sh A123456789
  exp2: bash SH1005.sh K233265200
[retcode=1102]
user@user-virtual-machine:~$ bash SH1005.sh A123456789
        SH1005_start 2022-02-17 20:23:39
戶籍地=[台北市]
性別=[男]
身分證格式驗證正確

        SH1005_end 2022-02-17 20:23:39
        SH1005_執行時間:0分0秒
[retcode=0]
user@user-virtual-machine:~$ bash SH1005.sh K233265200
        SH1005_start 2022-02-17 20:23:45
戶籍地=[苗栗縣]
性別=[女]
身分證格式驗證正確

        SH1005_end 2022-02-17 20:23:45
        SH1005_執行時間:0分0秒
[retcode=0]


```




3-2-13 請舉三個指令可以列出系統資源的指令並說明。

>
`top` : 查詢工作使用的資源(工作管理員)
`free` : 查詢記憶體的使用
`df` : 查詢硬碟的使用

3-2-15 請舉三個指令可以處理文字檔案的指令並說明。

>
`grep` : 文字搜尋
`cut` : 按列切分文字
`sed` : 文字替換



3-2-16 請舉三個指令可以詢問網路資源的指令並說明。
>
`ifconfig` : 查詢/修改 網路介面
`route` : 顯示 / 修改路由表
`nslookup` : 查詢主機名稱與ip對應




**online**
---

[this](https://github.com/rockexe0000/shell-script)







