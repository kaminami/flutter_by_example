# grizzly_io_example

Grizzly IOを用いて、TSVからList<Map<String, dynamic>に変換するサンプル。

from:
```tsv
"Name"	"Age"	"House"
"Jon"	"25"	"Stark"
"Dany"	"28"	"Targaryan"
"Tyrion"	"40"	"Lannister"
"Elia Martell"	"75"	"Martell"
"山田太郎"	"18"	"東京"
```

to:
```List<Map<String, dynamic>
{Name: Jon, Age: 25, House: Stark}
{Name: Dany, Age: 28, House: Targaryan}
{Name: Tyrion, Age: 40, House: Lannister}
{Name: Elia Martell, Age: 75, House: Martell}
{Name: 山田太郎, Age: 18, House: 東京}
```


## 利用ライブラリ

- Grizzly IO
    - https://pub.dev/packages/grizzly_io
    - https://github.com/Grizzly-dart/grizzly_io

![image](https://user-images.githubusercontent.com/859822/222242609-531d7ed3-f80c-42ec-b8c8-02a5f44e5e88.png)
※列の並びはTSV定義から変更している。
