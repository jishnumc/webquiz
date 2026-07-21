import '../repositories/quiz_repository.dart';

/// A usecase that resets all answers and wipes local storage progress.
class ResetQuizUseCase {
  /// Creates the [ResetQuizUseCase].
  const ResetQuizUseCase(this._repository);

  final QuizRepository _repository;

  /// Executes the usecase.
  Future<void> call() {
    return _repository.resetQuiz();
  }
}
