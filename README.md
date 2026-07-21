# WebQuiz

WebQuiz is a modern, premium, and fully responsive quiz application built using the Flutter framework. It provides a pixel-perfect, high-fidelity layout optimized for large desktop/web viewports and compact mobile screens.

---

## 🚀 Key Features

*   **Vibrant User Interface**: Modern Material 3 specifications with a gorgeous, high-fidelity HSL/RGB palette and glassmorphism.
*   **Fully Responsive Layout**:
    *   **Desktop/Web view**: Uses a split-pane layout with the quiz card on the left and a 20-question navigation grid on the right.
    *   **Mobile view**: Stacks views vertically and formats navigation circles into a scrollable/compact grid.
*   **Interactive Simulation**:
    *   Fluid question-by-question navigation (Next and Prev actions).
    *   Jump-to-question navigation by clicking/tapping index circles in the progress grid.
    *   Instant feedback with explanation overlays once an option is selected.
*   **Interactive Progress Tracker**:
    *   Visual progress indicator for answered/unanswered states.
    *   Question selector circles highlight as **Green** (for correct answers) or **Red** (for incorrect answers) based on the user's choices.
*   **Dynamic Theme Toggle**: Quick light/dark mode switcher powered by a generated Riverpod state notifier.
*   **Progress Persistence**: Automatically caches selection choices locally; answers are locked upon submission and retained across hot restarts.

---

## 🛠️ Technology Stack

| Technology | Purpose |
| :--- | :--- |
| **Flutter SDK** | Cross-platform UI toolkit targeting Web and Mobile viewports. |
| **Riverpod (v3)** | Modern reactive state management using code generation (`riverpod_generator`). |
| **GoRouter (v17)** | Declarative path-based web routing configuration. |
| **Shared Preferences** | Persistent storage client used to save and retrieve user quiz responses. |
| **Build Runner** | Code-generation toolchain for generating Riverpod providers. |

---

## 📐 Clean Architecture & Directory Structure

The project has been refactored into a structured, modular **Clean Architecture** directory scheme:

```
lib/
├── bootstrap.dart           # App initialization, scale bindings & dependency setups
├── main.dart                # Main entry point running UncontrolledProviderScope
├── app.dart                 # Root widget registering routes, themes, and observers
└── src/
    ├── design_system/       # Shared UI tokens (colors, spacing, themes, typography)
    │   ├── colours/         # Light, dark, and custom HSL color extensions
    │   ├── spacing/         # Constant spacing metrics (x3s, xxs, xs, sm, md, etc.)
    │   ├── themes/          # Custom light and dark ThemeData configurations
    │   └── typography/      # TextTheme properties optimized for multiple screens
    ├── features/            # Feature-sliced domain features
    │   └── quiz_home/       # Quiz feature slice following Clean Architecture:
    │       ├── data/        # Data Layer
    │       │   ├── datasources/   # Handles local storage (SharedPreferences) and static mock questions data
    │       │   ├── models/        # Data models mapping raw formats to domain entities
    │       │   └── repositories/  # Implementations of domain repository interfaces
    │       ├── domain/      # Domain Layer (Pure Business Logic)
    │       │   ├── entities/      # Core business entities (QuizQuestion)
    │       │   ├── repositories/  # Repository contracts/interfaces
    │       │   └── usecases/      # Single-responsibility use cases (GetQuestions, SaveAnswer, ResetQuiz, etc.)
    │       └── presentation/# Presentation Layer
    │           ├── controller/    # State notifiers managing UI logic and state (QuizNotifier, ThemeModeNotifier)
    │           └── view/          # Responsive widgets (QuizWebView, QuizMobileView)
    ├── outer_layer/         # Core system infrastructure and routing layers
    │   ├── clients/         # Storage and network API clients
    │   ├── routing/         # GoRouter path declarations
    │   └── utils/           # Shared utility tools & provider observers
    └── system/              # System-level custom bindings (e.g., UI scaling)
```

---

## ⚡ State Management & Use Cases

State is handled using the new **Riverpod v3 code generation** standard. Use cases act as the entry point for the presentation layer to interact with the repository:

### 1. Domain Use Case Example
Each business action is encapsulated in a dedicated use case class, keeping logic isolated and testable:
```dart
class SaveAnswerUseCase {
  const SaveAnswerUseCase(this._repository);

  final QuizRepository _repository;

  Future<void> call(int questionId, int optionIndex) {
    return _repository.saveAnswer(questionId, optionIndex);
  }
}
```

### 2. Riverpod Quiz State Notifier
The `QuizNotifier` coordinates these use cases, managing the state transitions and reloading progress on start:
```dart
@riverpod
class QuizNotifier extends _$QuizNotifier {
  @override
  QuizState build() {
    final state = QuizState(
      currentQuestionIndex: 0,
      selectedAnswers: const {},
      questions: const [],
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

  Future<void> selectAnswer(int questionId, int optionIndex) async {
    if (state.selectedAnswers.containsKey(questionId)) return;

    await ref.read(saveAnswerUseCaseProvider).call(questionId, optionIndex);

    final updatedAnswers = Map<int, int>.from(state.selectedAnswers);
    updatedAnswers[questionId] = optionIndex;
    state = state.copyWith(selectedAnswers: updatedAnswers);
  }
}
```

---

## 💻 Getting Started

To run the application locally, follow these steps:

### 1. Prerequisite Setup
Ensure you have the Flutter SDK installed on your system.

### 2. Fetch Dependencies
Install package dependencies defined in the project:
```bash
flutter pub get
```

### 3. Generate Code
Generate code for Riverpod and other annotation bindings:
```bash
dart run build_runner build --delete-conflicting-outputs
```

### 4. Run the Project
Start the development server or run on your connected device:
```bash
flutter run -d chrome  # For Web browsers
flutter run            # For Mobile / Desktop devices
```

### 5. Run Tests
Verify widget layouts, navigation events, and state mutations:
```bash
flutter test
```
The testing suite includes viewport simulation tests for desktop and mobile layouts, simulating real-user answer selection, verification flow, and progress overrides.
