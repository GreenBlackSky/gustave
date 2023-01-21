import 'package:flutter/material.dart';
import 'package:gustave/gustave/network/server_caller.dart';

import 'package:gustave/gustave/storage.dart';
import 'package:gustave/notes_logic.dart';

import 'gustave/widgets/confirmation_dialog.dart';
import 'gustave/widgets/text_fields.dart';

// TODO rework as class
Future<String> Function() baseNoteDialog(BuildContext context, String title,
    String hint, String buttonText, Function action,
    {int id = -1, String text = ""}) {
  var controller = TextEditingController(text: text);
  return () {
    return showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Text(title),
              content: buildTextField(controller, hint),
              actions: <Widget>[
                TextButton(
                  child: Text(buttonText),
                  onPressed: () {
                    ServerCallerWrapper(action, "/main", "/main")
                        .callServer(context, [controller.value.text, id]);
                  },
                ),
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.pop(context, 'Cancel');
                  },
                ),
              ],
            ));
  };
}

void Function() addNewNoteDialogMethod(BuildContext context) {
  return baseNoteDialog(
    context,
    "Create new note",
    "Text here",
    "Create",
    createNote,
  );
}

void Function() editNoteDialogMethod(BuildContext context, Note note) {
  return baseNoteDialog(context, "Edit note", "Text here", "Edit", editNote,
      id: note.id, text: note.text);
}

void Function() removeNoteDialogMethod(BuildContext context, Note note) {
  return confirmDialogMethod(
      context, "Are you sure you want to delete note?", "Delete note", () {
    ServerCallerWrapper(deleteNote, "/main", "/main")
        .callServer(context, [note.id]);
  });
}
