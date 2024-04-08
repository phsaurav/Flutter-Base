import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_base/common/presentation/controller/locale/locale_providers.dart';
import 'package:flutter_base/common/presentation/widgets/scaffold/base_scaffold.dart';
import 'package:flutter_base/features/home/presentation/widget/language_picker.dart';
import 'package:flutter_base/l10n/generated/locale.dart';
import 'package:flutter_base/utils/logger.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  static const routePath = "/";

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    var widgetsBinding = WidgetsBinding.instance;
    widgetsBinding.addPostFrameCallback((_) async {
      // Locale Startup Actions
      ref.read(localeStateProvider.notifier).initLocale();
    });
  }

  @override
  Widget build(BuildContext context) {
    String supportedLocales = ref.read(supportedLocalesProvider).toString();
    String platformLocale = ref.read(platformLocaleProvider).toString();
    String currentLocale = ref.watch(localeProvider).toString();

    logger.i("Supported locales: $supportedLocales");
    logger.i("Platform Locale: $platformLocale");
    logger.i("Current Locale: $currentLocale");

    return BaseScaffold(
      backButton: false,
      title: "Home",
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 350),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Platform Locale: $platformLocale"),
                  const SizedBox(height: 5),
                  Text(
                      "Locale via Localizations: ${Localizations.localeOf(context)}"),
                  const SizedBox(height: 5),
                  Text("Locale via Riverpod State: $currentLocale"),
                  const SizedBox(height: 20.0),
                  Text(Loc.of(context).home_welcome),
                  const SizedBox(height: 20.0),
                  const LanguagePicker(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
