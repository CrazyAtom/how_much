import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../component/error_display.dart';
import '../provider/error_provider.dart';

class ErrorHandler {
  static void showError(WidgetRef ref, String message) {
    ref.read(errorNotifierProvider.notifier).setError(message);
  }

  static Widget errorWidget(String? error) {
    if (error == null) return const SizedBox.shrink();
    return ErrorDisplay(message: error);
  }
}
