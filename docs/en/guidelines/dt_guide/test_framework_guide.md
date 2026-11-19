# Test Framework Guide

> Back to [Runtime DT Test Case Development Guidelines](README.md)

The Runtime repository tests are mainly based on gtest and combine gmock, mockcpp, common stubs, and module-level stub/data to organize test cases. This document describes the capabilities of the existing test framework so that developers reuse existing facilities first instead of reinventing the wheel.

## Test Base Classes

Most test cases directly inherit from `testing::Test` and complete common initialization and cleanup in `SetUp` / `TearDown`.

Common responsibilities include:

* Restore default mock behavior
* Create and destroy simulators
* Set and restore the global chip type, device, and environment variables
* Verify and clear mock objects

If multiple test cases share the same initialization logic, extract a unified fixture to avoid duplicate code.

## Mock Frameworks

### gmock

Use gmock when a mock class exists or when you need to verify interface expectations. Common usages include:

* `EXPECT_CALL(...)`
* `Mock::VerifyAndClear(...)`

Typical scenarios:

* ACL interface tests
* Scenarios that need to verify the call count and arguments of a mock object

### mockcpp

Use mockcpp to replace global functions, static functions, and member functions. It is very common in the repository. Common interfaces include:

* `MOCKER(...)`
* `MOCKER_CPP(...)`
* `MOCKER_CPP_VIRTUAL(...)`
* `GlobalMockObject::verify()`

Typical scenarios:

* Stub system interfaces such as `dlopen` / `dlsym` / `access`
* Stub driver, runtime, and device functions
* Replace the internal call chain of a singleton

## Common Stubs and Test Assets

### `tests/depends/`

`tests/depends/` provides common stubs reused across modules. Before you add tests, check here first for reusable capabilities. It currently contains:

* `ge/`
* `mmpa/`
* `profiling/`
* `runtime/`
* `slog/`
* `tdt/`
* `toolchain/`

### Module-level `stub/`, `data/`, and `json/`

Many modules keep dedicated test assets in their own test directories, for example:

* `tests/ut/msprof/st/stub/`
* `tests/ut/msprof/st/data/`
* `tests/ut/acl/json/`
* `tests/ut/runtime/runtime_c/stub/`

If a stub or data serves only one module, put it in the module first to avoid polluting the common directory.

## Simulators and Auxiliary Capabilities

Some ST/UT use the existing simulators and data management capabilities in the module, for example:

* `SimulatorMgr()` creates and destroys platform simulators
* `DataMgr()` initializes and verifies scenario data

These capabilities are usually coupled with module scenarios. When you add test cases, reuse the existing helpers first and do not implement a new simulation logic.

## Build Integration

After you add test code, you usually need to modify the `CMakeLists.txt` of the corresponding module. Common integration methods include:

* Add new files to `UT_FILES`
* Add new directories to `add_subdirectory(...)`
* Add the dependent stubs, header files, and link libraries for the new executable target

If you add a module that runs directly through `bash tests/build_ut.sh -u <target>`, also update the target mapping in `tests/build_ut.sh`.

## Coverage and Sanitizer

The unified entry point in the repository is `tests/build_ut.sh`:

```bash
# Coverage
bash tests/build_ut.sh -c

# AddressSanitizer
bash tests/build_ut.sh --asan -u runtime
```

If new tests create many temporary files or directories, run coverage or sanitizer locally at the same time to expose leak and residual state problems early.
