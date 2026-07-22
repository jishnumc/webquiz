import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webquiz/src/design_system/design_system.dart';
import 'package:webquiz/src/features/quiz_home/presentation/notifiers/theme_notifier.dart';
import 'package:webquiz/src/outer_layer/routing/router.dart';

/// The root application widget.
class App extends ConsumerWidget {
  /// Creates the root application widget.
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp.router(
      title: 'WebQuiz',
      themeMode: themeMode,
      theme: const AppThemeLight(TextThemeNative()).themeData,
      darkTheme: const AppThemeDark(TextThemeNative()).themeData,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
