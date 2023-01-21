class Note {
  String text;
  int id;

  Note(this.id, this.text);
}

// TODO create Storagable class
class DataStorage {
  String name;
  List notes = [];

  void clear() {
    this.name = "";
    this.notes.clear();
  }
}

var storage = DataStorage();
