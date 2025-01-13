import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:how_much/analysis/provider/analysis_provider.dart';
import 'package:how_much/analysis/view/section/basic_info_section.dart';
import 'package:how_much/analysis/view/section/market_outlook_section.dart';
import 'package:how_much/analysis/view/section/price_analysis_section.dart';
import 'package:how_much/analysis/view/section/reliability_metrics_section.dart';
import 'package:how_much/analysis/view/section/trade_trends_section.dart';
import 'package:how_much/common/layout/default_layout.dart';

class ProductAnalysisResultScreen extends ConsumerWidget {
  static String get routeName => 'analysis_result';

  const ProductAnalysisResultScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.read(analysisProvider.notifier).getCurrentAnalysis();
    final analysis = model?.analysisResult;
    if (analysis == null) {
      return const Center(child: Text('분석 결과가 없습니다.'));
    }

    if (analysis.basicInfo.productName.isEmpty) {
      return const DefaultLayout(
        title: '분석 실패',
        child: Center(
          child: Text('분석에 실패했습니다. 다시 시도해주세요.'),
        ),
      );
    }

    return DefaultLayout(
      title: '${analysis.basicInfo.productName} 분석결과',
      child: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 24.0,
            ),
            children: [
              BasicInfoSection(data: analysis.basicInfo),
              const SizedBox(height: 24),
              PriceAnalysisSection(data: analysis.priceAnalysis),
              const SizedBox(height: 24),
              TradeTrendsSection(data: analysis.tradeTrends),
              const SizedBox(height: 24),
              MarketOutlookSection(data: analysis.marketOutlook),
              const SizedBox(height: 24),
              ReliabilityMetricsSection(data: analysis.reliabilityMetrics),
              // 하단 버튼을 위한 여백
              const SizedBox(height: 80),
            ],
          ),
          Positioned(
            left: 16,
            right: 16,
            bottom: 24,
            child: ElevatedButton(
              onPressed: () {
                context.go(
                  '/home/analysis_result/sales_strategy',
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                backgroundColor: Theme.of(context).primaryColor,
              ),
              child: const Text(
                '판매 전략 보기',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
