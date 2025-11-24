class Config {
  static final Config _instance = Config._internal();

  factory Config() => _instance;

  Config._internal();

  static const String baseUrl = "https://d5a1d93e1afc.ngrok-free.app/api";
}
