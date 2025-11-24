class Config {
  static final Config _instance = Config._internal();

  factory Config() => _instance;

  Config._internal();

  static const String baseUrl = "https://5b246b52be0c.ngrok-free.app/api";
}
