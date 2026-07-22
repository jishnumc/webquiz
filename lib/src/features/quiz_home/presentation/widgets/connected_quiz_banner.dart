import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webquiz/src/design_system/design_system.dart';
import '../notifiers/quiz_notifier.dart';
import '../notifiers/theme_notifier.dart';

/// A feature widget connecting [QuizBanner] to Riverpod states.
class ConnectedQuizBanner extends ConsumerWidget {
  /// Creates the [ConnectedQuizBanner].
  const ConnectedQuizBanner({
    this.width,
    this.padding = const EdgeInsets.symmetric(vertical: 18),
    this.borderRadius = 16.0,
    this.titleFontSize = 32.0,
    this.rightOffset = 16.0,
    this.iconSize = 24.0,
    super.key,
  });

  /// Optional width limits.
  final double? width;

  /// Custom padding metrics.
  final EdgeInsetsGeometry padding;

  /// Corner radius config.
  final double borderRadius;

  /// Title font text size.
  final double titleFontSize;

  /// Offset spacing for right actions.
  final double rightOffset;

  /// Size of action buttons.
  final double iconSize;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = context.zIsDark;

    return QuizBanner(
      title: 'Quiz Application UI',
      width: width,
      padding: padding,
      borderRadius: borderRadius,
      titleFontSize: titleFontSize,
      rightOffset: rightOffset,
      actions: [
        QuizIconButton(
          icon: Icons.refresh_rounded,
          iconSize: iconSize,
          onPressed: () {
            ref.read(quizProvider.notifier).resetQuiz();
          },
        ),
        const SizedBox(width: 8),
        QuizIconButton(
          icon: isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
          iconSize: iconSize,
          onPressed: () {
            ref.read(themeModeProvider.notifier).toggle();
          },
        ),
      ],
    );
  }
}
