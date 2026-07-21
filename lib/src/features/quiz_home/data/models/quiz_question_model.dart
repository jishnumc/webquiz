import '../../domain/entities/quiz_question.dart';

/// The data model extension of the [QuizQuestion] entity.
class QuizQuestionModel extends QuizQuestion {
  /// Creates a [QuizQuestionModel].
  const QuizQuestionModel({
    required super.id,
    required super.questionText,
    required super.options,
    required super.explanation,
    required super.correctOptionIndex,
  });

  /// Maps a raw json Map to the [QuizQuestionModel].
  factory QuizQuestionModel.fromMap(Map<String, dynamic> map) {
    return QuizQuestionModel(
      id: map['id'] as int,
      questionText: map['questionText'] as String,
      options: List<String>.from(map['options'] as List),
      explanation: map['explanation'] as String,
      correctOptionIndex: map['correctOptionIndex'] as int,
    );
  }

  /// Converts this [QuizQuestionModel] to a raw JSON Map.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'questionText': questionText,
      'options': options,
      'explanation': explanation,
      'correctOptionIndex': correctOptionIndex,
    };
  }
}
