import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base/common/presentation/controller/locale/locale_providers.dart';
import 'package:flutter_base/core/router.dart';
import 'package:flutter_base/core/theme/app_theme.dart';
import 'package:flutter_base/l10n/generated/locale.dart';
import 'package:flutter_base/utils/logger.dart';
import 'package:flutter_base/utils/size_utils.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //* Disable landscape mode in app
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  logger.i("Device Screen Width: ${screenWidth()}");

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get supported locales
    List<Locale> supportedLocales = ref.read(supportedLocalesProvider);

    // Watch the current locale and rebuild on change
    Locale locale = ref.watch(localeProvider);
    logger.i("Rebuilding with current locale: $locale");

    return Listener(
      onPointerDown: (_) {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          currentFocus.focusedChild?.unfocus();
        }
        if (!currentFocus.hasPrimaryFocus && currentFocus.hasFocus) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: MaterialApp.router(
        title: 'Base App',
        theme: lightTheme,
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          Loc.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: supportedLocales,
        locale: locale,
        routerConfig: router,
      ),
    );
  }
}
