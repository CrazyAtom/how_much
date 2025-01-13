import 'package:flutter_riverpod/flutter_riverpod.dart';

mixin ProviderMixin {
  late final ProviderRef ref;

  void initState(ProviderRef ref) {
    this.ref = ref;
  }

  void dispose() {}
}
