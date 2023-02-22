# state_restoration_example

state_restoration_example

## 開発時に利用するコマンド

- reverpod_generatorによるImmutableクラス生成に利用する。

```bash
# build_runnerの実行
flutter pub run build_runner build --delete-conflicting-outputs
```

## 備考

- アプリ起動時およびアプリ復帰時、shared_preferencesからカウンターの値を取り出して復元するようにした
- アプリ起動時に前回までのカウンター値を'0'としたかったが、アプリ起動時に1回だけ初期化処理を実行させる方法に行き当たらなかった
  - detached後の復帰で初期化処理を実行しない方法?
