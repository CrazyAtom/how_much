import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:how_much/analysis/model/analysis_result_model.dart';
import 'package:how_much/common/component/card/expandable_card_section.dart';
import 'package:how_much/common/component/chart/chart_section_header.dart';
import 'package:how_much/common/component/chart/progress_indicator_bar.dart';
import 'package:intl/intl.dart';

class PriceAnalysisSection extends StatelessWidget {
  final PriceAnalysisModel data;

  const PriceAnalysisSection({
    required this.data,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ExpandableCardSection(
      title: '가격 분석',
      children: [
        _buildPriceChart(data.currentMarket),
        const Divider(),
        _buildConditionPrices(data.conditionBasedPrices),
        const Divider(),
        _buildRegionalPrices(data.regionalPrices),
      ],
    );
  }

  Widget _buildPriceChart(CurrentMarketModel currentMarket) {
    return Column(
      children: [
        const ChartSectionHeader(title: '가격 범위'),
        SizedBox(
          height: 180,
          child: LineChart(
            LineChartData(
              lineTouchData: LineTouchData(
                touchTooltipData: LineTouchTooltipData(
                  fitInsideHorizontally: true,
                  fitInsideVertically: true,
                ),
              ),
              gridData: const FlGridData(show: true),
              titlesData: _buildChartTitles(),
              borderData: FlBorderData(show: true),
              lineBarsData: [_buildLineChartData(currentMarket)],
            ),
          ),
        ),
      ],
    );
  }

  FlTitlesData _buildChartTitles() {
    return FlTitlesData(
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 40,
          getTitlesWidget: (value, meta) {
            return Text(
              '${NumberFormat.currency(locale: 'ko_KR', symbol: '₩').format(value / 10000)}만',
              style: const TextStyle(fontSize: 10),
            );
          },
        ),
      ),
      bottomTitles: const AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      rightTitles: const AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      topTitles: const AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
    );
  }

  LineChartBarData _buildLineChartData(CurrentMarketModel currentMarket) {
    return LineChartBarData(
      spots: [
        FlSpot(0, currentMarket.lowestPrice.toDouble()),
        FlSpot(1, currentMarket.medianPrice.toDouble()),
        FlSpot(2, currentMarket.highestPrice.toDouble()),
      ],
      isCurved: true,
      color: Colors.blue,
      barWidth: 2,
      dotData: const FlDotData(show: true),
    );
  }

  Widget _buildConditionPrices(Map<String, dynamic> conditionPrices) {
    final maxPrice = conditionPrices.values
        .map((e) => e as int)
        .reduce((a, b) => a > b ? a : b);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ChartSectionHeader(title: '상태별 가격'),
        ...conditionPrices.entries.map(
          (entry) {
            final conditionMap = {
              'like_new': '거의 새 제품',
              'good': '상태 좋음',
              'fair': '사용감 있음',
            };
            final condition = conditionMap[entry.key] ?? entry.key;
            final value = NumberFormat.currency(
              locale: 'ko_KR',
              symbol: '₩',
            ).format(entry.value);

            return ProgressIndicatorBar(
              label: condition,
              value: value,
              progress: entry.value / maxPrice,
              color: Colors.blue,
            );
          },
        ),
      ],
    );
  }

  Widget _buildRegionalPrices(List<RegionalPriceModel> regionalPrices) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ChartSectionHeader(title: '지역별 가격'),
        SizedBox(
          height: 180,
          child: BarChart(
            BarChartData(
              barTouchData: BarTouchData(
                touchTooltipData: BarTouchTooltipData(
                  fitInsideHorizontally: true,
                  fitInsideVertically: true,
                ),
              ),
              alignment: BarChartAlignment.spaceAround,
              barGroups: _buildBarGroups(regionalPrices),
              titlesData: _buildBarChartTitles(regionalPrices),
            ),
          ),
        ),
      ],
    );
  }

  List<BarChartGroupData> _buildBarGroups(
      List<RegionalPriceModel> regionalPrices) {
    return regionalPrices.asMap().entries.map((entry) {
      return BarChartGroupData(
        x: entry.key,
        barRods: [
          BarChartRodData(
            toY: entry.value.averagePrice.toDouble(),
            color: Colors.blue,
          ),
        ],
      );
    }).toList();
  }

  FlTitlesData _buildBarChartTitles(List<RegionalPriceModel> regionalPrices) {
    return FlTitlesData(
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 40,
          getTitlesWidget: (value, meta) {
            return Text(
              '${NumberFormat.currency(
                locale: 'ko_KR',
                symbol: '₩',
              ).format(value / 10000)}만',
              style: const TextStyle(fontSize: 10),
            );
          },
        ),
      ),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          getTitlesWidget: (value, meta) {
            final data = regionalPrices[value.toInt()];
            return Text(
              data.region,
              style: const TextStyle(fontSize: 10),
            );
          },
        ),
      ),
      topTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          getTitlesWidget: (value, meta) {
            final data = regionalPrices[value.toInt()];
            return Text(
              '${data.transactionCount}건',
              style: const TextStyle(fontSize: 10),
            );
          },
        ),
      ),
    );
  }
}
