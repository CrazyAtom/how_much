import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'state_restoration_provider.g.dart';

@riverpod
class StateRestoration extends _$StateRestoration {
  @override
  StateRestoration build() {
    return this;
  }

  Future<void> restoreState() async {
    // 앱 재시작시 상태 복원 로직
  }
}