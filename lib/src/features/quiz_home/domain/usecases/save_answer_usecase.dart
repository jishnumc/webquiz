import '../repositories/quiz_repository.dart';

/// A usecase that saves the user selection choice for a question.
class SaveAnswerUseCase {
  /// Creates the [SaveAnswerUseCase].
  const SaveAnswerUseCase(this._repository);

  final QuizRepository _repository;

  /// Executes the usecase.
  Future<void> call(int questionId, int optionIndex) {
    return _repository.saveAnswer(questionId, optionIndex);
  }
}
