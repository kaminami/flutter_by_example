# state_restoration_example

アプリ起動時およびアプリ復帰時にカウンターの値を取り出して復元するサンプルアプリ。

## 開発時に利用するコマンド

- reverpod_generatorによるProviderクラス生成に利用する。

```bash
# build_runnerの実行
flutter pub run build_runner build --delete-conflicting-outputs
```

## 備考

- アプリ起動時に前回までのカウンター値を'0'としたかったが、アプリ起動時に1回だけ初期化処理を実行させる方法に行き当たらなかった
  - detached後の復帰で初期化処理を実行しない方法?


https://user-images.githubusercontent.com/859822/220511649-02846a91-1e39-4439-ab31-6a16f5f08790.mp4

