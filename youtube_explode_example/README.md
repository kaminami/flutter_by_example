YoutubeExplodeDartを利用したYouTubeデータ取得例

# youtube_explode_dart
- https://pub.dev/packages/youtube_explode_dart
- YouTubeサイトをクロールしてチャンネル、動画等のデータを取得する
  - サイトに負荷をかけるので実行は程々に

# 取得例の実行
```
dart ./bin/youtube_explode_example.dart
```

# 備考
- lib/youtube_explode_example
  - retrieveChannelData
    - channelIdを指定し、YouTubeChannelの各種情報を取得
  - retrieveChannelVideoDataList
    - channelIdを指定し、チャンネルに投稿されたYouTubeVideoの一覧を取得
    - retrieveVideoDataの場合よりも、取得できる情報が少ない(publishDate, views等の情報が意図的に削られている)
  - retrieveVideoData
    - videoIdを指定し、YouTubeVideoの各種情報を取得
