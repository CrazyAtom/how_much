import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'config_provider.g.dart';

@riverpod
class AppConfig extends _$AppConfig {
  @override
  AppConfigModel build() {
    return AppConfigModel(
      environment:
          const String.fromEnvironment('ENVIRONMENT', defaultValue: 'dev'),
    );
  }
}

class AppConfigModel {
  final String environment;

  AppConfigModel({required this.environment});
}
