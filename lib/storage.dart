class Note {
  String text;
  int id;
}

class DataStorage {
  String name;
  int activeNoteIndex = -1;
  List notes = [];

  void clear() {
    this.name = "";
    this.activeNoteIndex = -1;
    this.notes.clear();
  }
}

var storage = DataStorage();
