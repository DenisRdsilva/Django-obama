import 'package:flutter/material.dart';
import 'package:frontproj/sqlite.dart';

import './home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Initialize sq-lite
  final db = SqliteDB();
  await db.getPosts();

  /// Runs the app
  return runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter + Django',
      initialRoute: '/',
      routes: {
        '/': (context) => Home(),
      },
    );
  }
}