# WebQuiz

WebQuiz is a modern, premium, and fully responsive quiz application built using the Flutter framework. It provides a pixel-perfect, high-fidelity layout optimized for large desktop/web viewports and compact mobile screens.

---

## 🚀 Key Features

*   **Vibrant User Interface**: Modern Material 3 specifications with a gorgeous, high-fidelity HSL/RGB palette and glassmorphism.
*   **Fully Responsive Layout**:
    *   **Desktop/Web view**: Uses a split-pane layout with the quiz card on the left and a dynamic question navigation grid on the right.
    *   **Mobile view**: Stacks views vertically and formats navigation circles into a wrapping/compact grid.
*   **Interactive Simulation**:
    *   Fluid question-by-question navigation (Next and Prev actions).
    *   Jump-to-question navigation by clicking/tapping index circles in the progress grid.
    *   Instant feedback with explanation overlays once an option is selected.
*   **Dynamic Layout Resize**: 
    *   Progress grid column counts adjust dynamically using a `SliverGridDelegateWithMaxCrossAxisExtent` delegate so that buttons wrap cleanly instead of shrinking when the browser window width is resized.
*   **Network API Integration**:
    *   Fetches 30 high-fidelity multiple-choice questions from the **OpenTDB Trivia API** using a generated Chopper client.
*   **Offline Local Fallback**:
    *   Gracefully falls back to offline local questions (`mockQuestionsList`) under network failure, 404/500 API responses, or no-internet scenarios.
*   **Premium Skeleton Loaders**:
    *   Integrates **Skeletonizer** loading states at the individual component level (Banner, Card, Grid) to create a beautiful, modern transition as data loads.
*   **Dynamic Theme Toggle**: Quick light/dark mode switcher powered by a generated Riverpod state notifier.
*   **Progress Persistence**: Automatically caches selection choices locally using Hive database clients; answers are locked upon submission and retained across restarts.

---

## 🛠️ Technology Stack

| Technology | Purpose |
| :--- | :--- |
| **Flutter SDK** | Cross-platform UI toolkit targeting Web and Mobile viewports. |
| **Chopper Client** | Network HTTP client with built-in converters and logging interceptors. |
| **Talker Logger** | High-fidelity console logging of HTTP queries and network exceptions. |
| **Skeletonizer** | Modern placeholder loader system animating components during fetches. |
| **Freezed & JSON Serializable** | Immutable model definition generation with JSON mapping helpers. |
| **Riverpod (v3)** | Modern reactive state management using code generation (`riverpod_generator`). |
| **GoRouter (v17)** | Declarative path-based web routing configuration. |
| **Hive DB / SharedPreferences** | Fast local storage engines for state and answer persistence. |

---

## 📐 Clean Architecture & Directory Structure

The project follows a structured, modular **Clean Architecture** directory scheme:

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
    │       ├── data/        # Data Layer (Remote API + Local Storage)
    │       │   ├── datasources/   # Local Hive Storage and Remote Chopper datasource implementations
    │       │   ├── models/        # Data models mapping raw responses via Freezed/JSON Serializable
    │       │   └── repositories/  # Coordinator repositories handling local fallbacks
    │       ├── domain/      # Domain Layer (Pure Business Logic)
    │       │   ├── entities/      # Core business entities (QuizQuestion)
    │       │   ├── repositories/  # Repository contracts/interfaces
    │       │   └── usecases/      # Single-responsibility use cases (GetQuestions, SaveAnswer, ResetQuiz, etc.)
    │       └── presentation/# Presentation Layer
    │           ├── notifiers/     # State notifiers managing UI logic (QuizNotifier, ThemeModeNotifier)
    │           └── view/          # Responsive widgets (QuizWebView, QuizMobileView)
    ├── outer_layer/         # Core system infrastructure and routing layers
    │   ├── clients/         # Storage (Hive) and Network API clients
    │   ├── network/         # Chopper endpoints & custom JSON response converters
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
The `QuizNotifier` coordinates these use cases, managing the state transitions and loading remote questions with local fallback logic:
```dart
@riverpod
class QuizNotifier extends _$QuizNotifier {
  @override
  QuizState build() {
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
Generate code for Freezed, JSON Serializer, Riverpod, and Chopper annotations:
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
Verify widget layouts, navigation events, API network fallbacks, and state mutations:
```bash
flutter test
```
The testing suite includes viewport simulation tests for desktop and mobile layouts, simulating real-user answer selection, verification flow, and progress overrides.
