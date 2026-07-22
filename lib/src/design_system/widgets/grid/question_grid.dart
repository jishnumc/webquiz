import 'package:flutter/material.dart';

/// A pure UI organism displaying a grid of numbered circles.
class QuestionGrid extends StatelessWidget {
  /// Creates the [QuestionGrid].
  const QuestionGrid({
    required this.itemCount,
    required this.maxCrossAxisExtent,
    required this.itemBuilder,
    this.crossAxisSpacing = 10.0,
    this.mainAxisSpacing = 16.0,
    super.key,
  });

  /// The total number of items to display.
  final int itemCount;

  /// The maximum extent of each cell in the cross axis.
  final double maxCrossAxisExtent;

  /// Builder function returning the circle button at the given index.
  final Widget Function(BuildContext, int) itemBuilder;

  /// Horizontal spacing between columns.
  final double crossAxisSpacing;

  /// Vertical spacing between rows.
  final double mainAxisSpacing;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: maxCrossAxisExtent,
        crossAxisSpacing: crossAxisSpacing,
        mainAxisSpacing: mainAxisSpacing,
        childAspectRatio: 1.0,
      ),
      itemCount: itemCount,
      itemBuilder: itemBuilder,
    );
  }
}
