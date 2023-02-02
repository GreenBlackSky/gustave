import 'package:flutter/material.dart';

import 'gustave/app_data.dart';
import 'gustave/network/session.dart';
import 'gustave/loading_view.dart';
import 'gustave/login_view.dart';
import 'gustave/settings_view.dart';
import 'gustave/signup_view.dart';
import 'gustave/storage.dart';

import 'notes_list.dart';
import 'notes_network.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    appData.setName("Notes app");
    appData.addView("Notes", "/main");
    appData.addView("Settings", "/settings");
    storage.addStorage("notes");
    storage.addSyncronizer(syncNotes);
    session.init("localhost", 5003);

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
