import 'package:flutter/material.dart';
import 'package:how_much/common/component/card/custom_card.dart';
import 'package:how_much/common/theme/app_colors.dart';

class InfoListTile extends StatelessWidget {
  final String title;
  final String value;
  final Widget? leading;
  final Color? valueColor;
  final TextStyle? valueStyle;
  final VoidCallback? onTap;
  final Widget? subtitle;

  const InfoListTile({
    required this.title,
    required this.value,
    this.leading,
    this.valueColor,
    this.valueStyle,
    this.onTap,
    this.subtitle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      onTap: onTap,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          if (leading != null) ...[
            leading!,
            const SizedBox(width: 12),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w500,
                      ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 2),
                  DefaultTextStyle(
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.textSecondary,
                            ) ??
                        const TextStyle(),
                    child: subtitle!,
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(
            value,
            style: valueStyle ??
                Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: valueColor ?? AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
          ),
        ],
      ),
    );
  }
}
