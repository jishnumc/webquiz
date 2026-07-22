import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/quiz_question.dart';

part 'quiz_question_model.freezed.dart';
part 'quiz_question_model.g.dart';

/// The data model extension of the [QuizQuestion] entity.
@freezed
abstract class QuizQuestionModel with _$QuizQuestionModel implements QuizQuestion {
  /// Creates a [QuizQuestionModel].
  const factory QuizQuestionModel({
    required int id,
    required String questionText,
    required List<String> options,
    required String explanation,
    required int correctOptionIndex,
  }) = _QuizQuestionModel;

  const QuizQuestionModel._();

  /// Maps a raw JSON Map to the [QuizQuestionModel].
  factory QuizQuestionModel.fromJson(Map<String, dynamic> json) =>
      _$QuizQuestionModelFromJson(json);

  /// Maps an OpenTDB API response item to [QuizQuestionModel].
  factory QuizQuestionModel.fromApi(Map<String, dynamic> json, int id) {
    final rawQuestion = json['question'] as String? ?? '';
    final rawCorrect = json['correct_answer'] as String? ?? '';
    final rawIncorrect = List<String>.from(json['incorrect_answers'] as List? ?? const []);

    final decodedQuestion = _decodeHtml(rawQuestion);
    final decodedCorrect = _decodeHtml(rawCorrect);
    final decodedIncorrect = rawIncorrect.map(_decodeHtml).toList();

    // Use deterministic sorting for testing stability
    final options = [decodedCorrect, ...decodedIncorrect]..sort();
    final correctOptionIndex = options.indexOf(decodedCorrect);

    final difficulty = json['difficulty'] as String? ?? '';
    final category = json['category'] as String? ?? '';
    final explanation = 'Category: $category | Difficulty: $difficulty | Correct Answer: $decodedCorrect';

    return QuizQuestionModel(
      id: id,
      questionText: decodedQuestion,
      options: options,
      explanation: explanation,
      correctOptionIndex: correctOptionIndex,
    );
  }

  static String _decodeHtml(String input) {
    return input
        .replaceAll('&quot;', '"')
        .replaceAll('&#039;', "'")
        .replaceAll('&amp;', '&')
        .replaceAll('&lt;', '<')
        .replaceAll('&gt;', '>')
        .replaceAll('&deg;', '°')
        .replaceAll('&rsquo;', "'")
        .replaceAll('&lsquo;', "'")
        .replaceAll('&ldquo;', '"')
        .replaceAll('&rdquo;', '"')
        .replaceAll('&hellip;', '...');
  }
}
