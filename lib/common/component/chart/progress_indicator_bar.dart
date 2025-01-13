import 'package:flutter/material.dart';
import 'package:how_much/common/const/animation.dart';

class ProgressIndicatorBar extends StatelessWidget {
  final String label;
  final String value;
  final double progress;
  final Color color;
  final Duration duration;
  final Curve curve;

  const ProgressIndicatorBar({
    required this.label,
    required this.value,
    required this.progress,
    this.color = Colors.blue,
    this.duration = AppAnimation.medium,
    this.curve = AppAnimation.emphasized,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 4),
          TweenAnimationBuilder<double>(
            duration: duration,
            curve: curve,
            tween: Tween<double>(begin: 0, end: progress),
            builder: (context, value, child) => ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: value,
                backgroundColor: color.withOpacity(0.12),
                color: color,
                minHeight: 16,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              value,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
