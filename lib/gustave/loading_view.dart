import 'package:flutter/material.dart';

import 'widgets/common_widget.dart';
import 'widgets/loading_animation.dart';
import 'network/server_caller.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final LoadingArgs args =
        ModalRoute.of(context)!.settings.arguments as LoadingArgs;

    return Scaffold(body: buildForm(Loader(args: args), 1.0));
  }
}

class Loader extends StatefulWidget {
  final LoadingArgs args;
  Loader({Key? key, required this.args}) : super(key: key);

  @override
  _LoaderState createState() {
    return _LoaderState();
  }
}

class _LoaderState extends State<Loader> with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, this.loadDataFromServer);
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
    try {
      await widget.args.method(widget.args.args);
    } catch (e) {
      displayError(this.context, e.toString());
      Navigator.of(this.context)
          .pushReplacementNamed(widget.args.errorEndpoint);
      return;
    }
    Navigator.of(this.context).pushReplacementNamed(widget.args.endpoint);
  }
}
