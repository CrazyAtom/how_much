import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:how_much/common/config/config.dart';
import 'package:how_much/common/const/data.dart';
import 'package:how_much/common/provider/router_provider.dart';
import 'package:how_much/common/theme/app_theme.dart';
import 'package:how_much/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    logger.e('Firebase initialization failed: $e');
  }

  try {
    final env = String.fromEnvironment('ENV', defaultValue: 'development');
    await Config.initializeForEnvironment(env);
  } catch (e) {
    logger.e('initialization failed: $e');
  }

  runApp(
    const ProviderScope(
      child: _App(),
    ),
  );
}

class _App extends ConsumerWidget {
  const _App();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      theme: AppTheme.lightTheme,
      // darkTheme: AppTheme.darkTheme,
    );
  }
}
