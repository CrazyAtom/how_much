import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'auth_provider.dart';

part 'auth_refresh_provider.g.dart';

@riverpod
class AuthRefresh extends _$AuthRefresh implements Listenable {
  VoidCallback? _listener;

  @override
  bool build() {
    ref.listen(authProvider, (previous, next) {
      _listener?.call();
    });
    return false;
  }

  @override
  void addListener(VoidCallback listener) {
    _listener = listener;
  }

  @override
  void removeListener(VoidCallback listener) {
    _listener = null;
  }

  String? authRedirect(GoRouterState state) {
    final authState = ref.read(authProvider);

    if (authState.isLoading) {
      return '/splash';
    }

    final isAuth = authState.valueOrNull != null;

    if (state.uri.toString() == '/') {
      return '/splash';
    }

    if (state.uri.toString() == '/splash') {
      return isAuth ? '/home' : '/login';
    }

    if (!isAuth && state.uri.toString() != '/login') {
      return '/login';
    }

    if (isAuth && state.uri.toString() == '/login') {
      return '/home';
    }

    return null;
  }
}
