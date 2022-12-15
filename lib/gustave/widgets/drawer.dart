import 'package:flutter/material.dart';

import '../network/session.dart';
import '../storage.dart';

import 'common/confirmation_dialog.dart';

Map<String, String> views = {
  // TODO Dynamicly fetch views
  "Notes": "/notes",
  "Settings": "/settings",
};

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
  tiles.add(ListTile(
      title: Text("Logout"),
      onTap: confirmDialogMethod(context, "Are you sure, you want to log out?",
          "Log out", logoutMethod(context))));
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: tiles,
    ),
  );
}

void Function() logoutMethod(BuildContext context) {
  return () {
    session.post('logout').catchError((_) {});
    session.clearSession();
    storage.clear();
    Navigator.of(context).pushNamed('/login');
  };
}
