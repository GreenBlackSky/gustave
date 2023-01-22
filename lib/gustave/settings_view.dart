import 'package:flutter/material.dart';

import 'user_network_logic.dart';
import 'network/server_caller.dart';
import 'widgets/common_widget.dart';
import 'widgets/drawer.dart';
import 'storage.dart';
import 'widgets/text_fields.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Settings")),
      drawer: buildDrawer(context),
      body: buildForm(SettingsWidget(), 0.3),
    );
  }
}

class SettingsWidget extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

// TODO dark theme
class _SettingsState extends State<SettingsWidget> {
  final _controllers = {
    "name": TextEditingController(text: storage.name),
    "old_pass": TextEditingController(),
    "new_pass": TextEditingController(),
    "new_pass2": TextEditingController(),
  };
  final _serverCaller = ServerCallerWrapper(editUser, "/settings", "/settings");
  final _formKey = GlobalKey<FormState>();

  void _sendRequest() {
    if (this._formKey.currentState.validate()) {
      _serverCaller.callServer(context, [
        this._controllers["name"].value.text,
        this._controllers["old_pass"].value.text,
        this._controllers["new_pass"].value.text
      ]);
    }
  }

  String _validateFirstPassword(String value) {
    if (value.isEmpty) {
      return "Please enter password";
    }
    return null;
  }

  String _validateSecondPassword(String value) {
    if (value != this._controllers["new_pass"].value.text) {
      return "Passwords must be identical";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: this._formKey,
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          Text("Change name:", style: Theme.of(context).textTheme.headline6),
          buildTextField(this._controllers["name"], "Name"),
          Text("Change password:",
              style: Theme.of(context).textTheme.headline6),
          buildValidatedTextField(this._controllers["old_pass"],
              "Current password", this._validateFirstPassword,
              obscure: true),
          buildTextField(this._controllers["new_pass"], "New password",
              obscure: true),
          buildValidatedTextField(this._controllers["new_pass2"],
              "Repeat new password", this._validateSecondPassword,
              obscure: true),
          buildButton("Apply", this._sendRequest)
        ]));
  }
}
