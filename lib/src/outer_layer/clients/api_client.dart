import 'package:chopper/chopper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:talker_chopper_logger/talker_chopper_logger.dart';
import 'package:webquiz/src/outer_layer/network/json_response_converter.dart';
import 'package:webquiz/src/outer_layer/network/quiz_api_service.dart';
import 'package:webquiz/src/system/environment.dart';
import 'package:webquiz/src/system/utils/logger.dart';

part 'api_client.g.dart';

/// Exposes the global singleton instance provider for [ApiClient].
@Riverpod(keepAlive: true)
ApiClient apiClient(Ref ref) {
  return ApiClient();
}

/// The central API Client managing chopper services and interceptors.
class ApiClient {
  /// Creates the [ApiClient].
  ApiClient({String? baseUrl})
      : _client = ChopperClient(
          baseUrl: Uri.parse(baseUrl ?? Environment.baseUrl),
          services: [
            QuizApiService.create(),
          ],
          converter: const JsonResponseConverter(),
          interceptors: [
            TalkerChopperLogger(talker: talker),
          ],
        );

  final ChopperClient _client;

  /// Retrieves a registered chopper service provider instance.
  T getService<T extends ChopperService>() => _client.getService<T>();
}
