import 'package:flutter/material.dart';

import 'gustave/loading_view.dart';
import 'gustave/settings_view.dart';
import 'gustave/signup_view.dart';
import 'gustave/login_view.dart';
import 'notes_list.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Notes app",
      initialRoute: '/login',
      routes: {
        '/login': (context) => LogInScreen(),
        '/signup': (context) => SignUpScreen(),
        '/main': (context) => NotesListView(),
        '/settings': (context) => SettingsScreen(),
        '/loading': (context) => LoadingScreen()
      },
    );
  }
}
