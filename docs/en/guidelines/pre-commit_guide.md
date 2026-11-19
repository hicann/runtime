# Pre-commit Configuration Guide

## Overview

pre-commit is a Git Hooks framework. It runs code check and formatting tools automatically during `git commit`. This project configures the following checks:

| Hook | Function | Description |
|------|------|------|
| **clang-format** | C/C++ code formatting | Format code automatically and keep the style consistent |
| **OAT Check** | Open source compliance check | Detect license headers and prohibit binary file commits |

## Environment Requirements

- **Git**: 2.0+
- **Python**: 3.8+
- **clang-format**: 14.0+ (code formatting)

## Installation Steps

### 1. Install pre-commit

```bash
# Option 1: Use pip
pip install pre-commit

# Option 2: Use the system package manager (Ubuntu/Debian)
sudo apt install pre-commit
```

### 2. Install dependent tools

```bash
# Ubuntu/Debian
sudo apt install clang-format

# macOS
brew install clang-format
```

### 3. Install Git Hooks in the project path

```bash
cd /path/to/runtime
pre-commit install
```

A successful installation displays the following message:
```
pre-commit installed at .git/hooks/pre-commit
```

## Usage

### Automatic check (recommended)

pre-commit runs the checks automatically each time you execute `git commit`:

```bash
git add .
git commit -m "your commit message"
```

Example output:
```
clang-format.............................................................Passed
OAT Compliance Check (Python Edition).....................................Passed
```

### Run checks manually

```bash
# Run all checks
pre-commit run

# Run checks of a specific type
pre-commit run clang-format
pre-commit run oat-check

# Check all files (not limited to the staging area)
pre-commit run --all-files
```

### Skip checks (emergency only)

```bash
git commit --no-verify -m "emergency fix"
```

> **Note**: Use this option only in emergencies. The normal development process should ensure that checks pass.

## Check Item Description

### 1. clang-format

Format C/C++ code automatically according to the `.clang-format` configuration of the project:

- **Indentation**: 4 spaces
- **Column width**: 120 characters
- **Braces**: Line break for function definitions, same line for control statements
- **Pointer alignment**: Right alignment (`int *ptr`)


### 2. OAT Compliance Check

OAT (Open Source Audit Tool) checks open source compliance:

| Check item | Description |
|--------|------|
| License header check | Ensure that source files contain the CANN License header |
| Binary file check | Prohibit binary file commits |
| Archive file check | Prohibit commits of archive files such as zip and tar |


OAT uses the remote Python hook provided by the [compliance](https://gitcode.com/HiAgent/compliance) repository. The version is pinned by `rev: v1.0.6` in `.pre-commit-config.yaml`. During the first run, pre-commit clones the repository automatically, installs OAT and its dependencies in an independent Python virtual environment, and checks the passed files through `oat-precommit`.

The `OAT.xml` file in the repository root configures the compliance rules of this project. Do not copy or maintain local check scripts.

## FAQ

### Q1: The OAT check is slow during the first commit

**Cause**: The first run downloads the remote hook and installs the Python environment and dependencies. It requires access to GitCode and the Python package source.

**Solution**: Wait for the first installation to complete. Subsequent commits reuse the environment cached by pre-commit.


## Related Documents

- [pre-commit official documentation](https://pre-commit.com/)
- [clang-format configuration](https://clang.llvm.org/docs/ClangFormatStyleOptions.html)
- [OAT remote hook](https://gitcode.com/HiAgent/compliance)
- [Repository pre-commit integration guide](https://gitcode.com/cann/infrastructure/blob/main/docs/SC/pre-commit/pre-commit%E9%85%8D%E7%BD%AE%E6%8C%87%E5%AF%BC%E4%B9%A6.md)
