# Dev Container Usage Guide

This directory contains VS Code Dev Container configuration for compiling the runtime repository and executing UT tests within a container.

## Environment Specifications

| Tool | Version |
|----|------|
| Base Image | Ubuntu 22.04 LTS |
| GCC / G++ | 9.x |
| CMake | 3.22+ |
| Python | 3.10+ |
| ccache | System package |
| lcov | System package (for coverage) |
| libasan5 / libtsan0 / libubsan1 | gcc-9 sanitizer runtime (used with `--asan`) |

## Quick Start

### 1. Start Container

Open this repository directory in VS Code, press `F1` → **Dev Containers: Reopen in Container**, and wait for the image build to complete.

When the container starts, it automatically attempts to download third-party dependencies through the network (saved in `./third_party/`, and symlinked to `output/third_party` to match the default search paths for `build.sh`/`build_ut.sh`).

### 2. Compile runtime Package

```bash
# The container has already automatically downloaded third-party packages to third_party/ and symlinked to output/third_party.
# Therefore, you can execute directly (no need to pass --cann_3rd_lib_path):
export CMAKE_TLS_VERIFY=0
bash build.sh

# If third-party dependencies are in another path, you must use an absolute path
# (CMake's INTERFACE_INCLUDE_DIRECTORIES does not accept relative paths):
bash build.sh --cann_3rd_lib_path=$(pwd)/third_party
```

> **Note**: Complete runtime package compilation and execution require CANN toolkit and NPU driver.
> Follow the "Environment Preparation" section in README.md to manually download and install the corresponding version of the `Ascend-cann-toolkit` package in the container:
> ```bash
> chmod +x Ascend-cann-toolkit_${cann_version}_linux-x86_64.run
> ./Ascend-cann-toolkit_${cann_version}_linux-x86_64.run --full --force --quiet
> source /usr/local/Ascend/cann/set_env.sh
> ```