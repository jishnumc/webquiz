import 'package:flutter/material.dart';
import 'package:webquiz/src/design_system/design_system.dart';

/// A pure UI molecule representing the explanation card.
class ExplanationCard extends StatelessWidget {
  /// Creates the [ExplanationCard].
  const ExplanationCard({
    required this.explanationText,
    this.padding = const EdgeInsets.all(20),
    this.borderRadius = 12.0,
    this.titleFontSize = 15.0,
    this.bodyFontSize = 14.0,
    this.lineHeight = 1.4,
    super.key,
  });

  /// The detailed explanation text.
  final String explanationText;

  /// Inner padding.
  final EdgeInsetsGeometry padding;

  /// Border radius.
  final double borderRadius;

  /// Header title font size.
  final double titleFontSize;

  /// Body text font size.
  final double bodyFontSize;

  /// Line height coefficient.
  final double lineHeight;

  @override
  Widget build(BuildContext context) {
    final colors = context.zAppColors;
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: colors.quizCardBg,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: colors.optionBorder,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Explanation',
            style: TextStyle(
              fontSize: titleFontSize,
              fontWeight: FontWeight.bold,
              color: colors.mainText,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            explanationText,
            style: TextStyle(
              fontSize: bodyFontSize,
              height: lineHeight,
              color: colors.subText,
            ),
          ),
        ],
      ),
    );
  }
}
