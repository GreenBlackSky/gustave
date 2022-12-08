import 'package:flutter/material.dart';

import 'widgets/loading_animation.dart';
import 'widgets/common/common.dart';

import 'package:coin_client/network/notes_logic.dart';
import 'package:coin_client/network/user_logic.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final LoadingArgs args =
        ModalRoute.of(context).settings.arguments as LoadingArgs;

    return Scaffold(body: buildForm(Loader(args: args), 1.0));
  }
}

class Loader extends StatefulWidget {
  final LoadingArgs args;
  Loader({Key key, @required this.args}) : super(key: key);

  @override
  _LoaderState createState() {
    return _LoaderState();
  }
}

class _LoaderState extends State<Loader> with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    this.loadDataFromServer();
    this.controller =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    this.animation =
        Tween<double>(begin: 10, end: 100).animate(this.controller);
    this.controller.forward();
    this.controller.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) =>
      LoadingAnimation(animation: this.animation);

  @override
  void dispose() {
    this.controller.dispose();
    super.dispose();
  }

  Future<void> loadDataFromServer() async {
    String endpoint = "/notes";
    String errorEndpoint = "/notes";
    try {
      switch (widget.args.type) {
        case LoadingType.REGISTER:
          errorEndpoint = "/signup";
          await loadDataFromServerOnRegister(
              widget.args.name, widget.args.password);
          break;
        case LoadingType.LOGIN:
          errorEndpoint = "/login";
          await loadDataFromServerOnLogin(
              widget.args.name, widget.args.password);
          break;
        case LoadingType.EDIT_USER:
          endpoint = "/settings";
          errorEndpoint = "/settings";
          await editUser(
              widget.args.name, widget.args.password, widget.args.newPassword);
          break;
        case LoadingType.CREATE_NOTE:
          await createNote(widget.args.text);
          break;
        case LoadingType.EDIT_NOTE:
          await editNote(widget.args.id, widget.args.text);
          break;
        case LoadingType.DELETE_NOTE:
          await deleteNote(widget.args.id);
          break;
      }
    } catch (e) {
      displayError(this.context, e.toString());
      Navigator.of(this.context).pushReplacementNamed(errorEndpoint);
      return;
    }
    Navigator.of(this.context).pushReplacementNamed(endpoint);
  }
}
