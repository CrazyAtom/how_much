import 'package:flutter/material.dart';
import 'package:how_much/analysis/model/analysis_result_model.dart';
import 'package:how_much/common/component/card/custom_card.dart';
import 'package:how_much/common/component/card/expandable_card_section.dart';
import 'package:how_much/common/component/chart/chart_section_header.dart';
import 'package:how_much/common/component/chart/progress_indicator_bar.dart';

class MarketOutlookSection extends StatelessWidget {
  final MarketOutlookModel data;

  const MarketOutlookSection({
    required this.data,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ExpandableCardSection(
      title: '시장 전망',
      children: [
        _buildPriceTrends(data.priceTrends),
        const Divider(),
        _buildMarketFactors(data.marketFactors),
      ],
    );
  }

  Widget _buildPriceTrends(PriceTrendsModel trends) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ChartSectionHeader(title: '가격 추세'),
        _buildTrendItem('현재', trends.currentTrend),
        _buildTrendItem('30일 후', trends.next30Days),
        _buildTrendItem('90일 후', trends.next90Days),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text('사유: ${trends.reason}'),
        ),
      ],
    );
  }

  Widget _buildTrendItem(String period, String trend) {
    IconData icon;
    Color color;

    switch (trend) {
      case '상승':
        icon = Icons.trending_up;
        color = Colors.red;
        break;
      case '하락':
        icon = Icons.trending_down;
        color = Colors.blue;
        break;
      default:
        icon = Icons.trending_flat;
        color = Colors.grey;
    }

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(period),
      trailing: Text(
        trend,
        style: TextStyle(color: color, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildMarketFactors(MarketFactorsModel factors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ChartSectionHeader(title: '시장 영향 요인'),
        ProgressIndicatorBar(
          label: '수요',
          value: factors.demandLevel,
          progress: _getLevelValue(factors.demandLevel),
          color: _getLevelColor(factors.demandLevel),
        ),
        ProgressIndicatorBar(
          label: '공급',
          value: factors.supplyLevel,
          progress: _getLevelValue(factors.supplyLevel),
          color: _getLevelColor(factors.supplyLevel),
        ),
        const SizedBox(height: 16),
        _buildSeasonalEffect(factors.seasonalEffect),
        const SizedBox(height: 16),
        _buildMarketEvents(factors.marketEvents),
      ],
    );
  }

  Widget _buildSeasonalEffect(String effect) {
    return CustomCard(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '계절적 요인',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(effect),
          ],
        ),
      ),
    );
  }

  Widget _buildMarketEvents(List<MarketEventModel> events) {
    return CustomCard(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '주요 시장 이벤트',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            ...events.map((event) {
              final bool isPositive = event.impact == '긍정';
              return CustomCard(
                child: ListTile(
                  leading: Icon(
                    isPositive ? Icons.trending_up : Icons.trending_down,
                    color: isPositive ? Colors.green : Colors.red,
                  ),
                  title: Text(event.event),
                  trailing: Chip(
                    label: Text(
                      event.impact,
                      style: TextStyle(
                        color: isPositive ? Colors.green : Colors.red,
                      ),
                    ),
                    backgroundColor: isPositive
                        ? Colors.green.withOpacity(0.1)
                        : Colors.red.withOpacity(0.1),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Color _getLevelColor(String level) {
    switch (level.toLowerCase()) {
      case '높음':
        return Colors.red;
      case '중간':
        return Colors.orange;
      case '낮음':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  double _getLevelValue(String level) {
    switch (level.toLowerCase()) {
      case '높음':
        return 1.0;
      case '중간':
        return 0.6;
      case '낮음':
        return 0.3;
      default:
        return 0.0;
    }
  }
}
