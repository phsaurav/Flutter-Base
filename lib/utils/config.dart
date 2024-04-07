/// A class that holds the configuration values for the application.
class AppConfig {
  /// Whether the application is in development mode or not.
  static const devMode = true;

  /// Whether the user is logged in or not.
  static const isLoggedIn = false;

  /// Whether to log HTTP requests or not.
  static const logHttp = true;

  /// The timeout duration for network requests.
  static const timeOut = Duration(seconds: 120);
}
