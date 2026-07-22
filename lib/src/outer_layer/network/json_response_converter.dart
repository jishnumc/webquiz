import 'dart:async';
import 'package:chopper/chopper.dart';

/// Network response JSON converter.
class JsonResponseConverter extends JsonConverter {
  /// Creates the [JsonResponseConverter].
  const JsonResponseConverter();

  @override
  FutureOr<Response<BodyType>> convertResponse<BodyType, InnerType>(
    Response response,
  ) {
    return super.convertResponse<BodyType, InnerType>(response);
  }
}
