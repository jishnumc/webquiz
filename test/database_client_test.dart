import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:webquiz/src/outer_layer/database/database_client.dart';

void main() {
  late DatabaseClient databaseClient;
  late Directory tempDir;

  setUp(() async {
    // Setup temporary directory for Hive testing
    tempDir = await Directory.systemTemp.createTemp('hive_test_dir');
    Hive.init(tempDir.path);
    
    databaseClient = DatabaseClient();
    // Open boxes manually for unit test (without Hive.initFlutter)
    await Hive.openBox<Map>('questions_box');
    await Hive.openBox<dynamic>('answers_box');
  });

  tearDown(() async {
    await Hive.close();
    if (await tempDir.exists()) {
      await tempDir.delete(recursive: true);
    }
  });

  test('DatabaseClient saves, gets and deletes questions and answers correctly', () async {
    final id = databaseClient.generateUuid();
    const questionText = 'What is the capital of France?';
    const options = ['Paris', 'London', 'Berlin', 'Madrid'];
    const correctAnswer = 'Paris';

    // Save
    await databaseClient.saveQuestion(
      id: id,
      questionText: questionText,
      options: options,
      correctAnswer: correctAnswer,
    );

    // Retrieve Question
    final retrievedQuestion = databaseClient.getQuestion(id);
    expect(retrievedQuestion, isNotNull);
    expect(retrievedQuestion!['id'], id);
    expect(retrievedQuestion['questionText'], questionText);
    expect(retrievedQuestion['options'], options);

    // Retrieve Answer
    final retrievedAnswer = databaseClient.getCorrectAnswer(id);
    expect(retrievedAnswer, correctAnswer);

    // Get All
    final allQuestions = databaseClient.getAllQuestions();
    expect(allQuestions.length, 1);

    // Delete
    await databaseClient.deleteQuestion(id);
    expect(databaseClient.getQuestion(id), isNull);
    expect(databaseClient.getCorrectAnswer(id), isNull);
  });
}
