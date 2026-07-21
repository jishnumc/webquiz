import 'package:flutter/material.dart';
import 'package:webquiz/src/features/quiz_home/presentation/view/quiz_mobile_view.dart';
import 'package:webquiz/src/features/quiz_home/presentation/view/quiz_web_view.dart';

/// A responsive wrapper widget that decides which layout view to display
/// based on the current screen constraints (mobile vs desktop/web).
class QuizHome extends StatelessWidget {
  /// Creates the [QuizHome] widget.
  const QuizHome({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 750) {
          return const QuizMobileView();
        } else {
          return const QuizWebView();
        }
      },
    );
  }
}
