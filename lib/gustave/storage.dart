class Storagable {}

// TODO multidimentional stuff
class DataStorage {
  String name;
  List<Storagable> stuff = [];
  List<Future<void> Function()> _syncronizers = [];

  void clear() {
    this.name = "";
    this.stuff.clear();
  }

  void addSyncronizer(Future<void> Function() syncronizer) {
    _syncronizers.add(syncronizer);
  }

  Future<void> sync() async {
    for (Future<void> Function() syncronizer in _syncronizers) {
      await syncronizer();
    }
  }
}

var storage = DataStorage();
