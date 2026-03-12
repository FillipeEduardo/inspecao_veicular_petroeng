class Urls {
  static const apiBaseUrl = String.fromEnvironment(
    "API_BASE_URL",
    defaultValue: "http://191.252.60.147:6161/api",
  );
}
