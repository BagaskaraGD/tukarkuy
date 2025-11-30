class Config {
  static final Config _instance = Config._internal();

  factory Config() => _instance;

  Config._internal();

  static const String baseUrl = "https://27ff620d4968.ngrok-free.app/api";
}
