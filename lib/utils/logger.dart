import 'dart:io';

import 'package:logger/logger.dart';

bool get colorSupport => Platform.isAndroid;

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
