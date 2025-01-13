import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../common/provider/error_provider.dart';
import '../model/user_model.dart';
import '../repository/auth_repository.dart';

part 'auth_provider.g.dart';

@riverpod
class Auth extends _$Auth {
  AuthRepository get _authRepository =>
      ref.read(authRepositoryProvider.notifier);
  ErrorNotifier get _errorNotifier => ref.read(errorNotifierProvider.notifier);

  @override
  FutureOr<UserModel?> build() async {
    return _authRepository.autoSignIn();
  }

  Future<void> signInAnonymously() async {
    if (state is AsyncLoading) return;

    state = const AsyncValue.loading();
    try {
      final user = await _authRepository.signInAnonymously();
      state = AsyncValue.data(user);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
      _errorNotifier.setError(e.toString());
    }
  }

  Future<void> autoSignIn() async {
    state = const AsyncValue.loading();
    try {
      final user = await _authRepository.autoSignIn();
      state = AsyncValue.data(user);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
      _errorNotifier.setError(e.toString());
    }
  }

  Future<void> signOut() async {
    try {
      await _authRepository.signOut();
      state = const AsyncValue.data(null);
    } catch (e) {
      _errorNotifier.setError(e.toString());
    }
  }

  Future<void> reset() async {
    state = const AsyncValue.data(null);
  }
}
