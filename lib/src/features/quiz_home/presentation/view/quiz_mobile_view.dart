import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webquiz/src/design_system/design_system.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../notifiers/quiz_notifier.dart';
import '../widgets/connected_question_grid.dart';
import '../widgets/connected_quiz_banner.dart';
import '../widgets/connected_quiz_card.dart';

/// The mobile-optimized view of the quiz application with full dark theme support and interaction logic.
class QuizMobileView extends ConsumerStatefulWidget {
  /// Creates the [QuizMobileView].
  const QuizMobileView({super.key});

  @override
  ConsumerState<QuizMobileView> createState() => _QuizMobileViewState();
}

class _QuizMobileViewState extends ConsumerState<QuizMobileView> {
  @override
  Widget build(BuildContext context) {
    final quizState = ref.watch(quizProvider);
    final colors = context.zAppColors;
    final isDark = context.zIsDark;

    final questions = quizState.questions;
    final currentIdx = quizState.currentQuestionIndex;
    final activeQuestion = questions.isNotEmpty
        ? questions[currentIdx]
        : QuizState.dummyQuestions[currentIdx];

    return Scaffold(
      backgroundColor: colors.quizBackground,
      body: Skeletonizer(
        enabled: quizState.isLoading,
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
              // Top Banner with Title, Theme Toggle, Reset
              const ConnectedQuizBanner(
                padding: EdgeInsets.symmetric(vertical: 14),
                borderRadius: 12.0,
                titleFontSize: 22.0,
                rightOffset: 12.0,
                iconSize: 18.0,
              ),
              const SizedBox(height: 20),

              // Main container card stacked vertically for mobile
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: colors.quizCardBg,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Grid header row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Question ${activeQuestion.id}/${questions.length}',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: colors.mainText,
                          ),
                        ),
                        Text(
                          'Need Help ?',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: isDark
                                ? const Color(0xFF94A3B8)
                                : const Color(0xFF7B8FA1),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Numbered Circles Grid (1 to 20) wrapped neatly
                    const ConnectedQuestionGrid(isMobile: true),

                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Divider(color: Color(0xFFEEEEEE), height: 1),
                    ),

                    // Quiz Details (Question Box, Options, Prev/Next buttons, Explanation)
                    const ConnectedQuizCard(isMobile: true),
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
