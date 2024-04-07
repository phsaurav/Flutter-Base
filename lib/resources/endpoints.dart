import 'package:flutter_base/resources/base_path.dart';

/// A class that defines the endpoints for the API.
class Endpoints {
  static const _base = BasePaths.baseUrl;

  /// The endpoint for the todo API.
  static const todo = "$_base/api/v1/todo/";
}
