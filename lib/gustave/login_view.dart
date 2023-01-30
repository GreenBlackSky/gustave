import 'package:flutter/material.dart';

import 'network/server_caller.dart';
import 'widgets/common_widget.dart';
import 'widgets/text_fields.dart';
import 'user_network_logic.dart';

class LogInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(leading: new Container(), title: Text("COIN")),
        backgroundColor: Colors.grey[200],
        body: buildForm(LogInForm(), 0.3));
  }
}

class LogInForm extends StatefulWidget {
  @override
  _LogInFormState createState() => _LogInFormState();
}

class _LogInFormState extends State<LogInForm> {
  final _nameController = TextEditingController();
  final _passController = TextEditingController();
  final _serverCaller =
      ServerCallerWrapper(loadDataFromServerOnRegister, "/main", "/login");
  final _formKey = GlobalKey<FormState>();

  void _login() {
    if (_formKey.currentState!.validate()) {
      _serverCaller.callServer(context, [
        this._nameController.value.text,
        this._passController.value.text,
      ]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: this._formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text('Log in', style: Theme.of(context).textTheme.headline4),
          buildTextField(this._nameController, "Name"),
          buildTextField(this._passController, "Password", obscure: true),
          ButtonBar(alignment: MainAxisAlignment.spaceEvenly, children: [
            buildButton("Log in", _login),
            buildButton("Don't have an account", () {
              Navigator.of(context).pushNamed('/signup');
            })
          ])
        ],
      ),
    );
  }
}
