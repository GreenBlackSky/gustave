import 'package:flutter/material.dart';

import 'gustave/storage.dart';
import 'gustave/widgets/common_widget.dart';
import 'gustave/widgets/common_view.dart';
import 'gustave/widgets/element_list.dart';

import 'note_dialog.dart';

class NotesListView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NotesListViewState();
}

class _NotesListViewState extends State<NotesListView> {
  @override
  Widget build(BuildContext context) {
    return CommonView(
      "Notes",
      CommonForm(context, NotesList()),
      floatingActionButton: FloatingActionButton(
          onPressed: AddNoteDialog(context).show,
          child: Icon(Icons.add),
          tooltip: "Add new note"),
    );
  }
}

class NotesList extends ElementsList {
  final List<dynamic> elements = storage.getStorage("notes");

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
