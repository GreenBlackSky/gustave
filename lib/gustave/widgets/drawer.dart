import 'package:flutter/material.dart';

import '../network/server_caller.dart';
import '../app_data.dart';
import '../user_network.dart';
import 'confirmation_dialog.dart';

class LogOutDialog extends ConfirmationDialogue {
  final String title = "Are you sure, you want to log out?";
  final String buttonText = "Log out";
  final ServerCallerWrapper _serverCaller = ServerCallerWrapper(
    logout,
    '/login',
    '/login',
  );

  LogOutDialog(BuildContext context) : super(context);

  @override
  void onPressed() {
    _serverCaller.callServer(context, []);
  }
}

class AppDrawer extends Drawer {
  AppDrawer(BuildContext context) : super(child: getBody(context));

  static Widget getBody(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: getTiles(context),
    );
  }

  static List<Widget> getTiles(BuildContext context) {
    List<Widget> tiles = [];
    for (MapEntry<String, String> e in AppData().views.entries) {
      Widget tile = ListTile(
        title: Text(e.key),
        onTap: () {
          Navigator.pushNamed(context, e.value);
        },
      );
      tiles.add(tile);
    }
    tiles.add(
        ListTile(title: Text("Logout"), onTap: LogOutDialog(context).show));
    return tiles;
  }
}
