import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../model/analysis_model.dart';
import '../repository/analysis_repository.dart';

part 'analysis_history_provider.g.dart';

@Riverpod(keepAlive: true)
class AnalysisHistory extends _$AnalysisHistory {
  @override
  FutureOr<List<AnalysisModel>> build() async {
    final repository = ref.read(analysisRepositoryProvider.notifier);
    return repository.getAnalyses();
  }

  Future<void> addAnalysis(AnalysisModel analysis) async {
    state = const AsyncValue.loading();
    try {
      final repository = ref.read(analysisRepositoryProvider.notifier);
      await repository.createAnalysis(analysis);

      final updatedList = [analysis, ...?state.value];
      state = AsyncValue.data(updatedList);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> refreshAnalyses() async {
    state = const AsyncValue.loading();
    try {
      final repository = ref.read(analysisRepositoryProvider.notifier);
      final analyses = await repository.getAnalyses();
      state = AsyncValue.data(analyses);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  AnalysisModel? getLastAnalysis() {
    if (state case AsyncData(value: final analyses)) {
      return analyses.isNotEmpty ? analyses.first : null;
    }
    return null;
  }
}
