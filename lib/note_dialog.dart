import 'package:flutter/material.dart';
import 'package:gustave/gustave/network/server_caller.dart';

import 'package:gustave/gustave/storage.dart';
import 'package:gustave/notes_logic.dart';

import 'gustave/widgets/confirmation_dialog.dart';
import 'gustave/widgets/text_fields.dart';

class NoteDialog {
  String title;
  String hint;
  String buttonText;
  Function action;
  int id;
  String text;

  NoteDialog({
    this.title = "",
    this.hint = "",
    this.buttonText = "",
    this.action,
    this.id = -1,
    this.text = "",
  });

  Future<String> Function() show(BuildContext context) {
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
}

class AddNoteDialog extends NoteDialog {
  final title = "Create new note";
  final hint = "Text here";
  final buttonText = "Create";
  final action = createNote;
}

class EditNoteDialog extends NoteDialog {
  final title = "Edit note";
  final hint = "Text here";
  final buttonText = "Edit";
  final action = editNote;

  Future<String> Function() showDialog(BuildContext context, Note note) {
    id = note.id;
    text = note.text;
    return super.show(context);
  }
}

class RemoveNodeDialog extends NoteDialog {
  final title = "Delete note";
  final hint = "Text here";
  final buttonText = "Edit";
  final action = deleteNote;
  final text = "Are you sure you want to delete note?";

  Future<String> Function() showDialog(BuildContext context, Note note) {
    id = note.id;
    text = note.text;
    return confirmDialogMethod(context, text, title, () {
      ServerCallerWrapper(action, "/main", "/main").callServer(context, [id]);
    });
  }
}
