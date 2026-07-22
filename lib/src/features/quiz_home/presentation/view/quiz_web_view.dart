import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webquiz/src/design_system/design_system.dart';
import '../notifiers/quiz_notifier.dart';
import '../widgets/connected_question_grid.dart';
import '../widgets/connected_quiz_banner.dart';
import '../widgets/connected_quiz_card.dart';

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
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    final questions = quizState.questions;
    final currentIdx = quizState.currentQuestionIndex;
    final activeQuestion = questions[currentIdx];

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
                const ConnectedQuizBanner(
                  width: 580,
                  padding: EdgeInsets.symmetric(vertical: 18),
                  borderRadius: 16.0,
                  titleFontSize: 32.0,
                  rightOffset: 16.0,
                  iconSize: 24.0,
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
                      const Expanded(
                        flex: 5,
                        child: Padding(
                          padding: EdgeInsets.only(right: 24),
                          child: ConnectedQuizCard(isMobile: false),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                      color: isDark
                                          ? const Color(0xFF94A3B8)
                                          : const Color(0xFF7B8FA1),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 24),

                              // Grid of numbered circles (1 to 20) with active indicators and answered states
                              const ConnectedQuestionGrid(isMobile: false),
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
}
