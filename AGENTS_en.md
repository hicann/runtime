# AGENTS.md

This file provides guidance for agents working in this code repository.

## Project Overview

Runtime is the runtime component of Huawei CANN (Compute Architecture for Neural Networks), providing Ascend NPU runtime user programming interfaces and core runtime implementations.

Main features:
- **Runtime components**: Device management, stream management, event management, memory management, task scheduling, and more
- **Diagnostic functionality components**:
  - Performance tuning (msprof): Collects and analyzes AI task performance metrics
  - Precision debugging (adump): Dumps operator/model input/output data
  - Logging (log): Records process execution information, supports fault diagnosis

## Build Commands

### Basic Build
```bash
# Build runtime components
bash build.sh

# View build options
bash build.sh --help
```

### Install Dependencies
```bash
# Install third-party dependencies
bash install_deps.sh

# Download third-party libraries (only use when local network is unavailable; not needed when network is working)
python3 download_3rd_party.py
```

## Directory Structure

| Directory | Purpose |
|------|------|
| `include/` | External release header files |
| `src/` | Source code |
| `src/acl/` | ACL external API |
| `src/dfx/` | Diagnostic functionality modules |
| `src/dfx/adump/` | Precision debugging module |
| `src/dfx/msprof/` | Performance tuning module |
| `src/dfx/log/` | Logging module |
| `src/runtime/` | Runtime core module |
| `tests/` | Unit tests |
| `example/` | Sample code |
| `cmake/` | Build configuration |

## Development Guidelines

### gitcode pr/issue Operations
@.claude/skills/default-skills/SKILL.md

### Code Style
- Follow Google open-source code standards
- Use .clang-format to format code

## Language
Use Chinese