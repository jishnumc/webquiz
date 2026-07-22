import 'package:flutter/material.dart';

/// A pure UI molecule representing an option item card.
class OptionCard extends StatelessWidget {
  /// Creates the [OptionCard].
  const OptionCard({
    required this.optionText,
    required this.backgroundColor,
    required this.borderColor,
    required this.textColor,
    required this.onTap,
    this.borderRadius = 12.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    this.fontSize = 15.0,
    super.key,
  });

  /// The text content of the option choice.
  final String optionText;

  /// Background container color.
  final Color backgroundColor;

  /// Border outline decoration color.
  final Color borderColor;

  /// Option text font style color.
  final Color textColor;

  /// Callback action on tap (null if option is disabled).
  final VoidCallback? onTap;

  /// Rounded corner size.
  final double borderRadius;

  /// Padding surrounding text container.
  final EdgeInsetsGeometry padding;

  /// Text font size metric.
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: borderColor,
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
          onTap: onTap,
          borderRadius: BorderRadius.circular(borderRadius),
          child: Padding(
            padding: padding,
            child: Text(
              optionText,
              style: TextStyle(
                fontSize: fontSize,
                color: textColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
