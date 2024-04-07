import 'package:flutter/material.dart';
import 'package:flutter_base/core/theme/colors.dart';

/// Snackbar Service to handle snackbar without context
class SnackbarService {
  final GlobalKey<ScaffoldMessengerState> _snackbarKey =
      GlobalKey<ScaffoldMessengerState>();

  GlobalKey<ScaffoldMessengerState> get snackbarKey => _snackbarKey;

  /// Shows a snackbar with the given [text] and [duration].
  ///
  /// The [text] parameter is required and specifies the text to be displayed in the snackbar.
  /// The [duration] parameter is optional and specifies the duration for which the snackbar should be displayed.
  /// If no [duration] is provided, the default duration is set to 1000 milliseconds.
  void show({
    required String text,
    int? duration = 1000,
  }) {
    final SnackBar snackBar = SnackBar(
      backgroundColor: colorTextDeepGray,
      elevation: 2,
      margin: const EdgeInsets.all(20),
      behavior: SnackBarBehavior.floating,
      content: Text(text),
      duration: Duration(milliseconds: duration ?? 1000),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
    );
    _snackbarKey.currentState?.showSnackBar(snackBar);
  }
}
