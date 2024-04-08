# Setup Instructions

## Table of Contents

1. [Project Setup](#project-setup)
1. [Commit Hooks](#commit-rules)
1. [Localization](#localization)
1. [Directory Structure](#directory-structure)
1. [Custom Utilities](#custom-utilities)
1. [Dependencies](#dependencies)

## Project Setup

```
flutter create flutter_base
cd flutter_base
```


## Commit Rules
This pre-commit hook setup facilitates these functions while commiting:
1. Automatic Formatting
2. Automatic Flutter Code Analysis
3. Automatic Unit Testing

Two commit rules script in `scripts/` folder.

`scripts/pre-commit.bash`
```bash
#!/usr/bin/env bash

printf "\e[33;1m%s\e[0m\n" 'Pre-Commit'

# Undo the stash of the files
pop_stash_files () {
    if [ -n "$hasChanges" ]; then
        printf "\e[33;1m%s\e[0m\n" '=== ⏎ Applying git stash changes ==='
        git stash pop
    fi
}

# Stash unstaged files
hasChanges=$(git diff)
if [ -n "$hasChanges" ]; then
    printf "\e[33;1m%s\e[0m\n" '⚠️ Stashing unstaged changes'
    git stash push --keep-index
fi

# Flutter formatter
printf "\e[33;1m%s\e[0m\n" '=== 🧹 Running Flutter Formatter ==='
dart format .

hasNewFilesFormatted=$(git diff)
if [ -n "$hasNewFilesFormatted" ]; then
    git add .
    printf "\e[33;1m%s\e[0m\n" '♻️ Formmated files added to git stage'
fi
printf "\e[33;1m%s\e[0m\n" '✅ Finished running Flutter Formatter'
printf '%s\n' "${avar}"

# Flutter Analyzer
printf "\e[33;1m%s\e[0m\n" '=== 🔬 Running Flutter analyzer ==='
flutter analyze
if [ $? -ne 0 ]; then
  printf "\e[31;1m%s\e[0m\n" '=== 🚨 Flutter analyzer error ==='
  pop_stash_files
  exit 1
fi
printf "\e[33;1m%s\e[0m\n" '✅ Finished running Flutter analyzer'
printf '%s\n' "${avar}"

# Unit tests
printf "\e[33;1m%s\e[0m\n" '=== 🧪 Running Unit Tests ==='
flutter test
if [ $? -ne 0 ]; then
  printf "\e[31;1m%s\e[0m\n" '=== ‼️ Unit tests error ==='
  pop_stash_files
  exit 1
fi
printf "\e[33;1m%s\e[0m\n" '✅ Finished running Unit Tests'
printf '%s\n' "${avar}"

pop_stash_files
```

`scripts/install-hooks.bash`
```
#!/usr/bin/env bash

GIT_DIR=$(git rev-parse --git-dir)

echo "Installing hooks..."
# this command creates symlink to our pre-commit script
ln -s ../../scripts/pre-commit.bash $GIT_DIR/hooks/pre-commit
echo "Done!" 
```

### Installing Pre-Commit Hooks
```bash
chmod +x scripts/*.bash && ./scripts/install-hooks.bash
```

## Localization
Add flutter_localization, intl and arb_utils dependencies
```yml
  flutter_localization:
    sdk: flutter
  intl: ^0.19.0
	arb_utils: ^0.8.0
```
Set generate to true under flutter tag
```yml
flutter:
  generate: true
```

Set l10n folder structure and add localesupport in main
l10n/l10n.dart:
```dart
import 'package:flutter/material.dart';

class L10n {
  static final all = [
    const Locale('en'),
    const Locale('ja'),
  ];
}
```

main.dart:
```dart
 MaterialApp.router(
        ...
        supportedLocales: L10n.all,
        ...
      ),
```

l10n.yaml:
```yml
arb-dir: lib/l10n/arb
output-dir: lib/l10n/generated
template-arb-file: app_en.arb
output-localization-file: locale.dart
output-class: Loc
synthetic-package: false
nullable-getter: false
untranslated-messages-file: l10n_missing.txt
```

Translation Key Strcutre:
```json
"{feature}+{widget}+name": value
Example:
auth_login_screen_title: "Login"
```

Sort locales script:
`sort-locale.sh`
```sh
#!/bin/zsh
pwd
arb_utils sort lib/l10n/arb/app_en.arb
arb_utils sort lib/l10n/arb/app_ja.arb
popd;
```
Run: `./scripts/update-locale.sh`

Missing locale information will be in `l10n_missing.txt`

## Directory Structure
	lib
	├ common                         # Common sharable data and presentation layers
	│  ├── data                      # Common sharable data and presentation layers
	│  │  ├── model                  # Common models data
	│  │  └── repositories           # Common repositories holds buisness logic of data
	│  ├── presentation              # Common sharable data and presentation layers
	│  │  ├── controller             # Common controller holds state and buisness logic of view
	│  │  └── widgets                # Common UI widgets
	│  │     └── appbar              # Base Appbar
	├ core                           # Main core utilities
	│  ├── error                     # Error handling structure setup
	│  │  └── failure.dart           # Different type of Failure Definition
	│  ├── network                   # Core network logic setup
	│  │  ├── api_client.dart        # Base API client setup with dio
	│  │  └── api_interceptor.dart   # API interceptor for automatic injection
	│  ├── theme                     # Theme related data
	│  │  ├── app_theme.dart         # Application theme config data
	│  │  ├── colors.dart            # Application color swatch data
	│  │  └── text_theme.dart        # Application text theme data
	│  └── router.dart               # Application navigation router
	├ features                       # Holds all the features layers
	│  ├── feature-1                 # All functionality related to feature 1
	│  │  ├── data                   # Feature 1 data layer
	│  │  │  ├── model               # Feature 1 model data
	│  │  │  └── repositories        # Feautre 1 repositories holds buisness logic of data
	│  │  └── presentation           # Feautre 1 Presentation Layer
	│  │     ├── controller          # Feautre 1 controller holds state and buisness logic of view
	│  │     └── widgets             # Feautre 1 UI widgets
	│  └── feature-2                 # All functionality related to feature 2
	├ resources                      # Holds all external resources data
	│  ├── assets.dart               # Holds all assets related data
	│  ├── base_path.dart            # Holds base path static data
	│  └── endpoints.dart            # Holds API endpoints data
	├ utils                          # Holds all the application utilities
	│  ├── alert.dart                # A simple alert utility
	│  ├── config.dart               # App Configuration
	│  ├── helper_utils.dart         # Helper utility functions
	│  ├── helper_widgets.dart       # Helper utility widgets
	│  ├── logger.dart               # Custom rich logger utility
	│  ├── size_utils.dart           # Custom size utilities for responsiveness
	│  └── snackbar_service.dart     # Simple snackbar implementation
	└── main.dart                    # Simple snackbar implementation
	test                             # All application tests
	├ common                         # Common functionality tests
	├ core                           # Core functionality tests
	├ features                       # All features tests
	└ fixtures                       # All static fixtures


## Custom Utilities

### Failure:
This service contains the definition of various failure classes used in the application. Such as `AppHttpClientFailure`, `NetworkFailure`, `APIFailure`, `CacheFailure` etc.

### Network Service
This service provide advance functionality with token injection with interceptor, failure and timeout handling with different failover functionality. This makes it easy to have a centralize control over all API calls through out the applicationa and handle failure and failover.

Example Code:
```dart
final AppHttpClient _client

final response = await _client.get(ApiConstants.url)

final response = await _client.post(
      ApiConstants.url,
      data: json.encode(requestBody),
)
```

### Router
This service handle all navigation within the application and utilizes a package called `Go Router`

### AlertService:
A service class for displaying alert dialogs.
Displays an alert dialog with the given [title], [body], [onCancel], [onOk], and [context].

### AppConfig:
A class that holds the configuration values for the application.

### removeFocus:
Removes the focus from the current focus scope.
This function takes a [context] as a parameter and uses it to access the current focus scope.
If the current focus scope does not have the primary focus, it unfocuses it.

### addVSpace
Returns a SizedBox widget with the specified [height].

### addHSpace
Returns a SizedBox widget with the specified [width].

### logger
An advance logger instance leveraging prettyprinter package used for logging messages.

### Size Utils
A collection of utility functions and extensions for handling screen sizes and percentages for implementing better responsive layout

#### Extensions:
`sw` - Calculates the width based on the percentage of the screen width based on [context].
`asw` - Calculates the scaled width based on the percentage of the absolute screen width.
`sh` - Calculates the scaled height based on the percentage of the screen height based on [context].
`ash` - Calculates the scaled height based on the percentage of the available screen height.
`wr` -  Calculates the scaled width based on the width ratio.

Example usage:
```dart
double screenWidth = screenWidth();
double screenHeight = percentageScreenHeight(context, 50);
double size = 100.sw(context);
double absoluteSize = 50.asw;
double absoluteSize = 50.asw;
double size = 20.wr
```
### Snackbar Service
Snackbar Service to handle snackbar without context
Shows a snackbar with the given [text] and [duration].
The [text] parameter is required and specifies the text to be displayed in the snackbar.
The [duration] parameter is optional and specifies the duration for which the snackbar should be displayed default 1000.

## Dependencies
### Localization:
`flutter_localizations` - Enable flutter localization
`intl` - Provides internationalization and localization facilities
### Networking:
`dio` - An advance powerful HTTP networking package for Flutter, supports Global configuration, Interceptors, FormData, Request cancellation, File uploading/downloading, Timeout, Custom adapters, Transformers, etc.
`
### State Management:
`flutter_riverpod` - State management system for the app
`riverpod_annotation` - This is a side package for riverpod_generator, exposing annotations

### Utility:
`google_fonts` - Google font support for theme
`logger` - A better loggin support
`go_router` - A router package for app navigation
`equatable` - A Dart package that helps to implement value based equality for a better comparison.

### Tests:
`flutter_lints`
`riverpod_generator`
`riverpod_lint`
`mockito`
