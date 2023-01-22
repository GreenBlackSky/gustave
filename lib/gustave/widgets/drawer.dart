import 'package:flutter/material.dart';

import '../network/session.dart';
import '../storage.dart';
import 'confirmation_dialog.dart';

class LogOutDialog extends ConfirmationDialogue {
  final String title = "Are you sure, you want to log out?";
  final String buttonText = "Log out";

  LogOutDialog(BuildContext context) : super(context);

  @override
  void onPressed() {
    // TODO use animation
    session.post('logout').catchError((_) {});
    session.clearSession();
    storage.clear();
    Navigator.of(context).pushNamed('/login');
  }
}

Map<String, String> views = {
  // TODO Dynamicly fetch views
  "Notes": "/main",
  "Settings": "/settings",
};

//TODO Inherit custom drawer from Drawer
Widget buildDrawer(BuildContext context) {
  List<Widget> tiles = [];
  for (MapEntry<String, String> e in views.entries) {
    Widget tile = ListTile(
      title: Text(e.key),
      onTap: () {
        Navigator.pushNamed(context, e.value);
      },
    );
    tiles.add(tile);
  }
  tiles.add(ListTile(title: Text("Logout"), onTap: LogOutDialog(context).show));
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: tiles,
    ),
  );
}
