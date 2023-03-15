import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'connectivity_state.g.dart';

@riverpod
class ConnectivityState extends _$ConnectivityState {
  StreamSubscription<ConnectivityResult>? subscription;

  @override
  FutureOr<ConnectivityResult> build() async {
    subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      print("$runtimeType, onConnectivityChanged, $result");
      state = AsyncValue.data(result);
    });

    final ConnectivityResult res = await Connectivity().checkConnectivity();
    return res;
  }
}
