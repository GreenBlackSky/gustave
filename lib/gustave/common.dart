import 'package:flutter/material.dart';

DateTime dateFromTimestamp(int timestamp) {
  return DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
}

int timestampFromDateTime(DateTime dateTime) {
  return dateTime.millisecondsSinceEpoch ~/ 1000;
}

String dateToString(DateTime date) {
  return "${date.day}/${date.month}/${date.year}";
}

String timestampToString(int timestamp) {
  var date = dateFromTimestamp(timestamp);
  return "${date.day}/${date.month}/${date.year}";
}

// TODO remove
enum LoadingType {
  REGISTER,
  LOGIN,
  EDIT_USER,
  CREATE_NOTE,
  EDIT_NOTE,
  DELETE_NOTE,
}

class LoadingArgs {
  final LoadingType type;
  final String name;
  final String text;
  final String password;
  final String newPassword;
  final int id;
  final int id2;
  final int id3;
  final int diff;
  final DateTime dateTime;
  final String description;
  final String endpoint;
  final Color color;

  LoadingArgs(this.type,
      {this.name = "",
      this.text = "",
      this.password = "",
      this.newPassword = "",
      this.id = -1,
      this.id2 = -1,
      this.id3 = -1,
      this.diff = 0,
      DateTime dateTime,
      DateTime startTime,
      DateTime endTime,
      this.description = '',
      this.endpoint = '',
      this.color = Colors.black})
      : this.dateTime = dateTime ?? DateTime.now();
}
