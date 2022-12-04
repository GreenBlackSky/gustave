import 'package:flutter/material.dart';

import 'widgets/note_dialog.dart';
import 'widgets/common/common.dart';
import 'widgets/common/element_list.dart';
import 'widgets/drawer.dart';

import 'package:coin_client/storage.dart';

class NotesListView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NotesListViewState();
}

class _NotesListViewState extends State<NotesListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
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
  Widget buildListElement(BuildContext context, var noteJSON, int index) {
    void Function() onEdit = editNoteDialogMethod(context, noteJSON);
    void Function() onRemove;
    if (storage.notes.length > 1) {
      onRemove = removeNoteDialogMethod(context, noteJSON);
    }
    return ElevatedButton(
      child: buildListElementBase(Text(noteJSON['text']), onEdit, onRemove),
      onPressed: () {},
    );
  }
}
