import 'package:flutter/material.dart';
import 'package:webquiz/src/design_system/design_system.dart';

/// A pure UI circular icon button used in header banners.
class QuizIconButton extends StatelessWidget {
  /// Creates the [QuizIconButton].
  const QuizIconButton({
    required this.icon,
    required this.onPressed,
    this.iconSize = 24.0,
    super.key,
  });

  /// The icon data to display.
  final IconData icon;

  /// The button action callback.
  final VoidCallback onPressed;

  /// Optional custom size for the icon inside.
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    final colors = context.zAppColors;
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: colors.optionBg,
      ),
      child: IconButton(
        iconSize: iconSize,
        icon: Icon(
          icon,
          color: colors.bannerText,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
