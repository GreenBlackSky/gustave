import 'package:flutter/material.dart';

import 'gustave/storage.dart';
import 'gustave/widgets/common_widget.dart';
import 'gustave/widgets/drawer.dart';
import 'gustave/widgets/element_list.dart';

import 'note_dialog.dart';

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
            onPressed: AddNoteDialog().show(context),
            child: Icon(Icons.add),
            tooltip: "Add new note"));
  }
}

class NotesList extends ElementsList {
  final elements = storage.notes;

  @override
  Widget buildListElement(BuildContext context, var note, int index) {
    void Function() onEdit = EditNoteDialog().showDialog(context, note);
    void Function() onRemove = RemoveNodeDialog().showDialog(context, note);
    return ElevatedButton(
      child: buildListElementBase(Text(note.text), onEdit, onRemove),
      onPressed: () {},
    );
  }
}
