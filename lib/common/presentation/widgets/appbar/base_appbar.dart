import 'package:flutter/material.dart';
import 'package:flutter_base/core/theme/text_theme.dart';
import 'package:flutter_base/utils/logger.dart';
import 'package:flutter_base/utils/size_utils.dart';

/// A custom base app bar widget that can be used across the application.
class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title; // Title on the appbar
  final List<Widget> actions; // Right side actions on the appbar
  final bool backButton;

  /// Creates a [BaseAppBar] widget.
  ///
  /// The [title] parameter is the title to be displayed on the app bar.
  /// The [actions] parameter is a list of widgets to be displayed on the right side of the app bar.
  /// The [backButton] parameter determines whether a back button should be displayed on the app bar.

  const BaseAppBar({
    super.key,
    required this.title,
    this.actions = const [],
    this.backButton = true,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    String? currentRoute = ModalRoute.of(context)?.settings.name;
    logger.i(currentRoute);
    return AppBar(
      title: Text(
        title ?? '',
        style: textLabelLarge.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
      elevation: 0.5,
      centerTitle: true,
      leadingWidth: title == '' ? 50.sw(context) : 56,
      leading: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          padding: const EdgeInsets.only(left: 5),
          child: backButton
              ? BackButton(
                  // icon: const Icon(Icons.arrow_back_ios),
                  onPressed: () => Navigator.pop(context),
                )
              : null,
        ),
      ),
      titleSpacing: 0,
    );
  }
}
