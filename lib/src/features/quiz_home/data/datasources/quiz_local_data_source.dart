import 'package:shared_preferences/shared_preferences.dart';
import '../models/quiz_question_model.dart';
import 'mock_questions_data.dart';

/// Contract defining database and preference operations for Quiz data.
abstract class QuizLocalDataSource {
  /// Loads the quiz questions model list.
  Future<List<QuizQuestionModel>> getQuestions();

  /// Loads the map of saved user answer selections.
  Future<Map<int, int>> getSavedAnswers();

  /// Persists a selection answer choice local index.
  Future<void> saveAnswer(int questionId, int optionIndex);

  /// Clears out all persistent answer indexes.
  Future<void> resetQuiz();
}

/// A local data source implementation powered by [SharedPreferences].
class QuizLocalDataSourceImpl implements QuizLocalDataSource {
  /// Creates the [QuizLocalDataSourceImpl].
  const QuizLocalDataSourceImpl(this._sharedPreferences);

  final SharedPreferences _sharedPreferences;
  static const String _keyPrefix = 'quiz_selected_answer_';

  @override
  Future<List<QuizQuestionModel>> getQuestions() async {
    // Return localized high-fidelity static items
    return mockQuestionsList;
  }

  @override
  Future<Map<int, int>> getSavedAnswers() async {
    final selectedAnswers = <int, int>{};
    for (final key in _sharedPreferences.getKeys()) {
      if (key.startsWith(_keyPrefix)) {
        final idStr = key.replaceFirst(_keyPrefix, '');
        final id = int.tryParse(idStr);
        if (id != null) {
          final selectedIndex = _sharedPreferences.getInt(key);
          if (selectedIndex != null) {
            selectedAnswers[id] = selectedIndex;
          }
        }
      }
    }
    return selectedAnswers;
  }

  @override
  Future<void> saveAnswer(int questionId, int optionIndex) async {
    await _sharedPreferences.setInt('$_keyPrefix$questionId', optionIndex);
  }

  @override
  Future<void> resetQuiz() async {
    for (final key in _sharedPreferences.getKeys()) {
      if (key.startsWith(_keyPrefix)) {
        await _sharedPreferences.remove(key);
      }
    }
  }
}
