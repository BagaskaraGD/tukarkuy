class Config {
  static final Config _instance = Config._internal();

  factory Config() => _instance;

  Config._internal();

  static const String baseUrl = "https://92c2b8a8e306.ngrok-free.app/api";
}
