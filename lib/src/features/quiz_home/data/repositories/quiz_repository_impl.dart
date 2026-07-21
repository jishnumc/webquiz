import '../../domain/entities/quiz_question.dart';
import '../../domain/repositories/quiz_repository.dart';
import '../datasources/quiz_local_data_source.dart';

/// Concrete implementation of the [QuizRepository] mapping data resources to domain logic.
class QuizRepositoryImpl implements QuizRepository {
  /// Creates the [QuizRepositoryImpl].
  const QuizRepositoryImpl(this._localDataSource);

  final QuizLocalDataSource _localDataSource;

  @override
  Future<List<QuizQuestion>> getQuestions() async {
    return await _localDataSource.getQuestions();
  }

  @override
  Future<Map<int, int>> getSavedAnswers() async {
    return await _localDataSource.getSavedAnswers();
  }

  @override
  Future<void> saveAnswer(int questionId, int optionIndex) async {
    await _localDataSource.saveAnswer(questionId, optionIndex);
  }

  @override
  Future<void> resetQuiz() async {
    await _localDataSource.resetQuiz();
  }
}
