import 'package:dio/dio.dart';
import 'package:flutter_base/common/presentation/controller/common_providers.dart';
import 'package:flutter_base/core/network/api_interceptor.dart';
import 'package:flutter_base/resources/base_path.dart';
import 'package:flutter_base/utils/config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../errors/failure.dart';

/// A callback that returns a Dio response, presumably from a Dio method
/// it has called which performs an HTTP request, such as `dio.get()`,
/// `dio.post()`, etc.
typedef HttpLibraryMethod<T> = Future<Response<T>> Function();

/// Function which takes a Dio response object and an exception and returns
/// an optional [AppHttpClientFailure], optionally mapping the response
/// to a custom exception.
typedef ResponseExceptionMapper = APIFailure? Function<T>(
  Response<T>,
  Exception,
);

/// Provider for the [ApiClient] instance.
final apiClientProvider = StateProvider((ref) {
  final baseClient = Dio(BaseOptions(
    connectTimeout: AppConfig.timeOut,
    receiveTimeout: AppConfig.timeOut,
    baseUrl: BasePaths.baseUrl,
  ));
  final authToken = ref.watch(authTokenProvider);
  final client = ApiInterceptor.addInterceptors(baseClient, authToken);
  return ApiClient(client: client);
});

/// A class that provides methods for making HTTP requests using Dio.
class ApiClient {
  final Dio _client;

  /// If provided, this function which will be invoked when a response exception
  /// occurs, allowing the response exception to be mapped to a custom
  /// exception class which extends [AppHttpClientFailure].
  final ResponseExceptionMapper? exceptionMapper;

  /// Constructs an instance of [ApiClient] with the provided Dio client and
  /// optional exception mapper.
  ApiClient({required Dio client, this.exceptionMapper}) : _client = client;

  /// Sends an HTTP GET request.
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) {
    return _mapException(
      () => _client.get(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      ),
    );
  }

  /// Sends an HTTP POST request.
  Future<Response<T>> post<T>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) {
    return _mapException(
      () => _client.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      ),
    );
  }

  /// Sends an HTTP PUT request.
  Future<Response<T>> put<T>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) {
    return _mapException(
      () => _client.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      ),
    );
  }

  /// Sends an HTTP HEAD request.
  Future<Response<T>> head<T>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return _mapException(
      () => _client.head(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      ),
    );
  }

  /// Sends an HTTP DELETE request.
  Future<Response<T>> delete<T>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return _mapException(
      () => _client.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      ),
    );
  }

  /// Sends an HTTP PATCH request.
  Future<Response<T>> patch<T>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) {
    return _mapException(
      () => _client.patch(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      ),
    );
  }

  // Map Dio exceptions (and any other exceptions) to an exception type
  // supported by our application.
  Future<Response<T>> _mapException<T>(HttpLibraryMethod<T> method) async {
    try {
      return await method();
    } on DioException catch (exception) {
      switch (exception.type) {
        case DioExceptionType.cancel:
          throw NetworkFailure.canceled(exception);
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.receiveTimeout:
        case DioExceptionType.sendTimeout:
          throw NetworkFailure.timedOut(exception);
        case DioExceptionType.badResponse:
          // For DioErrorType.response, we are guaranteed to have a
          // response object present on the exception.
          final response = exception.response!;
          throw exceptionMapper?.call(response, exception) ??
              APIFailure(
                exception: exception,
                statusCode: response.statusCode,
                data: response.data,
              );
        case DioExceptionType.unknown:
        default:
          throw AppHttpClientFailure(exception: exception);
      }
    } catch (e) {
      throw AppHttpClientFailure(
        exception: e is Exception ? e : Exception('Unknown exception occurred'),
      );
    }
  }
}
