import 'gustave/storage.dart';

class Note extends Storagable {
  String text;
  int id;

  Note(this.id, this.text);
}
