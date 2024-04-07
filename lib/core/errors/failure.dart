import 'package:equatable/equatable.dart';

// Enumerations
enum NetworkFailureReason { canceled, timedOut, responseError }

enum CacheFailureReason { noCacheFound }

/// Represents a base class for all failures in the application.
abstract class Failure extends Equatable implements Exception {
  final String? message;

  /// Constructs a Failure object with an optional error message.
  const Failure([this.message = "Error!!"]);

  @override
  List<Object?> get props => [message];

  @override
  String toString() => '$runtimeType Exception || Message: $message';
}

/// Represents a failure related to the AppHttpClient.
class AppHttpClientFailure extends Failure {
  final Exception exception;

  /// Constructs an AppHttpClientFailure object with an exception and an optional error message.
  const AppHttpClientFailure({
    required this.exception,
    String message = "Client Failure",
  }) : super(message);
}

/// Represents network-related failures.
class NetworkFailure extends AppHttpClientFailure {
  final NetworkFailureReason reason;

  /// Constructs a NetworkFailure object with a reason, an exception, and an optional error message.
  const NetworkFailure({
    required this.reason,
    required super.exception,
    super.message = "Network Failure",
  });

  /// Creates a network failure due to request cancellation.
  factory NetworkFailure.canceled(Exception exception) => NetworkFailure(
        reason: NetworkFailureReason.canceled,
        exception: exception,
        message: "Connection Cancelled!!",
      );

  /// Creates a network failure due to request timeout.
  factory NetworkFailure.timedOut(Exception exception) => NetworkFailure(
        reason: NetworkFailureReason.timedOut,
        exception: exception,
        message: "Connection Timed Out!!",
      );

  /// Creates a network failure due to a response error with optional error details.
  factory NetworkFailure.responseError(
          Exception exception, String errorDetails) =>
      NetworkFailure(
        reason: NetworkFailureReason.responseError,
        exception: exception,
        message: "Network Failure Response Error!!",
      );

  // Other methods specific to network failures can be added here.
}

/// Represents an API failure.
class APIFailure<DataType> extends NetworkFailure {
  final int? statusCode;
  final DataType? data;

  /// Constructs an APIFailure object with a status code, data, and an exception.
  const APIFailure({
    required this.statusCode,
    required this.data,
    required super.exception,
  }) : super(
          reason: NetworkFailureReason.responseError,
          message: "API Failure",
        );

  /// Checks if the API failure has data.
  bool get hasData => data != null;
}

/// Represents a validation failure.
class ValidationFailure extends Failure {
  final String msg;

  /// Constructs a ValidationFailure object with a message.
  const ValidationFailure({required this.msg});
}

/// Represents a cache failure.
class CacheFailure extends Failure {
  final CacheFailureReason reason;

  /// Constructs a CacheFailure object with a reason and an optional error message.
  const CacheFailure({
    required this.reason,
    String message = "Cache Failure",
  }) : super(message);
}
