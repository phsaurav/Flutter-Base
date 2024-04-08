/// A collection of utility functions and extensions for handling screen sizes and percentages.
///
/// This file provides functions and extensions for calculating screen sizes and percentages
/// in a Flutter application. It includes functions for calculating percentages of screen width
/// and height, excluding app bar height, as well as extensions for easily converting sizes
/// to percentages.
///
/// The functions and extensions in this file can be used to create responsive UIs that adapt
/// to different screen sizes and orientations.
///
/// Example usage:
///
/// ```dart
/// double screenWidth = screenWidth();
/// double screenHeight = percentageScreenHeight(context, 50);
///
/// double size = 100.sw(context);
/// double absoluteSize = 50.asw;
/// ```
///
/// Note: This file assumes that the Flutter framework is being used.

library;

import 'dart:math';

import 'package:flutter/material.dart';

//* Percentage of screen size calculation
percentageOfSize(double size, double percentage) {
  return size * percentage / 100;
}

//* Percentage with respect to screen width
double percentageScreenWidth(BuildContext context, double percentage) {
  return percentageOfSize(MediaQuery.of(context).size.width, percentage);
}

//* Physical Screen Width Without Context
double screenWidth() {
  return WidgetsBinding
          .instance.platformDispatcher.views.first.physicalSize.width /
      WidgetsBinding.instance.platformDispatcher.views.first.devicePixelRatio;
}

//* Percentage with respect to screen height excluding appbar height
double percentageOfAvailableScreenHeight(
    BuildContext context, double percentage) {
  return percentageOfSize(
      MediaQuery.of(context).size.height -
          MediaQuery.of(context).viewPadding.top -
          AppBar().preferredSize.height,
      percentage);
}

//* Percentage with respect to screen height excluding appbar height
double percentageOfAbsoluteScreenWidth(double percentage) {
  return percentageOfSize(screenWidth(), percentage);
}

//* Percentage with respect to full screen height with appbar height
double percentageScreenHeight(BuildContext context, double percentage) {
  return percentageOfSize(
      MediaQuery.of(context).size.height -
          MediaQuery.of(context).viewPadding.top,
      percentage);
}

//* Number size extension
/// Extension on [num] to provide size-related utility functions.
extension SizeExtension on num {
  /// Calculates the scaled width based on the percentage of the screen width.
  double sw(BuildContext context) => percentageScreenWidth(context, toDouble());

  /// Calculates the scaled width based on the percentage of the absolute screen width.
  double get asw {
    return percentageOfAbsoluteScreenWidth(toDouble());
  }

  /// Calculates the scaled height based on the percentage of the screen height.
  double sh(BuildContext context) =>
      percentageScreenHeight(context, toDouble());

  /// Calculates the scaled height based on the percentage of the available screen height.
  double ash(BuildContext context) =>
      percentageOfAvailableScreenHeight(context, toDouble());

  /// Calculates the scaled width based on the width ratio.
  double get wr {
    // Size of the screen we designed on
    const double baseScreenWidth = 392;
    // Max size of screen the ratio will increase
    const double maxScreenWidth = 500;

    return min(
            screenWidth() / baseScreenWidth, maxScreenWidth / baseScreenWidth) *
        toDouble();
  }
}

/// Extension on [double] to provide size-related utility functions.
extension SizeExtensionDouble on double {
  /// Calculates the scaled width based on the percentage of the screen width.
  double sw(BuildContext context) => percentageScreenWidth(context, this);

  /// Calculates the scaled width based on the percentage of the absolute screen width.
  double get asw {
    return percentageOfAbsoluteScreenWidth(this);
  }

  /// Calculates the scaled height based on the percentage of the screen height.
  double sh(BuildContext context) => percentageScreenHeight(context, this);

  /// Calculates the scaled height based on the percentage of the available screen height.
  double ash(BuildContext context) =>
      percentageOfAvailableScreenHeight(context, this);

  /// Calculates the scaled width based on the width ratio.
  double get wr {
    // Size of the screen we designed on
    const double baseScreenWidth = 430;
    // Max size of screen the ratio will increase the size
    const double maxScreenWidth = 500;

    return min(
            screenWidth() / baseScreenWidth, maxScreenWidth / baseScreenWidth) *
        toDouble();
  }
}

/// Returns the physical width of the screen in logical pixels.
double physicalScreenWidth() {
  return WidgetsBinding
          .instance.platformDispatcher.views.first.physicalSize.width /
      WidgetsBinding.instance.platformDispatcher.views.first.devicePixelRatio;
}

/// Returns the width ratio of the screen.
double wRatio() {
  // Size of the screen we designed on
  const double baseScreenWidth = 392;
  // Max size of screen the ratio will increase
  const double maxScreenWidth = 500;

  return min(physicalScreenWidth() / baseScreenWidth,
      maxScreenWidth / baseScreenWidth);
}
