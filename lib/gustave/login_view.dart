import 'package:flutter/material.dart';

import 'app_data.dart';
import 'network/server_caller.dart';
import 'widgets/common_widget.dart';
import 'user_network.dart';

class LogInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(leading: new Container(), title: Text(appData.appName)),
        backgroundColor: Colors.grey[200],
        body: CommonForm(context, LogInForm()));
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
      ServerCallerWrapper(loadDataFromServerOnLogin, "/main", "/login");
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
          Text('Log in', style: Theme.of(context).textTheme.headlineMedium),
          BasicTextField("Name", this._nameController),
          ObscuredTextField("Password", this._passController),
          ButtonBar(
            alignment: MainAxisAlignment.spaceEvenly,
            children: [
              Button("Log in", _login),
              Button(
                "Don't have an account",
                () {
                  Navigator.of(context).pushNamed('/signup');
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
