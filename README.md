# Setup Instructions

## Table of Contents

1. [Project Setup](#project-setup)
1. [Commit Hooks](#commit-rules)

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

## Directory Structure
	lib
	├ common                         # Common sharable data and presentation layers
	│  ├── data                      # Common sharable data and presentation layers
	│  │  ├── model                  # Common models
	│  │  └── repositories           # Common repositories
	│  ├── presentation              # Common sharable data and presentation layers
	│  │  ├── controller             # Common controller
	│  │  └── widgets                # Common widgets
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
	│  │  │  ├── model               # Feature 1 model
	│  │  │  └── repositories        # Feautre 1 repositories
	│  │  └── presentation           # Feautre 1 Presentation Layer
	│  │     ├── controller          # Feautre 1 controller
	│  │     └── widgets             # Feautre 1 widgets
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
	└── main.dart
	test

## Custom Utilities

## Dependencies

