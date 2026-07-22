import 'package:flutter/material.dart';

/// A pure UI organism displaying a grid of numbered circles.
class QuestionGrid extends StatelessWidget {
  /// Creates the [QuestionGrid].
  const QuestionGrid({
    required this.itemCount,
    required this.crossAxisCount,
    required this.itemBuilder,
    this.crossAxisSpacing = 10.0,
    this.mainAxisSpacing = 16.0,
    super.key,
  });

  /// The total number of items to display.
  final int itemCount;

  /// Number of columns in the grid.
  final int crossAxisCount;

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
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: crossAxisSpacing,
        mainAxisSpacing: mainAxisSpacing,
        childAspectRatio: 1.0,
      ),
      itemCount: itemCount,
      itemBuilder: itemBuilder,
    );
  }
}
