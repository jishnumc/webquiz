import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webquiz/src/design_system/design_system.dart';
import '../notifiers/quiz_notifier.dart';

/// A feature widget connecting [QuestionCard], [OptionCard], [QuizNavButton], and [ExplanationCard] to Riverpod state.
class ConnectedQuizCard extends ConsumerWidget {
  /// Creates the [ConnectedQuizCard].
  const ConnectedQuizCard({this.isMobile = false, super.key});

  /// Displays the layout optimized for mobile space sizes if true.
  final bool isMobile;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quizState = ref.watch(quizProvider);
    final colors = context.zAppColors;
    final isDark = context.zIsDark;

    if (quizState.isLoading) {
      return const SizedBox.shrink();
    }

    final questions = quizState.questions;
    final currentIdx = quizState.currentQuestionIndex;
    final activeQuestion = questions[currentIdx];
    final selectedIdx = quizState.selectedAnswers[activeQuestion.id];
    final isAnswered = selectedIdx != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Quiz Title Header text
        Align(
          alignment: Alignment.center,
          child: Text(
            'Quiz Title',
            style: TextStyle(
              fontSize: isMobile ? 14.0 : 16.0,
              fontWeight: FontWeight.w600,
              color: colors.mainText,
            ),
          ),
        ),
        SizedBox(height: isMobile ? 12.0 : 20.0),

        // Core Question Card box
        QuestionCard(
          questionId: activeQuestion.id,
          questionText: activeQuestion.questionText,
          padding: isMobile
              ? const EdgeInsets.all(16)
              : const EdgeInsets.all(20),
          borderRadius: isMobile ? 10.0 : 12.0,
          borderWidth: isMobile ? 1.2 : 1.5,
          titleFontSize: isMobile ? 14.0 : 15.0,
          bodyFontSize: isMobile ? 13.5 : 15.0,
          lineHeight: isMobile ? 1.35 : 1.4,
        ),
        SizedBox(height: isMobile ? 16.0 : 20.0),

        // List of option item cards
        ...List.generate(activeQuestion.options.length, (optionIdx) {
          final optionText = activeQuestion.options[optionIdx];

          Color cardBg = colors.optionBg;
          Color cardBorder = colors.optionBorder;
          Color textCol = colors.mainText;

          if (isAnswered) {
            if (optionIdx == activeQuestion.correctOptionIndex) {
              cardBg = isDark
                  ? const Color(0xFF14532D)
                  : const Color(0xFFE8F5E9);
              cardBorder = isDark
                  ? const Color(0xFF22C55E)
                  : const Color(0xFF81C784);
              textCol = isDark
                  ? const Color(0xFF86EFAC)
                  : const Color(0xFF2E7D32);
            } else if (optionIdx == selectedIdx) {
              cardBg = isDark
                  ? const Color(0xFF7F1D1D)
                  : const Color(0xFFFFEBEE);
              cardBorder = isDark
                  ? const Color(0xFFEF4444)
                  : const Color(0xFFE57373);
              textCol = isDark
                  ? const Color(0xFFFCA5A5)
                  : const Color(0xFFC62828);
            } else {
              cardBg = colors.optionBg.withValues(alpha: 0.4);
              cardBorder = colors.optionBorder.withValues(alpha: 0.4);
              textCol = colors.mainText.withValues(alpha: 0.4);
            }
          }

          return Container(
            margin: EdgeInsets.only(bottom: isMobile ? 8.0 : 12.0),
            child: OptionCard(
              optionText: optionText,
              backgroundColor: cardBg,
              borderColor: cardBorder,
              textColor: textCol,
              borderRadius: isMobile ? 10.0 : 12.0,
              padding: isMobile
                  ? const EdgeInsets.symmetric(horizontal: 16, vertical: 12)
                  : const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              fontSize: isMobile ? 13.5 : 15.0,
              onTap: isAnswered
                  ? null
                  : () {
                      ref
                          .read(quizProvider.notifier)
                          .selectAnswer(activeQuestion.id, optionIdx);
                    },
            ),
          );
        }),
        SizedBox(height: isMobile ? 12.0 : 16.0),

        // Navigation Control Row
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            QuizNavButton(
              label: 'Prev',
              onTap: currentIdx > 0
                  ? () {
                      ref
                          .read(quizProvider.notifier)
                          .setCurrentQuestionIndex(currentIdx - 1);
                    }
                  : null,
            ),
            SizedBox(width: isMobile ? 30.0 : 40.0),
            QuizNavButton(
              label: 'Next',
              onTap: currentIdx < questions.length - 1
                  ? () {
                      ref
                          .read(quizProvider.notifier)
                          .setCurrentQuestionIndex(currentIdx + 1);
                    }
                  : null,
            ),
          ],
        ),
        SizedBox(height: isMobile ? 20.0 : 24.0),

        // Explanation text card (only displayed once answered)
        if (isAnswered)
          ExplanationCard(
            explanationText: activeQuestion.explanation,
            padding: isMobile
                ? const EdgeInsets.all(16)
                : const EdgeInsets.all(20),
            borderRadius: isMobile ? 10.0 : 12.0,
            titleFontSize: isMobile ? 14.0 : 15.0,
            bodyFontSize: isMobile ? 13.0 : 14.0,
            lineHeight: isMobile ? 1.35 : 1.4,
          ),
      ],
    );
  }
}
