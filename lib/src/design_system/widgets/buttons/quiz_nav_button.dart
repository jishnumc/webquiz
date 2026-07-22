import 'package:flutter/material.dart';
import 'package:webquiz/src/design_system/design_system.dart';

/// A pure UI navigation button used for Next and Prev actions.
class QuizNavButton extends StatelessWidget {
  /// Creates the [QuizNavButton].
  const QuizNavButton({
    required this.label,
    required this.onTap,
    super.key,
  });

  /// The button text label.
  final String label;

  /// The callback action on button press.
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
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
}
