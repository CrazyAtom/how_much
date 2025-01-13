import 'package:flutter/animation.dart';

class AppAnimation {
  // Duration
  static const Duration fast = Duration(milliseconds: 150);
  static const Duration medium = Duration(milliseconds: 300);
  static const Duration slow = Duration(milliseconds: 500);

  // Curves
  static const Curve emphasized = Curves.easeOutCubic;
  static const Curve standard = Curves.easeInOutCubic;
  static const Curve decelerated = Curves.easeOutQuart;

  // Scale factors
  static const double pressedScale = 0.98;
  static const double defaultScale = 1.0;
}
