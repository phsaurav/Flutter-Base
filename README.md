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
