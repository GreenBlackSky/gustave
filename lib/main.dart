import 'package:flutter/material.dart';

import 'gustave/views/loading_view.dart';
import 'gustave/views/settings_view.dart';
import 'gustave/views/signup_view.dart';
import 'gustave/views/login_view.dart';
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
        '/notes': (context) => NotesListView(),
        '/settings': (context) => SettingsScreen(),
        '/loading': (context) => LoadingScreen()
      },
    );
  }
}
