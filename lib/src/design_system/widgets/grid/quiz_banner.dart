import 'package:flutter/material.dart';
import 'package:webquiz/src/design_system/design_system.dart';

/// A pure UI organism combining the title banner block with dynamic action buttons on the right.
class QuizBanner extends StatelessWidget {
  /// Creates the [QuizBanner].
  const QuizBanner({
    required this.actions,
    this.title = 'Quiz Application UI',
    this.width,
    this.padding = const EdgeInsets.symmetric(vertical: 18),
    this.borderRadius = 16.0,
    this.titleFontSize = 32.0,
    this.rightOffset = 16.0,
    super.key,
  });

  /// The list of actions widgets (buttons) on the right side.
  final List<Widget> actions;

  /// The main banner title text.
  final String title;

  /// Optional fixed width for the banner.
  final double? width;

  /// Inner padding.
  final EdgeInsetsGeometry padding;

  /// Rounded corner radius.
  final double borderRadius;

  /// Title text font size.
  final double titleFontSize;

  /// Right position inset spacing.
  final double rightOffset;

  @override
  Widget build(BuildContext context) {
    final colors = context.zAppColors;
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: width,
          alignment: Alignment.center,
          padding: padding,
          decoration: BoxDecoration(
            color: colors.bannerBg,
            borderRadius: BorderRadius.circular(borderRadius),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.15),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Text(
            title,
            style: TextStyle(
              color: colors.bannerText,
              fontSize: titleFontSize,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
        ),
        Positioned(
          right: rightOffset,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: actions,
          ),
        ),
      ],
    );
  }
}
