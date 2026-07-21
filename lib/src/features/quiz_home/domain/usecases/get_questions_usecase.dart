import '../entities/quiz_question.dart';
import '../repositories/quiz_repository.dart';

/// A usecase that retrieves the list of quiz questions.
class GetQuestionsUseCase {
  /// Creates the [GetQuestionsUseCase].
  const GetQuestionsUseCase(this._repository);

  final QuizRepository _repository;

  /// Executes the usecase.
  Future<List<QuizQuestion>> call() {
    return _repository.getQuestions();
  }
}
