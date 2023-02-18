# youtube_player_iframe_example

YouTubeプレーヤーを組み込んだだけの、シンプルなFlutterアプリの実装例。

## 利用ライブラリ

- youtube_player_iframe
    - https://pub.dev/packages/youtube_player_iframe
    - https://github.com/sarbagyastha/youtube_player_flutter

## 備考

アプリ組み込みには、youtube_player_iframeを使用するのがよい。
youtube_player_flutterよりも、軽さ、安定感を感じる振る舞いである。

- フルスクリーン時の振る舞いには、特に違和感なし
- エミュレータ上で動作させた場合はときおり再生箇所がとぶなど、動作が重く、使いづらい印象だったが、Android実機での動作には特に問題を感じなかった
- youtube_player_flutterパッケージを使用した場合よりも、画質がよい
- youtube_player_flutterパッケージを使用した場合よりも、デフォルト提供される操作用Widgetが使いやすい
