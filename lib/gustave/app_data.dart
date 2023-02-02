class AppData {
  final Map<String, String> views = {};
  late String appName;

  void setName(String name) {
    appName = name;
  }

  void addView(String name, String path) {
    views[name] = path;
  }
}

var appData = AppData();
