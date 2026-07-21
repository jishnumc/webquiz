/// Represents the core Quiz Question business entity.
class QuizQuestion {
  /// Creates a [QuizQuestion].
  const QuizQuestion({
    required this.id,
    required this.questionText,
    required this.options,
    required this.explanation,
    required this.correctOptionIndex,
  });

  /// The question unique identification.
  final int id;

  /// The text content of the question.
  final String questionText;

  /// Multiple choice options list.
  final List<String> options;

  /// Detailed explanation block.
  final String explanation;

  /// 0-indexed correct option identifier.
  final int correctOptionIndex;
}
