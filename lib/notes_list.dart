import 'package:flutter/material.dart';

import 'package:gustave/note_dialog.dart';
import 'package:gustave/gustave/widgets/common/common_widget.dart';
import 'package:gustave/gustave/widgets/common/element_list.dart';
import 'package:gustave/gustave/widgets/drawer.dart';

import 'package:gustave/gustave/storage.dart';

class NotesListView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NotesListViewState();
}

class _NotesListViewState extends State<NotesListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Notes")),
        body: buildForm(NotesList(), 0.3),
        drawer: buildDrawer(context),
        floatingActionButton: FloatingActionButton(
            onPressed: addNewNoteDialogMethod(context),
            child: Icon(Icons.add),
            tooltip: "Add new note"));
  }
}

class NotesList extends ElementsList {
  final elements = storage.notes;

  @override
  Widget buildListElement(BuildContext context, var note, int index) {
    void Function() onEdit = editNoteDialogMethod(context, note);
    void Function() onRemove = removeNoteDialogMethod(context, note);
    return ElevatedButton(
      child: buildListElementBase(Text(note.text), onEdit, onRemove),
      onPressed: () {},
    );
  }
}
