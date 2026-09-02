# ACL

## Introduction

The Python API for ACL (Ascend Computing Language).

AscendCL (Ascend Computing Language) is a C language API library for developing deep neural network applications on the Ascend platform. It provides APIs for runtime resource management, memory management, model loading and execution, operator loading and execution, and media data processing. It enables you to leverage the computing resources of Ascend hardware to perform deep learning inference on the Ascend CANN platform, graphics/image pre-processing, and accelerated computation of individual operators. In short, it is a unified API framework for invoking all resources. The computing resource layer is the hardware foundation for Ascend AI processing. It mainly performs matrix-related computations of neural networks, general computations and execution control for control operators/scalars/vectors, and pre-processing of image and video data, providing execution guarantees for deep neural network computation.

pyACL (Python Ascend Computing Language) is a Python API library built on top of AscendCL using CPython wrapping, allowing users to manage the runtime and resources of Ascend AI processors through the Python language.

## Directory Structure

```text
python
├── build
│   ├── bep         //
│   └── build.sh    //Run this script to compile acl.so and generate the run package
├── ci              //Dependency configuration for CI build
├── script          //Installation, uninstallation, help, patch, and other scripts for the run package
|── output          //Final storage directory after the run package is built
└── pyACL           //CPython-wrapped ACL source code
```

## Build

### In a CI environment

```bash
cd build
cmake ..
make
```

### In a non-CI environment

Due to environment differences, the CMakeLists file needs to be reconfigured.

Replace the value of ACL_LIB "${PROJECT_SOURCE_DIR}/dependency/lib64" with the path of the CANN package in your environment, for example:

```cmake
set(ACL_LIB "/usr/local/Ascend/ascend-toolkit/latest/lib64/")
```

Set the CANN package path in your environment via include_directories, for example:

```cmake
include_directories(/usr/local/Ascend/ascend-toolkit/latest/include/)
```

Set the Python software path in your environment via include_directories, for example:

```cmake
include_directories(/usr/local/python3.9.0/include/python3.9/)
include_directories(/usr/local/python3.9.0/lib/python3.9/site-packages/numpy/core/include/)
```

## Usage

pyACL is integrated in cann-toolkit <br>
Runtime dependencies: driver package and runtime component of the same version <br>

## Development Guide

CPython wrapping guide: https://docs.python.org/release/3.7.5/extending/extending.html# <br>
CPython argument parsing: https://docs.python.org/release/3.7.5/c-api/arg.html#other-objects <br>
CPython exception types: https://docs.python.org/3/library/exceptions.html#RuntimeError <br>
