import 'package:flutter/material.dart';
import 'package:flutter_base/common/presentation/widgets/appbar/base_appbar.dart';
import 'package:flutter_base/core/theme/colors.dart';

/// A base scaffold widget that provides a basic structure for a screen.
class BaseScaffold extends StatelessWidget {
  final String title;
  final Widget? body, floatingButton, bottomNav;
  final AppBar? customAppBar;
  final bool backButton;

  /// Constructs a [BaseScaffold] widget.
  ///
  /// The [title] parameter is used as the title on the appbar.
  /// The [body] parameter is the main content of the scaffold.
  /// The [customAppBar] parameter is an optional custom appbar to increase base appbar functionality.
  /// The [floatingButton] parameter is an optional floating button on the scaffold.
  /// The [bottomNav] parameter is an optional bottom navigation bar on the scaffold.
  /// The [backButton] parameter determines whether to show a back button on the appbar.
  const BaseScaffold({
    super.key,
    required this.title,
    this.body,
    this.customAppBar,
    this.floatingButton,
    this.bottomNav,
    this.backButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //* We can pass custom appbar if we want to increase base appbar functionality
      appBar: customAppBar ??
          BaseAppBar(
            title: title,
            backButton: backButton,
          ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: body,
      ),
      floatingActionButton: floatingButton,
      bottomNavigationBar: bottomNav,
      backgroundColor: colorBg,
      // resizeToAvoidBottomInset: false,
    );
  }
}
