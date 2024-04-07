import 'package:flutter_base/utils/config.dart';

/// A class that contains base paths used in the application.
class BasePaths {
  /// The base path for image assets.
  static const baseImagePath = "assets/images";

  /// The base path for animation assets.
  static const baseAnimationPath = "assets/animations";

  /// The base path for placeholder assets.
  static const basePlaceholderPath = "assets/placeholders";

  //TODO - Set Production and dummy URL

  /// The base URL for production environment.
  static const baseProdUrl = "http://productionURL.com";

  /// The base URL for testing environment.
  static const baseTestUrl = "https://jsonplaceholder.typicode.com/";

  /// The base URL used in the application.
  static const baseUrl = AppConfig.devMode ? baseTestUrl : baseProdUrl;
}
