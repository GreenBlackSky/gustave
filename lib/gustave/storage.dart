class Note {
  String text;
  int id;

  Note(this.id, this.text);
}

// TODO separate Notes into child class
class DataStorage {
  String name;
  List notes = [];

  void clear() {
    this.name = "";
    this.notes.clear();
  }
}

var storage = DataStorage();
