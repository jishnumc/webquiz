import '../entities/quiz_question.dart';

/// The contract interface defining data operations for the Quiz repository.
abstract class QuizRepository {
  /// Fetches the complete quiz question entities list.
  Future<List<QuizQuestion>> getQuestions();

  /// Fetches a mapping of previously saved question IDs to user selected options.
  Future<Map<int, int>> getSavedAnswers();

  /// Saves the selection choice of an option index for a question.
  Future<void> saveAnswer(int questionId, int optionIndex);

  /// Resets all answers and wipes local storage progress.
  Future<void> resetQuiz();
}
