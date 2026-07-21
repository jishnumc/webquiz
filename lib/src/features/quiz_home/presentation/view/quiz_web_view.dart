import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webquiz/src/design_system/design_system.dart';
import 'package:webquiz/src/features/quiz_home/presentation/controller/quiz_notifier.dart';
import 'package:webquiz/src/features/quiz_home/presentation/controller/theme_notifier.dart';

/// The home view of the quiz application designed for web interfaces.
class QuizWebView extends ConsumerStatefulWidget {
  /// Creates the [QuizWebView].
  const QuizWebView({super.key});

  @override
  ConsumerState<QuizWebView> createState() => _QuizWebViewState();
}

class _QuizWebViewState extends ConsumerState<QuizWebView> {
  @override
  Widget build(BuildContext context) {
    final quizState = ref.watch(quizProvider);
    final colors = context.zAppColors;
    final isDark = context.zIsDark;

    if (quizState.isLoading) {
      return Scaffold(
        backgroundColor: colors.quizBackground,
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final questions = quizState.questions;
    final currentIdx = quizState.currentQuestionIndex;
    final activeQuestion = questions[currentIdx];
    final selectedIdx = quizState.selectedAnswers[activeQuestion.id];
    final isAnswered = selectedIdx != null;

    return Scaffold(
      backgroundColor: colors.quizBackground,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1100),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Top Banner with Title, Theme Toggle, Reset
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 580,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      decoration: BoxDecoration(
                        color: colors.bannerBg,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.15),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Text(
                        'Quiz Application UI',
                        style: TextStyle(
                          color: colors.bannerText,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 16,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Reset Quiz
                          Container(
                            margin: const EdgeInsets.only(right: 8),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: colors.optionBg,
                            ),
                            child: IconButton(
                              icon: Icon(
                                Icons.refresh_rounded,
                                color: colors.bannerText,
                              ),
                              onPressed: () {
                                ref.read(quizProvider.notifier).resetQuiz();
                              },
                            ),
                          ),
                          // Light/Dark Theme Mode Toggle
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: colors.optionBg,
                            ),
                            child: IconButton(
                              icon: Icon(
                                isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                                color: colors.bannerText,
                              ),
                              onPressed: () {
                                ref.read(themeModeProvider.notifier).toggle();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),

                // Main Content Card
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: colors.quizCardBg,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Left Column: Quiz details & inputs
                      Expanded(
                        flex: 5,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // Quiz Title
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'Quiz Title',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: colors.mainText,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),

                              // Question Card Box
                              Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: colors.questionBoxBg,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: colors.questionBoxBorder,
                                    width: 1.5,
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Question ${activeQuestion.id}',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: colors.mainText,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      activeQuestion.questionText,
                                      style: TextStyle(
                                        fontSize: 15,
                                        height: 1.4,
                                        color: colors.subText,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),

                              // Options Cards (with custom green/red selection feedback)
                              ...List.generate(activeQuestion.options.length, (optionIdx) {
                                final optionText = activeQuestion.options[optionIdx];

                                Color cardBg = colors.optionBg;
                                Color cardBorder = colors.optionBorder;
                                Color textCol = colors.mainText;

                                if (isAnswered) {
                                  if (optionIdx == activeQuestion.correctOptionIndex) {
                                    // Correct option background & green highlight text
                                    cardBg = isDark ? const Color(0xFF14532D) : const Color(0xFFE8F5E9);
                                    cardBorder = isDark ? const Color(0xFF22C55E) : const Color(0xFF81C784);
                                    textCol = isDark ? const Color(0xFF86EFAC) : const Color(0xFF2E7D32);
                                  } else if (optionIdx == selectedIdx) {
                                    // Wrong selected background & red highlight text
                                    cardBg = isDark ? const Color(0xFF7F1D1D) : const Color(0xFFFFEBEE);
                                    cardBorder = isDark ? const Color(0xFFEF4444) : const Color(0xFFE57373);
                                    textCol = isDark ? const Color(0xFFFCA5A5) : const Color(0xFFC62828);
                                  } else {
                                    // Faded out other incorrect options
                                    cardBg = colors.optionBg.withValues(alpha: 0.4);
                                    cardBorder = colors.optionBorder.withValues(alpha: 0.4);
                                    textCol = colors.mainText.withValues(alpha: 0.4);
                                  }
                                }

                                return Container(
                                  margin: const EdgeInsets.only(bottom: 12),
                                  decoration: BoxDecoration(
                                    color: cardBg,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: cardBorder,
                                      width: 1,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withValues(alpha: 0.02),
                                        blurRadius: 4,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: isAnswered
                                          ? null
                                          : () {
                                              ref
                                                  .read(quizProvider.notifier)
                                                  .selectAnswer(activeQuestion.id, optionIdx);
                                            },
                                      borderRadius: BorderRadius.circular(12),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 20,
                                          vertical: 16,
                                        ),
                                        child: Text(
                                          optionText,
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: textCol,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                              const SizedBox(height: 16),

                              // Prev / Next Action Buttons
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _buildNavigationButton('Prev', () {
                                    if (currentIdx > 0) {
                                      ref
                                          .read(quizProvider.notifier)
                                          .setCurrentQuestionIndex(currentIdx - 1);
                                    }
                                  }),
                                  const SizedBox(width: 40),
                                  _buildNavigationButton('Next', () {
                                    if (currentIdx < questions.length - 1) {
                                      ref
                                          .read(quizProvider.notifier)
                                          .setCurrentQuestionIndex(currentIdx + 1);
                                    }
                                  }),
                                ],
                              ),
                              const SizedBox(height: 24),

                              // Explanation Section Box (only shown once answered)
                              if (isAnswered)
                                Container(
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: colors.quizCardBg,
                                    borderRadius: BorderRadius.circular(12),
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
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Explanation',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: colors.mainText,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        activeQuestion.explanation,
                                        style: TextStyle(
                                          fontSize: 14,
                                          height: 1.4,
                                          color: colors.subText,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),

                      // Vertical Divider
                      Container(
                        width: 1,
                        height: 600,
                        color: colors.dividerColor,
                      ),

                      // Right Column: Progress status & circular numbers grid
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // Grid header row
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Question ${activeQuestion.id}/${questions.length}',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: colors.mainText,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'Need Help ?',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF7B8FA1),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 24),

                              // Grid of numbered circles (1 to 20) with active indicators and answered states
                              GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 5,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 16,
                                  childAspectRatio: 1.0,
                                ),
                                itemCount: questions.length,
                                itemBuilder: (context, index) {
                                  final num = index + 1;
                                  final q = questions[index];
                                  final ansIdx = quizState.selectedAnswers[q.id];
                                  final isQAnswered = ansIdx != null;

                                  // Grid circle color logic matching active, answered (correct/incorrect) or default designs
                                  Color circleBg;
                                  Color textCol = Colors.white;

                                  if (isQAnswered) {
                                    // Highlight answered question selector circle (Green if correct selection, Red if incorrect selection)
                                    final isCorrect = ansIdx == q.correctOptionIndex;
                                    circleBg = isCorrect ? const Color(0xFF4CAF50) : const Color(0xFFF44336);
                                  } else {
                                    if (num <= 10) {
                                      circleBg = isDark ? const Color(0xFF2E4BB0) : const Color(0xFFB3C5FF);
                                    } else if (num == 11) {
                                      circleBg = isDark ? const Color(0xFFC53030) : const Color(0xFFFFA3A3);
                                    } else {
                                      circleBg = isDark ? const Color(0xFF475569) : const Color(0xFFCCCCCC);
                                      textCol = isDark ? const Color(0xFFCBD5E1) : const Color(0xFF555555);
                                    }
                                  }

                                  // Highlight the currently active question index with a border
                                  final isActive = index == currentIdx;

                                  return Container(
                                    decoration: BoxDecoration(
                                      color: circleBg,
                                      shape: BoxShape.circle,
                                      border: isActive
                                          ? Border.all(
                                              color: Colors.blueAccent,
                                              width: 3.0,
                                            )
                                          : null,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withValues(alpha: 0.04),
                                          blurRadius: 4,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        onTap: () {
                                          ref
                                              .read(quizProvider.notifier)
                                              .setCurrentQuestionIndex(index);
                                        },
                                        borderRadius: BorderRadius.circular(100),
                                        child: Center(
                                          child: Text(
                                            '$num',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: textCol,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavigationButton(String label, VoidCallback onTap) {
    return Builder(
      builder: (context) {
        final colors = context.zAppColors;
        return Container(
          decoration: BoxDecoration(
            color: colors.optionBg,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(8),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 10),
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: colors.mainText,
                  ),
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}
