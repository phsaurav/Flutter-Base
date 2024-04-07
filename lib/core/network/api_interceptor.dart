import 'package:dio/dio.dart';

/// A class that provides methods to add interceptors to a Dio instance for API requests.
class ApiInterceptor {
  /// Adds interceptors to the provided Dio instance.
  ///
  /// The [dio] parameter is the Dio instance to which the interceptors will be added.
  /// The [token] parameter is an optional authentication token to be included in the request headers.
  ///
  /// Returns the modified Dio instance with the added interceptors.
  static Dio addInterceptors(Dio dio, String? token) {
    return dio
      ..interceptors.add(
        InterceptorsWrapper(
            onRequest: (RequestOptions options, _) =>
                requestInterceptor(options, token),
            onError: (DioException e, _) async {
              return e.response?.data;
            }),
      );
  }

  /// Intercepts and modifies the request options before the request is sent.
  ///
  /// The [options] parameter is the original request options.
  /// The [token] parameter is an optional authentication token to be included in the request headers.
  ///
  /// Returns the modified request options.
  static dynamic requestInterceptor(
      RequestOptions options, String? token) async {
    //Add header values.
    // var requestHeaders = [
    //   const MapEntry('App-Locale', ''),
    //   const MapEntry('Package-Name', ''),
    //   const MapEntry('Apk-Version', ''),
    //   const MapEntry('Time-Zone', ''),
    // ];
    options.headers.addAll({"Authorization": "Bearer: $token"});
    return options;
  }
}
