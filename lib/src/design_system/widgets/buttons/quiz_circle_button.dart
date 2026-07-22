import 'package:flutter/material.dart';

/// A pure UI circle index button showing question state (active/inactive, correct/incorrect).
class QuizCircleButton extends StatelessWidget {
  /// Creates the [QuizCircleButton].
  const QuizCircleButton({
    required this.text,
    required this.backgroundColor,
    required this.textColor,
    required this.isActive,
    required this.onTap,
    this.fontSize = 14.0,
    this.borderWidth = 3.0,
    super.key,
  });

  /// The label displayed in the circle center (e.g. number).
  final String text;

  /// Background circle fill color.
  final Color backgroundColor;

  /// Label text color.
  final Color textColor;

  /// Whether this index represents the active/selected question.
  final bool isActive;

  /// Tapping callback.
  final VoidCallback onTap;

  /// Font size of the inner text.
  final double fontSize;

  /// Width of active border decoration.
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
        border: isActive
            ? Border.all(
                color: Colors.blueAccent,
                width: borderWidth,
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
          onTap: onTap,
          borderRadius: BorderRadius.circular(100),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
