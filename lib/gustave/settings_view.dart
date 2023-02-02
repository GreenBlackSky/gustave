import 'package:flutter/material.dart';

import 'user_network_logic.dart';
import 'network/server_caller.dart';
import 'widgets/common_widget.dart';
import 'widgets/common_view.dart';
import 'storage.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CommonView(
      "Settings",
      CommonForm(SettingsWidget()),
    );
  }
}

class SettingsWidget extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

// TODO dark theme
class _SettingsState extends State<SettingsWidget> {
  final nameController = TextEditingController(text: storage.userName);
  final oldPassController = TextEditingController();
  final newPassController = TextEditingController();
  final newPass2Controller = TextEditingController();
  final _serverCaller = ServerCallerWrapper(editUser, "/settings", "/settings");
  final _formKey = GlobalKey<FormState>();

  void _sendRequest() {
    if (this._formKey.currentState!.validate()) {
      _serverCaller.callServer(context, [
        nameController.value.text,
        oldPassController.value.text,
        newPassController.value.text
      ]);
    }
  }

  String? _validateFirstPassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter password";
    }
    return null;
  }

  String? _validateSecondPassword(String? value) {
    if (value != newPassController.value.text) {
      return "Passwords must be identical";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: this._formKey,
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          Text("Change name:", style: Theme.of(context).textTheme.titleLarge),
          BasicTextField("Name", nameController),
          Text(
            "Change password:",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          ObscuredValidatedTextField(
            "Current password",
            oldPassController,
            this._validateFirstPassword,
          ),
          ObscuredTextField("New password", newPassController),
          ObscuredValidatedTextField(
            "Repeat new password",
            newPass2Controller,
            this._validateSecondPassword,
          ),
          Button("Apply", this._sendRequest)
        ]));
  }
}
