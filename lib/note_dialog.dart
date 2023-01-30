import 'package:flutter/material.dart';

import 'gustave/network/server_caller.dart';
import 'gustave/widgets/confirmation_dialog.dart';
import 'gustave/widgets/text_fields.dart';

import 'notes_logic.dart';
import 'note.dart';

abstract class NoteDialog {
  BuildContext context;
  abstract final String title;
  abstract final String hint;
  abstract final String buttonText;
  abstract final Function action;
  int? id;
  String? text;

  NoteDialog(
    this.context, {
    this.id = -1,
    this.text = "",
  });

  Future<String?> show() {
    var controller = TextEditingController(text: text);
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
  }
}

class AddNoteDialog extends NoteDialog {
  final String title = "Create new note";
  final String hint = "Text here";
  final String buttonText = "Create";
  final Function action = createNote;

  AddNoteDialog(BuildContext context) : super(context);
}

class EditNoteDialog extends NoteDialog {
  final String title = "Edit note";
  final String hint = "Text here";
  final String buttonText = "Edit";
  final Function action = editNote;

  EditNoteDialog(BuildContext context, Note note)
      : super(context, id: note.id, text: note.text);
}

class RemoveNodeDialog extends ConfirmationDialogue {
  final String title = "Are you sure, you want to delete note?";
  final String buttonText = "Delete";
  final Note note;

  RemoveNodeDialog(BuildContext context, this.note) : super(context);

  @override
  void onPressed() {
    ServerCallerWrapper(deleteNote, "/main", "/main")
        .callServer(context, [note.id]);
  }
}
