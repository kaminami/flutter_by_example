import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'counter_state.g.dart';

@Riverpod(keepAlive: true)
class CounterState extends _$CounterState {
  @override
  int build() {
    return 0;
  }

  void increment() {
    state += 1;
  }
}