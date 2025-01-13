import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:how_much/common/provider/error_provider.dart';

extension ErrorSnackBarExtension on WidgetRef {
  void listenError(BuildContext context) {
    listen<String?>(
      errorNotifierProvider,
      (previous, next) {
        if (next != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(next),
              backgroundColor: Theme.of(context).primaryColor,
              behavior: SnackBarBehavior.floating,
              action: SnackBarAction(
                label: '확인',
                textColor: Colors.white,
                onPressed: () {
                  read(errorNotifierProvider.notifier).clearError();
                },
              ),
            ),
          );
        }
      },
    );
  }
}
