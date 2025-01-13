import 'package:flutter/material.dart';
import 'package:how_much/common/component/card/custom_card.dart';

class ExpandableCardSection extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final bool initiallyExpanded;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final void Function(bool)? onExpansionChanged;

  const ExpandableCardSection({
    required this.title,
    required this.children,
    this.initiallyExpanded = true,
    this.margin,
    this.padding,
    this.onExpansionChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      margin: margin,
      padding: padding,
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          title: Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          initiallyExpanded: initiallyExpanded,
          onExpansionChanged: onExpansionChanged,
          childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          tilePadding: const EdgeInsets.symmetric(horizontal: 16),
          expandedAlignment: Alignment.topLeft,
          children: children,
        ),
      ),
    );
  }
}
