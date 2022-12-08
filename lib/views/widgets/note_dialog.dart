import 'package:coin_client/storage.dart';
import 'package:flutter/material.dart';

import 'common/common.dart';
import 'common/text_fields.dart';
import 'common/confirmation_dialog.dart';

Future<String> Function() baseNoteDialog(BuildContext context, String title,
    String hint, String buttonText, LoadingType action,
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
                    Navigator.pushNamed(context, "/loading",
                        arguments: LoadingArgs(action,
                            text: controller.value.text, id: id));
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
    LoadingType.CREATE_NOTE,
  );
}

void Function() editNoteDialogMethod(BuildContext context, Note note) {
  return baseNoteDialog(
      context, "Edit note", "Text here", "Edit", LoadingType.EDIT_NOTE,
      id: note.id, text: note.text);
}

void Function() removeNoteDialogMethod(BuildContext context, Note note) {
  return confirmDialogMethod(
      context, "Are you sure you want to delete note?", "Delete note", () {
    Navigator.pushNamed(context, "/loading",
        arguments: LoadingArgs(LoadingType.DELETE_NOTE, id: note.id));
  });
}
