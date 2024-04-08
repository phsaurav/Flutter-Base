import 'dart:ui';

import 'package:flutter_base/l10n/platform_locale/platform_locale_interface.dart';
import 'package:flutter_base/utils/logger.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Platform Locale Provider
/// Returns the locale of the Platform.localeName
final platformLocaleProvider = Provider<Locale>((_) {
  // Get the platform language using platform specific implementations
  Locale platformLocale = PlatformLocale().getPlatformLocale();

  logger.i("Retrieved platform locale: $platformLocale");

  return platformLocale;
});

/// Supported Locales Provider
/// Update this list to expand the number of supported locales in the app
final supportedLocalesProvider = Provider<List<Locale>>((_) {
  return const [
    Locale('en', 'US'),
    Locale('ja', 'JP'),
  ];
});

class LocaleState extends StateNotifier<Locale> {
  LocaleState() : super(const Locale('en', 'US'));

  void setLocale(Locale locale) {
    state = locale;
  }

  void initLocale() {
    state = const Locale('en', 'US');
  }
}

final localeStateProvider = StateNotifierProvider<LocaleState, Locale>((ref) {
  return LocaleState();
});

/// Locale Provider
/// Provides the current locale, and automatically updates when the locale changes.
final localeProvider = Provider<Locale>((ref) {
  return ref.watch(localeStateProvider);
});
