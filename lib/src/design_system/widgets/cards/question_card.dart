import 'package:flutter/material.dart';
import 'package:webquiz/src/design_system/design_system.dart';

/// A pure UI molecule representing the question text box container.
class QuestionCard extends StatelessWidget {
  /// Creates the [QuestionCard].
  const QuestionCard({
    required this.questionId,
    required this.questionText,
    this.padding = const EdgeInsets.all(20),
    this.borderRadius = 12.0,
    this.borderWidth = 1.5,
    this.titleFontSize = 15.0,
    this.bodyFontSize = 15.0,
    this.lineHeight = 1.4,
    super.key,
  });

  /// The question number identifier.
  final int questionId;

  /// The text contents of the question.
  final String questionText;

  /// Container inner padding.
  final EdgeInsetsGeometry padding;

  /// Outer border radius size.
  final double borderRadius;

  /// Outer border width.
  final double borderWidth;

  /// Title font size text.
  final double titleFontSize;

  /// Body question description font size text.
  final double bodyFontSize;

  /// Text leading line spacing coefficient.
  final double lineHeight;

  @override
  Widget build(BuildContext context) {
    final colors = context.zAppColors;
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: colors.questionBoxBg,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: colors.questionBoxBorder,
          width: borderWidth,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Question $questionId',
            style: TextStyle(
              fontSize: titleFontSize,
              fontWeight: FontWeight.bold,
              color: colors.mainText,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            questionText,
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
