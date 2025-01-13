import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:how_much/analysis/model/analysis_result_model.dart';
import 'package:how_much/common/component/card/custom_card.dart';
import 'package:how_much/common/component/card/expandable_card_section.dart';
import 'package:how_much/common/component/chart/chart_section_header.dart';
import 'package:how_much/common/component/list/info_list_tile.dart';
import 'package:intl/intl.dart';

class TradeTrendsSection extends StatelessWidget {
  final TradeTrendsModel data;

  const TradeTrendsSection({
    required this.data,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ExpandableCardSection(
      title: '거래 동향',
      children: [
        _buildTransactionMetrics(data.transactionMetrics),
        const Divider(),
        _buildPlatformAnalysis(data.platformAnalysis),
        const Divider(),
        _buildOptimalSellingPoints(data.optimalSellingPoints),
      ],
    );
  }

  Widget _buildTransactionMetrics(TransactionMetricsModel metrics) {
    return Column(
      children: [
        const ChartSectionHeader(title: '거래 지표'),
        InfoListTile(
          title: '월간 거래량',
          value: '${metrics.monthlyVolume}건',
        ),
        InfoListTile(
          title: '평균 판매 소요 시간',
          value: '${metrics.averageSaleDuration}일',
        ),
        InfoListTile(
          title: '거래 성사율',
          value: NumberFormat.decimalPercentPattern(decimalDigits: 1)
              .format(metrics.successfulTradeRate / 100),
        ),
      ],
    );
  }

  Widget _buildPlatformAnalysis(List<PlatformAnalysisModel> platforms) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ChartSectionHeader(title: '플랫폼별 거래 현황'),
        SizedBox(
          height: 180,
          child: PieChart(
            PieChartData(
              sections: platforms.map((platform) {
                return PieChartSectionData(
                  value: platform.transactionShare,
                  title:
                      '${platform.platformName}\n${NumberFormat.decimalPercentPattern(decimalDigits: 1).format(platform.transactionShare / 100)}',
                  radius: 80,
                  titleStyle: const TextStyle(fontSize: 10),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOptimalSellingPoints(OptimalSellingPointsModel optimalPoints) {
    final bestPriceRange = optimalPoints.bestPriceRange;
    final bestPeriod = optimalPoints.bestSellingPeriod;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ChartSectionHeader(title: '최적 판매 조건'),
        _buildBestPriceRange(bestPriceRange),
        const SizedBox(height: 16),
        _buildBestSellingPeriod(bestPeriod),
      ],
    );
  }

  Widget _buildBestPriceRange(PriceRangeModel priceRange) {
    return CustomCard(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              '추천 판매가',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${NumberFormat.currency(locale: 'ko_KR', symbol: '₩').format(priceRange.min)} ~ ${NumberFormat.currency(locale: 'ko_KR', symbol: '₩').format(priceRange.max)}',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '예상 거래 성사율: ${NumberFormat.decimalPercentPattern(decimalDigits: 1).format(priceRange.successRate / 100)}',
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBestSellingPeriod(BestSellingPeriodModel period) {
    return CustomCard(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '최적 판매 시기',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            _buildTimingRow(Icons.calendar_today, '계절', period.season),
            _buildTimingRow(Icons.calendar_view_week, '요일', period.dayOfWeek),
            _buildTimingRow(Icons.access_time, '시간대', period.timeOfDay),
          ],
        ),
      ),
    );
  }

  Widget _buildTimingRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.grey),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(color: Colors.grey),
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
