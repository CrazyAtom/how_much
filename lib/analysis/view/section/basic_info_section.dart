import 'package:flutter/material.dart';
import 'package:how_much/analysis/model/analysis_result_model.dart';
import 'package:how_much/common/component/card/expandable_card_section.dart';
import 'package:how_much/common/component/list/info_list_tile.dart';
import 'package:intl/intl.dart';

class BasicInfoSection extends StatelessWidget {
  final BasicInfoModel data;

  const BasicInfoSection({
    required this.data,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ExpandableCardSection(
      title: '기본 정보',
      children: [
        InfoListTile(
          title: '카테고리',
          value: data.category,
        ),
        InfoListTile(
          title: '브랜드',
          value: data.brand,
        ),
        InfoListTile(
          title: '모델명',
          value: data.model,
        ),
        InfoListTile(
          title: '상품명',
          value: data.productName,
        ),
        InfoListTile(
          title: '출시일',
          value: data.releaseDate,
        ),
        InfoListTile(
          title: '출시 가격',
          value: NumberFormat.currency(
            locale: 'ko_KR',
            symbol: '₩',
          ).format(data.originalPrice),
        ),
      ],
    );
  }
}
