import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:how_much/analysis/component/history_card.dart';

import '../../common/layout/default_layout.dart';
import '../../common/util/error_handler.dart';
import '../provider/analysis_history_provider.dart';

class AnalysisHistoryScreen extends ConsumerWidget {
  const AnalysisHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyState = ref.watch(analysisHistoryProvider);

    return DefaultLayout(
      title: '과거 분석 기록',
      child: historyState.when(
        data: (analyses) => analyses.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.history_outlined,
                      size: 48,
                      color: Colors.grey[400],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      '분석 기록이 없습니다',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.grey[600],
                          ),
                    ),
                  ],
                ),
              )
            : ListView.separated(
                physics: AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16),
                itemCount: analyses.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  final analysis = analyses[index];
                  return HistoryCard.fromModel(model: analysis);
                },
              ),
        error: (error, _) => ErrorHandler.errorWidget(error.toString()),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
