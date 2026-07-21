import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webquiz/src/design_system/design_system.dart';
import 'package:webquiz/src/features/quiz_home/presentation/view/quiz_web_view.dart';

/// The mobile-optimized view of the quiz application with full dark theme support.
class QuizMobileView extends ConsumerStatefulWidget {
  /// Creates the [QuizMobileView].
  const QuizMobileView({super.key});

  @override
  ConsumerState<QuizMobileView> createState() => _QuizMobileViewState();
}

class _QuizMobileViewState extends ConsumerState<QuizMobileView> {
  int _currentQuestionIndex = 0;

  final List<QuizQuestion> _questions = const [
    QuizQuestion(
      id: 1,
      questionText:
          'A train passes a station platform in 36 seconds and a man standing on the platform in 20 seconds. If the speed of the train is 54 km/hr, what is the length of the platform?',
      options: ['120 m', '240 m', '300 m', 'None of these'],
      explanation:
          'A train passes a station platform in 36 seconds and a man standing on the platform in 20 seconds. If the speed of the train is 54 km/hr, what is the length of the platform?',
    ),
    QuizQuestion(
      id: 2,
      questionText:
          'A sum of money at simple interest amounts to Rs. 815 in 3 years and to Rs. 854 in 4 years. The sum is:',
      options: ['Rs. 650', 'Rs. 690', 'Rs. 698', 'Rs. 700'],
      explanation:
          'Interest for 1 year = Rs. (854 - 815) = Rs. 39. Interest for 3 years = Rs. (39 x 3) = Rs. 117. Principal = Rs. (815 - 117) = Rs. 698.',
    ),
    QuizQuestion(
      id: 3,
      questionText:
          'The simple interest on a certain sum of money for 2(1/2) years at 12% per annum is Rs. 40 less than the simple interest on the same sum for 3(1/2) years at 10% per annum. Find the sum.',
      options: ['Rs. 800', 'Rs. 600', 'Rs. 750', 'Rs. 900'],
      explanation:
          'Let the sum be x. Then, (x * 10 * 3.5)/100 - (x * 12 * 2.5)/100 = 40. Solving for x gives Rs. 800.',
    ),
    QuizQuestion(
      id: 4,
      questionText:
          'A, B and C can do a piece of work in 20, 30 and 60 days respectively. In how many days can A do the work if he is assisted by B and C on every third day?',
      options: ['12 days', '15 days', '16 days', '18 days'],
      explanation:
          'A\'s 2 days work = 2/20 = 1/10. (A+B+C)\'s 1 day work = 1/20 + 1/30 + 1/60 = 6/60 = 1/10. 3 days work = 1/10 + 1/10 = 1/5. Hence work is done in 15 days.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final colors = context.zAppColors;
    final isDark = context.zIsDark;
    final activeQuestion = _questions[_currentQuestionIndex];

    return Scaffold(
      backgroundColor: colors.quizBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Top Banner with Title and Theme Toggle
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      color: colors.bannerBg,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Text(
                      'Quiz Application UI',
                      style: TextStyle(
                        color: colors.bannerText,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 12,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: colors.optionBg,
                      ),
                      child: IconButton(
                        iconSize: 20,
                        icon: Icon(
                          isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                          color: colors.bannerText,
                        ),
                        onPressed: () {
                          ref.read(themeModeProvider.notifier).toggle();
                        },
                      ),
                    ),
                  ),
                ],
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
                          'Question ${activeQuestion.id}/${_questions.length}',
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
                            color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF7B8FA1),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Numbered Circles Grid (1 to 20) wrapped neatly
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 10, // 10 columns for a very compact mobile layout
                        crossAxisSpacing: 6,
                        mainAxisSpacing: 8,
                        childAspectRatio: 1.0,
                      ),
                      itemCount: 20,
                      itemBuilder: (context, index) {
                        final num = index + 1;
                        Color circleBg;
                        Color textCol = Colors.white;

                        if (num <= 10) {
                          circleBg = isDark ? const Color(0xFF3B82F6) : const Color(0xFFB3C5FF);
                        } else if (num == 11) {
                          circleBg = isDark ? const Color(0xFFEF4444) : const Color(0xFFFFA3A3);
                        } else {
                          circleBg = isDark ? const Color(0xFF475569) : const Color(0xFFCCCCCC);
                          textCol = isDark ? const Color(0xFFCBD5E1) : const Color(0xFF555555);
                        }

                        final isActive = num == activeQuestion.id;

                        return Container(
                          decoration: BoxDecoration(
                            color: circleBg,
                            shape: BoxShape.circle,
                            border: isActive
                                ? Border.all(
                                    color: Colors.blueAccent,
                                    width: 2.0,
                                  )
                                : null,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '$num',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: textCol,
                            ),
                          ),
                        );
                      },
                    ),

                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Divider(color: Color(0xFFEEEEEE), height: 1),
                    ),

                    // Quiz Title
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Quiz Title',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: colors.mainText,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Question Box Card
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: colors.questionBoxBg,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: colors.questionBoxBorder,
                          width: 1.2,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Question ${activeQuestion.id}',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: colors.mainText,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            activeQuestion.questionText,
                            style: TextStyle(
                              fontSize: 13.5,
                              height: 1.35,
                              color: colors.subText,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Options Cards
                    ...List.generate(activeQuestion.options.length, (index) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: colors.optionBg,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: colors.optionBorder,
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.02),
                              blurRadius: 3,
                              offset: const Offset(0, 1.5),
                            ),
                          ],
                        ),
                        child: Text(
                          activeQuestion.options[index],
                          style: TextStyle(
                            fontSize: 13.5,
                            color: colors.mainText,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    }),
                    const SizedBox(height: 12),

                    // Prev / Next Action Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildNavigationButton('Prev', () {
                          if (_currentQuestionIndex > 0) {
                            setState(() {
                              _currentQuestionIndex--;
                            });
                          }
                        }),
                        const SizedBox(width: 30),
                        _buildNavigationButton('Next', () {
                          if (_currentQuestionIndex < _questions.length - 1) {
                            setState(() {
                              _currentQuestionIndex++;
                            });
                          }
                        }),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Explanation Box Card
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: colors.quizCardBg,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: colors.optionBorder,
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.03),
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Explanation',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: colors.mainText,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            activeQuestion.explanation,
                            style: TextStyle(
                              fontSize: 13,
                              height: 1.35,
                              color: colors.subText,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
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
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(8),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 13,
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
