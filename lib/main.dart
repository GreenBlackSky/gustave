import 'package:flutter/material.dart';

import 'views/login_view.dart';
import 'views/signup_view.dart';
import 'views/notes_list.dart';
import 'views/settings_view.dart';
import 'views/loading_view.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "COIN",
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
