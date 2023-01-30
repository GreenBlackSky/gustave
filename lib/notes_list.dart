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
        body: CommonForm(NotesList()),
        drawer: AppDrawer(context),
        floatingActionButton: FloatingActionButton(
            onPressed: AddNoteDialog(context).show,
            child: Icon(Icons.add),
            tooltip: "Add new note"));
  }
}

class NotesList extends ElementsList {
  final List<dynamic> elements = storage.stuff;

  @override
  Widget buildListElement(BuildContext context, var note, int index) {
    return ElevatedButton(
      child: buildListElementBase(
          Text(note.text),
          EditNoteDialog(context, note).show,
          RemoveNodeDialog(context, note).show),
      onPressed: () {},
    );
  }
}
