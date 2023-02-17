# youtube_player_flutter_example

YouTubeプレーヤーを組み込んだだけの、シンプルなFlutterアプリの実装例。

## 利用ライブラリ

- youtube_player_flutter
  - https://pub.dev/packages/youtube_player_flutter
  - https://github.com/sarbagyastha/youtube_player_flutter

## 既知の問題点

FullScreen時に画面の一部がカットされてしまう。

- [BUG] Full Screen in Landscape mode cut the video
    - https://github.com/sarbagyastha/youtube_player_flutter/issues/621
- 対処方法例は示されている。そのうち取り込まれるか？
    - https://github.com/sarbagyastha/youtube_player_flutter/issues/621#issuecomment-1434040824
    - https://github.com/sarbagyastha/youtube_player_flutter/compare/master...peterweb2005:youtube_player_flutter:fullscreen-landscape
