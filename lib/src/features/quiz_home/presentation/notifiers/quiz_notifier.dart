import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:webquiz/src/outer_layer/clients/api_client.dart';
import 'package:webquiz/src/outer_layer/clients/storage_client.dart';

// Domain Imports
import '../../domain/entities/quiz_question.dart';
import '../../domain/repositories/quiz_repository.dart';
import '../../domain/usecases/get_questions_usecase.dart';
import '../../domain/usecases/get_saved_answers_usecase.dart';
import '../../domain/usecases/save_answer_usecase.dart';
import '../../domain/usecases/reset_quiz_usecase.dart';

// Data Imports
import '../../data/datasources/quiz_local_data_source.dart';
import '../../data/datasources/quiz_remote_data_source.dart';
import '../../data/models/quiz_question_model.dart';
import '../../data/repositories/quiz_repository_impl.dart';

part 'quiz_notifier.g.dart';

/// Exposes the local data source instance provider.
@riverpod
QuizLocalDataSource quizLocalDataSource(Ref ref) {
  return QuizLocalDataSourceImpl(ref.watch(sharedPreferencesProvider));
}

/// Exposes the remote data source instance provider.
@riverpod
QuizRemoteDataSource quizRemoteDataSource(Ref ref) {
  return QuizRemoteDataSourceImpl(ref.watch(apiClientProvider));
}

/// Exposes the Repository mapping contract implementation provider.
@riverpod
QuizRepository quizRepository(Ref ref) {
  return QuizRepositoryImpl(
    ref.watch(quizLocalDataSourceProvider),
    ref.watch(quizRemoteDataSourceProvider),
  );
}

/// Exposes the GetQuestionsUseCase provider.
@riverpod
GetQuestionsUseCase getQuestionsUseCase(Ref ref) {
  return GetQuestionsUseCase(ref.watch(quizRepositoryProvider));
}

/// Exposes the GetSavedAnswersUseCase provider.
@riverpod
GetSavedAnswersUseCase getSavedAnswersUseCase(Ref ref) {
  return GetSavedAnswersUseCase(ref.watch(quizRepositoryProvider));
}

/// Exposes the SaveAnswerUseCase provider.
@riverpod
SaveAnswerUseCase saveAnswerUseCase(Ref ref) {
  return SaveAnswerUseCase(ref.watch(quizRepositoryProvider));
}

/// Exposes the ResetQuizUseCase provider.
@riverpod
ResetQuizUseCase resetQuizUseCase(Ref ref) {
  return ResetQuizUseCase(ref.watch(quizRepositoryProvider));
}

/// The state model representing the active quiz session.
class QuizState {
  /// Creates the [QuizState].
  const QuizState({
    required this.currentQuestionIndex,
    required this.selectedAnswers,
    required this.questions,
    required this.isLoading,
  });

  /// The index of the current active question (0 to 19).
  final int currentQuestionIndex;

  /// Map of question IDs to selected option indexes.
  final Map<int, int> selectedAnswers;

  /// Cached loaded list of domain question entities.
  final List<QuizQuestion> questions;

  /// State loading indicator.
  final bool isLoading;

  /// Static list of dummy questions for skeletonizer placeholder rendering.
  static final List<QuizQuestion> dummyQuestions = List.generate(
    30,
    (index) => QuizQuestionModel(
      id: index + 1,
      questionText: 'This is a placeholder question text that is quite long to show a realistic loading skeleton representation.',
      options: const ['Option Placeholder A', 'Option Placeholder B', 'Option Placeholder C', 'Option Placeholder D'],
      explanation: 'This is a placeholder explanation text for skeleton loading.',
      correctOptionIndex: 0,
    ),
  );

  /// Returns a copy of this state with updated properties.
  QuizState copyWith({
    int? currentQuestionIndex,
    Map<int, int>? selectedAnswers,
    List<QuizQuestion>? questions,
    bool? isLoading,
  }) {
    return QuizState(
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      selectedAnswers: selectedAnswers ?? this.selectedAnswers,
      questions: questions ?? this.questions,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

/// A provider notifier managing selection logic and local persistence of the quiz progress using Clean Architecture usecases.
@riverpod
class QuizNotifier extends _$QuizNotifier {
  @override
  QuizState build() {
    // Return loading state initially and dispatch async load tasks.
    final state = QuizState(
      currentQuestionIndex: 0,
      selectedAnswers: const {},
      questions: QuizState.dummyQuestions,
      isLoading: true,
    );

    _initQuizState();

    return state;
  }

  Future<void> _initQuizState() async {
    final questions = await ref.read(getQuestionsUseCaseProvider).call();
    final savedAnswers = await ref.read(getSavedAnswersUseCaseProvider).call();

    state = QuizState(
      currentQuestionIndex: 0,
      selectedAnswers: savedAnswers,
      questions: questions,
      isLoading: false,
    );
  }

  /// Sets the index of the currently active question.
  void setCurrentQuestionIndex(int index) {
    state = state.copyWith(currentQuestionIndex: index);
  }

  /// Selects an answer option for the given question.
  /// Once selected, the answer is locked and cannot be changed.
  Future<void> selectAnswer(int questionId, int optionIndex) async {
    // If already answered, ignore
    if (state.selectedAnswers.containsKey(questionId)) {
      return;
    }

    // Call domain save answer use case
    await ref.read(saveAnswerUseCaseProvider).call(questionId, optionIndex);

    // Update state
    final updatedAnswers = Map<int, int>.from(state.selectedAnswers);
    updatedAnswers[questionId] = optionIndex;
    state = state.copyWith(selectedAnswers: updatedAnswers);
  }

  /// Resets all answers and clears local progress.
  Future<void> resetQuiz() async {
    // Call domain reset quiz use case
    await ref.read(resetQuizUseCaseProvider).call();

    state = state.copyWith(
      currentQuestionIndex: 0,
      selectedAnswers: const {},
    );
  }
}
