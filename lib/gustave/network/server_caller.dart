import 'package:flutter/material.dart';

class LoadingArgs {
  final Function method;
  final List<dynamic> args;
  final String endpoint;
  final String errorEndpoint;

  LoadingArgs(this.method, this.args, this.endpoint, this.errorEndpoint);
}

class ServerCallerWrapper {
  Function _method;
  final String endpoint;
  final String errorEndpoint;

  ServerCallerWrapper(this._method, this.endpoint, this.errorEndpoint);

  void callServer(BuildContext context, List<dynamic> args) {
    Navigator.pushNamed(context, "/loading",
        arguments: LoadingArgs(_method, args, endpoint, errorEndpoint));
  }
}
