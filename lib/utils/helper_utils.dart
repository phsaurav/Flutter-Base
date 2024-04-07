import 'package:flutter/widgets.dart';

/// Removes the focus from the current focus scope.
///
/// This function takes a [context] as a parameter and uses it to access the current focus scope.
/// If the current focus scope does not have the primary focus, it unfocuses it.
void removeFocus(context) {
  FocusScopeNode currentFocus = FocusScope.of(context);

  if (!currentFocus.hasPrimaryFocus) {
    currentFocus.unfocus();
  }
}
