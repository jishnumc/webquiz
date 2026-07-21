# WebQuiz

WebQuiz is a modern, premium, and fully responsive quiz application built using the Flutter framework. It provides a pixel-perfect, high-fidelity layout optimized for both large desktop/web viewports and compact mobile devices.

---

## 🚀 Key Features

*   **Vibrant User Interface**: Matches modern Material 3 specifications with a gorgeous blue background and clean glassmorphism patterns.
*   **Fully Responsive Layout**:
    *   **Desktop/Web view**: Uses a split-pane layout with the quiz card on the left and a 20-question navigation grid on the right.
    *   **Mobile view**: Automatically stacks vertically and formats navigation circles into a compact grid to prevent overflows.
*   **Interactive Simulation**: Supports fluid question navigation, explanation overlays, and interactive multi-choice selections.
*   **Dynamic Theme Toggle**: Clean light/dark mode switcher powered by Riverpod state hooks.

---

## 🛠️ Technology Stack

| Technology | Purpose |
| :--- | :--- |
| **Flutter SDK** | Cross-platform UI toolkit targeting Web and Mobile viewports. |
| **Riverpod (v3)** | Modern reactive state management using code generation (`riverpod_generator`). |
| **GoRouter (v17)** | Declarative path-based web routing configuration. |
| **Shared Preferences** | Local key-value database interface for persistent client storage. |
| **Build Runner** | Code-generation toolchain for generating Riverpod providers. |

---

## 📐 Architecture

The codebase follows a structured, modular **Clean Architecture** directory scheme:

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
    │   └── quiz_home/       # Quiz feature slice containing views and notifiers
    ├── outer_layer/         # Core system infrastructure and routing layers
    │   ├── clients/         # Storage and network API clients
    │   ├── routing/         # GoRouter path declarations
    │   └── utils/           # Shared utility tools & provider observers
    └── system/              # System-level custom bindings (e.g., UI scaling)
```

---

## ⚡ State Management

State is handled using the new **Riverpod v3 code generation** standard.
Legacy providers have been fully replaced with generated notifiers to ensure compile-time safety and optimal performance.

Example implementation for toggling application themes:
```dart
@riverpod
class ThemeModeNotifier extends _$ThemeModeNotifier {
  @override
  ThemeMode build() => ThemeMode.light;

  void toggle() {
    state = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
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
Verify widget layouts and execution flows:
```bash
flutter test
```
