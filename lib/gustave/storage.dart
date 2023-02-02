class Storagable {}

class DataStorage {
  String? userName;
  Map<String, List<Storagable>> _storage = {};
  Future<void> Function()? _syncronizer;

  List<Storagable> addStorage(String name) {
    var list = <Storagable>[];
    _storage[name] = list;
    return list;
  }

  List<Storagable> getStorage(String name) {
    assert(_storage.containsKey(name), "No such storage");
    return _storage[name]!;
  }

  void addSyncronizer(Future<void> Function() syncronizer) {
    _syncronizer = syncronizer;
  }

  Future<void> sync() async {
    assert(_syncronizer != null, "No syncronizer provided");
    await _syncronizer!();
  }

  void clear() {
    userName = "";
    for (List<Storagable> s in _storage.values) {
      s.clear();
    }
    _storage.clear();
  }
}

var storage = DataStorage();
