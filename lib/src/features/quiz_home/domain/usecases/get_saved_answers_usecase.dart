import '../repositories/quiz_repository.dart';

/// A usecase that retrieves the map of saved answers.
class GetSavedAnswersUseCase {
  /// Creates the [GetSavedAnswersUseCase].
  const GetSavedAnswersUseCase(this._repository);

  final QuizRepository _repository;

  /// Executes the usecase.
  Future<Map<int, int>> call() {
    return _repository.getSavedAnswers();
  }
}
