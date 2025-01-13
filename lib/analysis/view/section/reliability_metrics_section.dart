import 'package:flutter/material.dart';
import 'package:how_much/analysis/model/analysis_result_model.dart';
import 'package:how_much/common/component/card/custom_card.dart';
import 'package:how_much/common/component/card/expandable_card_section.dart';
import 'package:how_much/common/component/chart/chart_section_header.dart';
import 'package:how_much/common/component/list/info_list_tile.dart';
import 'package:intl/intl.dart';

class ReliabilityMetricsSection extends StatelessWidget {
  final ReliabilityMetricsModel data;

  const ReliabilityMetricsSection({
    required this.data,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ExpandableCardSection(
      title: '신뢰도 지표',
      children: [
        _buildProductReliability(data.productReliability),
        const Divider(),
        _buildMarketReliability(data.marketReliability),
      ],
    );
  }

  Widget _buildProductReliability(ProductReliabilityModel productReliability) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ChartSectionHeader(title: '제품 신뢰도'),
        InfoListTile(
          title: '하자 발생률',
          value: NumberFormat.decimalPercentPattern(decimalDigits: 1)
              .format(productReliability.defectRate / 100),
        ),
        InfoListTile(
          title: '평균 수명',
          value: '${productReliability.averageLifespan}개월',
        ),
        const SizedBox(height: 8),
        CustomCard(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '주요 하자 유형',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                ...productReliability.commonIssues.map<Widget>((issue) {
                  return InfoListTile(
                    title: issue.issue,
                    value: NumberFormat.decimalPercentPattern(decimalDigits: 1)
                        .format(issue.frequency / 100),
                  );
                }),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMarketReliability(MarketReliabilityModel marketReliability) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ChartSectionHeader(title: '시장 신뢰도'),
        InfoListTile(
          title: '사기 거래 위험도',
          value: '${marketReliability.fraudRisk}점',
        ),
        InfoListTile(
          title: '허위매물 비율',
          value: NumberFormat.decimalPercentPattern(decimalDigits: 1)
              .format(marketReliability.fakeListingRate / 100),
        ),
        const SizedBox(height: 8),
        CustomCard(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '진품 확인 팁',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                ...marketReliability.verificationTips.map<Widget>((tip) {
                  return ListTile(
                    leading: const Icon(
                      Icons.check_circle_outline,
                      color: Colors.green,
                    ),
                    title: Text(tip),
                  );
                }),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
