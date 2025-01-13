import 'package:logger/logger.dart';

final logger = Logger();

enum StorageKeys {
  userUid('user_uid');

  final String key;
  const StorageKeys(this.key);
}

enum GeminiModel {
  geminiFlash('gemini-1.5-flash-latest'),
  geminiFlash8b('gemini-1.5-flash-8b-latest'),
  geminiPro('gemini-1.5-pro-latest');

  final String value;
  const GeminiModel(this.value);
}

enum Condition {
  newCondition('새제품'),
  almostNewCondition('거의 새것'),
  usedCondition('중고'),
  damagedCondition('하자있음');

  final String label;
  const Condition(this.label);
}
