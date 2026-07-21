import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webquiz/app.dart';
import 'package:webquiz/bootstrap.dart';

void main() async {
  final node = UncontrolledProviderScope(
    container: await bootstrap(),
    child: const App(),
  );

  runApp(node);
}
