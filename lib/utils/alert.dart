import 'package:flutter/material.dart';

/// A service class for displaying alert dialogs.
class AlertService {
  /// Displays an alert dialog with the given [title], [body], [onCancel], [onOk], and [context].
  static void showAlert({
    required String title,
    required String body,
    required VoidCallback onCancel,
    required VoidCallback onOk,
    required BuildContext context,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        actions: [
          TextButton(
            onPressed: onOk,
            child: const Text("Confirm"),
          ),
          TextButton(
            onPressed: onCancel,
            child: const Text("Cancel"),
          ),
        ],
      ),
    );
  }
}
