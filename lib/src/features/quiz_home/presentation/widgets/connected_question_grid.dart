import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webquiz/src/design_system/design_system.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../notifiers/quiz_notifier.dart';

/// A feature widget connecting the progress [QuestionGrid] and [QuizCircleButton] items to Riverpod state.
class ConnectedQuestionGrid extends ConsumerWidget {
  /// Creates the [ConnectedQuestionGrid].
  const ConnectedQuestionGrid({this.isMobile = false, super.key});

  /// Displays the grid in a mobile compact size if true.
  final bool isMobile;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quizState = ref.watch(quizProvider);
    final isDark = context.zIsDark;

    final questions = quizState.questions;
    final currentIdx = quizState.currentQuestionIndex;

    return Skeletonizer(
      enabled: quizState.isLoading,
      child: QuestionGrid(
        itemCount: questions.length,
        maxCrossAxisExtent: isMobile ? 32.0 : 44.0,
        crossAxisSpacing: isMobile ? 6.0 : 10.0,
        mainAxisSpacing: isMobile ? 8.0 : 16.0,
        itemBuilder: (context, index) {
          final num = index + 1;
          final q = questions[index];
          final ansIdx = quizState.selectedAnswers[q.id];
          final isQAnswered = ansIdx != null;

          Color circleBg;
          Color textCol = Colors.white;

          if (isQAnswered) {
            final isCorrect = ansIdx == q.correctOptionIndex;
            circleBg = isCorrect
                ? const Color(0xFF4CAF50)
                : const Color(0xFFF44336);
          } else {
            if (isMobile) {
              if (num <= 10) {
                circleBg = isDark
                    ? const Color(0xFF3B82F6)
                    : const Color(0xFFB3C5FF);
              } else if (num == 11) {
                circleBg = isDark
                    ? const Color(0xFFEF4444)
                    : const Color(0xFFFFA3A3);
              } else {
                circleBg = isDark
                    ? const Color(0xFF475569)
                    : const Color(0xFFCCCCCC);
                textCol = isDark
                    ? const Color(0xFFCBD5E1)
                    : const Color(0xFF555555);
              }
            } else {
              if (num <= 10) {
                circleBg = isDark
                    ? const Color(0xFF2E4BB0)
                    : const Color(0xFFB3C5FF);
              } else if (num == 11) {
                circleBg = isDark
                    ? const Color(0xFFC53030)
                    : const Color(0xFFFFA3A3);
              } else {
                circleBg = isDark
                    ? const Color(0xFF475569)
                    : const Color(0xFFCCCCCC);
                textCol = isDark
                    ? const Color(0xFFCBD5E1)
                    : const Color(0xFF555555);
              }
            }
          }

          final isActive = index == currentIdx;

          return QuizCircleButton(
            text: '$num',
            backgroundColor: circleBg,
            textColor: textCol,
            isActive: isActive,
            fontSize: isMobile ? 10.0 : 14.0,
            borderWidth: isMobile ? 2.0 : 3.0,
            onTap: () {
              ref.read(quizProvider.notifier).setCurrentQuestionIndex(index);
            },
          );
        },
      ),
    );
  }
}
