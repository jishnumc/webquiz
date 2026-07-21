import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'database_client.g.dart';

/// {@template database_client}
/// A client for managing local database operations using Hive.
/// {@endtemplate}
class DatabaseClient {
  static const _uuid = Uuid();

  // Box names
  static const String _questionsBoxName = 'questions_box';
  static const String _answersBoxName = 'answers_box';

  /// Initializes Hive and opens the required boxes.
  Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox<Map>(_questionsBoxName);
    await Hive.openBox<dynamic>(_answersBoxName);
  }

  Box<Map> get _questionsBox => Hive.box<Map>(_questionsBoxName);
  Box<dynamic> get _answersBox => Hive.box<dynamic>(_answersBoxName);

  /// Generates a unique UUID v4.
  String generateUuid() => _uuid.v4();

  /// Saves a question and its options in the questions box, 
  /// and its correct answer in the answers box under the same unique ID.
  Future<void> saveQuestion({
    required String id,
    required String questionText,
    required List<String> options,
    required dynamic correctAnswer,
  }) async {
    final questionData = {
      'id': id,
      'questionText': questionText,
      'options': options,
    };
    await _questionsBox.put(id, questionData);
    await _answersBox.put(id, correctAnswer);
  }

  /// Retrieves a question's data (text and options) by its unique ID.
  Map<String, dynamic>? getQuestion(String id) {
    final data = _questionsBox.get(id);
    if (data == null) return null;
    return Map<String, dynamic>.from(data);
  }

  /// Retrieves the correct answer of a question by its unique ID.
  dynamic getCorrectAnswer(String id) {
    return _answersBox.get(id);
  }

  /// Retrieves all stored questions in a list.
  List<Map<String, dynamic>> getAllQuestions() {
    return _questionsBox.values
        .map((data) => Map<String, dynamic>.from(data))
        .toList();
  }

  /// Deletes a question and its correct answer from the boxes.
  Future<void> deleteQuestion(String id) async {
    await _questionsBox.delete(id);
    await _answersBox.delete(id);
  }

  /// Clears all questions and answers in both boxes.
  Future<void> clearAllData() async {
    await _questionsBox.clear();
    await _answersBox.clear();
  }
}

/// A provider that exposes the [DatabaseClient] instance.
@riverpod
DatabaseClient databaseClient(Ref ref) {
  return DatabaseClient();
}

