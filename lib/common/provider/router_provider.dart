import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:how_much/analysis/view/product_analysis_result_screen.dart';
import 'package:how_much/analysis/view/product_strategy_screen.dart';
import 'package:how_much/auth/provider/auth_refresh_provider.dart';
import 'package:how_much/auth/view/login_screen.dart';
import 'package:how_much/common/view/root_tab.dart';
import 'package:how_much/common/view/splash_screen.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router_provider.g.dart';

@riverpod
GoRouter router(Ref ref) {
  final authRefresh = ref.watch(authRefreshProvider.notifier);

  return GoRouter(
    initialLocation: '/',
    refreshListenable: authRefresh,
    redirect: (_, state) => authRefresh.authRedirect(state),
    routes: [
      GoRoute(
        path: '/splash',
        name: SplashScreen.routeName,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/login',
        name: LoginScreen.routeName,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/home',
        name: RootTab.routeName,
        builder: (context, state) => const RootTab(),
        routes: [
          GoRoute(
            path: 'analysis_result',
            name: ProductAnalysisResultScreen.routeName,
            builder: (_, state) => const ProductAnalysisResultScreen(),
            routes: [
              GoRoute(
                path: 'sales_strategy',
                name: ProductStrategyScreen.routeName,
                builder: (_, state) => const ProductStrategyScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
