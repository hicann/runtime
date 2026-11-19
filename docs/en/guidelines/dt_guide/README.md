# Runtime DT Test Case Development Guidelines

This document covers UT/ST development in the Runtime repository. It explains where to put test cases, how to integrate them into the build, and which basic constraints apply when designing test cases. This document assumes that readers already know gtest, so it does not explain test framework syntax.

> This document focuses on test case specifications. For build and run steps, prefer `bash tests/build_ut.sh`.

## Detailed Guidance

| Document | Content | Applicable scenario |
|------|------|---------|
| [Test framework guide](test_framework_guide.md) | gtest, gmock/mockcpp, common stubs, module-level stub/data, build integration | Consult when constructing inputs, stubbing, or organizing test assets |
| [UT case development guide](ut_case_development_guide.md) | UT design checklist, complete verification, global state recovery, compatibility test recommendations | Consult when writing or adding UT |

## Basics

### When to Add DT Test Cases

In general, add DT test cases in the following two situations:

1. When you develop a new requirement, a new interface, or a new platform branch, add UT for the new behavior and add ST when necessary.
2. When you fix a problem, add a regression test case as long as the problem reproduces reliably through tests. The recommended process is: first reproduce the problem with UT/ST, then fix the code, and finally confirm that the regression test case passes reliably.

### Runtime DT Test Projects

The test projects of the Runtime repository are in the `tests/` directory. The core structure follows:

```yaml
tests
 - build_ut.sh: entry point for test build, run, and coverage statistics
 - depends: common stubs and dependency doubles
   - ge: stubs related to dependent components
   - mmpa: platform abstraction layer stubs
   - profiling: profiling-related stubs
   - runtime: runtime/drv interface stubs
   - slog: log stubs
   - tdt: data transmission stubs
   - toolchain: toolchain stubs
 - ut
   - acl: ACL interface tests, including `testcase/` and `testcase_c/`
   - runtime: Runtime core and C interface tests
   - adump: Dump-related UT/ST
   - msprof: Profiling-related UT/ST
   - platform: platform capability UT/ST
   - queue_schedule: queue scheduling UT/ST
   - aicpu_sched: AICPU scheduling UT/ST
   - atrace: trace-related tests
   - tsd: TSD-related tests
   - error_manager: error management tests
   - mmpa: platform abstraction layer tests
   - slog: log module tests
```

The Runtime repository has no separate `tests/st` directory. ST usually shares the same `tests/ut/**` tree with the corresponding module. Common locations include `tests/ut/msprof/st`, `tests/ut/platform/st`, and `tests/ut/adump/st`.

### Common Run Commands

```bash
# Build and run all tests
bash tests/build_ut.sh -u

# Build and run the specified module
bash tests/build_ut.sh -u runtime
bash tests/build_ut.sh -u acl
bash tests/build_ut.sh -u msprof

# Enable coverage
bash tests/build_ut.sh -c

# Enable AddressSanitizer
bash tests/build_ut.sh --asan -u runtime
```

`tests/build_ut.sh` currently supports the following common targets: `full`, `acl`, `runtime`, `runtime_c`, `platform`, `queue_schedule`, `aicpu_sched`, `slog`, `atrace`, `msprof`, `adump`, `tsd`, `error_manager`, `mmpa`. If you need to add a top-level test target, update `ut_path_map` in `tests/build_ut.sh` at the same time.

## Add New Test Case Files to the Build System

The Runtime test projects use CMake. After you add test cases, check at least the following integration points:

1. Add the new file to the `CMakeLists.txt` of the corresponding module, for example the `UT_FILES` list or the source file list of `add_executable(...)`.
2. If you add a test subdirectory, add `add_subdirectory(...)` to the parent `CMakeLists.txt`.
3. If you want to run the new module or submodule directly through `bash tests/build_ut.sh -u <target>`, update `ut_path_map` in `tests/build_ut.sh` at the same time.

Example:

```cmake
set(UT_FILES
    "acl_queue_unittest.cpp"
    "acl_new_feature_unittest.cpp"
)
```

## Test Case Specifications

### Specification 1: Match the Existing Naming Style of the Directory

Existing UT names in the Runtime repository are not fully consistent. Common suffixes include:

* `*_unittest.cpp` / `*_unittest.cc`
* `*_utest.cpp` / `*_utest.cc`

For example:

* `tests/ut/acl/testcase/acl_queue_unittest.cpp`
* `tests/ut/runtime/runtime/test/rt_utest_api.cc`
* `tests/ut/tsd/tsdclient/test/package_process_config_utest.cpp`

When you add a file, follow the principle "**keep the same style within the same directory**". Do not introduce a new suffix style into a directory that already has a clear naming convention.

ST files should uniformly use `*_stest.cpp` / `*_stest.cc` and reside in the `st/` directory of the corresponding module or in a platform scenario directory, for example:

* `tests/ut/msprof/st/api/testcase/api_dc_stest.cpp`
* `tests/ut/msprof/st/msprofbin/test/running_mode_stest.cpp`

### Specification 2: One Test Case Verifies One Clear Scenario

For both UT and ST, a test case should focus on one scenario and complete the full verification of that scenario. Do not chain multiple weakly related scenarios in one test case, because that increases the cost of problem localization and later maintenance.

### Specification 3: The Test Case Name Expresses the Object Under Test, the Expected Behavior, and the Trigger Scenario

Historical test case naming styles in the Runtime repository also differ. New test cases should meet at least the following requirements:

* Show which interface, class method, or feature the test covers
* Show whether the expected result is success, failure, or a state change
* Show the key scenario that triggers the behavior

If a file already has a stable naming style, keep it consistent.

### Specification 4: Always Perform Complete Verification, Not Just Return Value Checks

In addition to return values, verify the observable results directly related to the scenario, for example:

* Output parameter content
* Member state changes
* Mock call counts and arguments
* Files, directories, logs, callbacks, and side effects
* Whether global state is restored

Test cases that verify only "return success/failure" have limited value. Avoid them.
