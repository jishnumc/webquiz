import 'package:chopper/chopper.dart';

part 'quiz_api_service.chopper.dart';

/// Chopper API service mapping to OpenTDB endpoint.
@ChopperApi()
abstract class QuizApiService extends ChopperService {
  /// Factory constructor to bind generated client configurations.
  static QuizApiService create([ChopperClient? client]) =>
      _$QuizApiService(client);

  /// Performs trivia questions fetch actions.
  @Get(path: '/api.php')
  Future<Response> getQuestions({
    @Query('amount') required int amount,
    @Query('type') required String type,
  });
}
