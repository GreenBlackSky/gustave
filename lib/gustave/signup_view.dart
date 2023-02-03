import 'package:flutter/material.dart';

import 'app_data.dart';
import 'user_network.dart';
import 'network/server_caller.dart';
import 'widgets/common_widget.dart';

// TODO google and facebook integration
// TODO Store token in device/browser
class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(leading: new Container(), title: Text(appData.appName)),
        backgroundColor: Colors.grey[200],
        body: CommonForm(context, SignUpForm()));
  }
}

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _nameController = TextEditingController();
  final _passController1 = TextEditingController();
  final _passController2 = TextEditingController();
  final _serverCaller =
      ServerCallerWrapper(loadDataFromServerOnRegister, "/main", "/signup");
  final _formKey = GlobalKey<FormState>();

  void _signup() {
    if (_formKey.currentState!.validate()) {
      _serverCaller.callServer(
        context,
        [this._nameController.value.text, this._passController1.value.text],
      );
    }
  }

  String? _validateSecondPassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter password";
    }
    if (value != this._passController1.value.text) {
      return "Passwords must be identical";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text('Sign up', style: Theme.of(context).textTheme.headlineMedium),
          BasicTextField("Name", this._nameController),
          ObscuredTextField("Password", this._passController1),
          ObscuredValidatedTextField(
            "Repeat password",
            this._passController2,
            _validateSecondPassword,
          ),
          ButtonBar(alignment: MainAxisAlignment.spaceEvenly, children: [
            Button("Sign up", _signup),
            Button(
              "Already have an account",
              () {
                Navigator.of(context).pushReplacementNamed('/login');
              },
            ),
          ])
        ],
      ),
    );
  }
}
