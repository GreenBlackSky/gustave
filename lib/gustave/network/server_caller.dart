import 'package:flutter/material.dart';

class LoadingArgs {
  final Function method;
  final List<dynamic> args;
  final String endpoint;
  final String errorEndpoint;

  LoadingArgs(this.method, this.args, this.endpoint, this.errorEndpoint);
}

class ServerCallerWrapper {
  final Function _method;
  final String _endpoint;
  final String _errorEndpoint;

  ServerCallerWrapper(this._method, this._endpoint, this._errorEndpoint);

  void callServer(BuildContext context, List<dynamic> args) {
    Navigator.pushNamed(context, "/loading",
        arguments: LoadingArgs(_method, args, _endpoint, _errorEndpoint));
  }
}
