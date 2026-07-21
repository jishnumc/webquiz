import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:webquiz/src/features/quiz_home/presentation/view/quiz_home.dart';

part 'router.g.dart';

/// {@template web_quiz_router}
/// A router implementation wrapping [GoRouter] and conforming to [RouterConfig].
/// {@endtemplate}
class WebQuizRouter implements RouterConfig<Object> {
  /// {@macro web_quiz_router}
  WebQuizRouter()
      : _router = GoRouter(
          initialLocation: '/',
          debugLogDiagnostics: true,
          routes: [
            GoRoute(
              path: '/',
              builder: (context, state) => const QuizHome(),
            ),
          ],
        );

  final GoRouter _router;

  @override
  RouterDelegate<Object> get routerDelegate => _router.routerDelegate;

  @override
  RouteInformationParser<Object> get routeInformationParser =>
      _router.routeInformationParser;

  @override
  RouteInformationProvider get routeInformationProvider =>
      _router.routeInformationProvider;

  @override
  BackButtonDispatcher? get backButtonDispatcher => _router.backButtonDispatcher;
}

/// A provider that exposes the application's [WebQuizRouter].
@riverpod
WebQuizRouter appRouter(Ref ref) {
  return WebQuizRouter();
}
