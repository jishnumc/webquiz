import '../../../../outer_layer/clients/api_client.dart';
import '../../../../outer_layer/network/quiz_api_service.dart';
import '../../domain/entities/quiz_question.dart';
import '../models/quiz_question_model.dart';

/// Contract defining trivia network operations.
abstract class QuizRemoteDataSource {
  /// Fetches quiz questions from the API client service.
  Future<List<QuizQuestion>> getQuestions();
}

/// Remote data source implementation.
class QuizRemoteDataSourceImpl implements QuizRemoteDataSource {
  /// Creates the [QuizRemoteDataSourceImpl].
  const QuizRemoteDataSourceImpl(this._apiClient);

  final ApiClient _apiClient;

  @override
  Future<List<QuizQuestion>> getQuestions() async {
    final service = _apiClient.getService<QuizApiService>();
    final response = await service.getQuestions(amount: 30, type: 'multiple');

    if (!response.isSuccessful || response.body == null) {
      throw Exception('API request failed: ${response.statusCode}');
    }

    final data = response.body as Map<String, dynamic>;
    final results = data['results'] as List<dynamic>? ?? const [];

    final List<QuizQuestion> questions = [];
    for (var i = 0; i < results.length; i++) {
      questions.add(
        QuizQuestionModel.fromApi(
          results[i] as Map<String, dynamic>,
          i + 1,
        ),
      );
    }
    return questions;
  }
}
