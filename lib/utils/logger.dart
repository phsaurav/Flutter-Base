import 'dart:io';

import 'package:logger/logger.dart';

/// Returns true if the platform supports colored log messages, false otherwise.
bool get colorSupport => Platform.isAndroid;

/// The logger instance used for logging messages.
var logger = Logger(
  printer: PrettyPrinter(
    methodCount: 1, // number of method calls to be displayed
    errorMethodCount: 3, // number of method calls if stacktrace is provided
    colors: colorSupport, // Colorful log messages
    printEmojis: true, // Print an emoji for each log message
    printTime: false, // Should each log print contain a timestamp
    excludeBox: {Level.info: true},
  ),
);
