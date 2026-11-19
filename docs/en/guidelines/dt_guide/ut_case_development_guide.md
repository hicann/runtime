# UT Case Development Guide

> Back to [Runtime DT Test Case Development Guidelines](README.md)

The test scope of a UT is usually one file, one class, or a set of functions with clear boundaries. A UT focuses on isolating the object under test and verifying its externally observable behavior. It does not verify all modules along the whole chain at the same time.

## UT Case Design Checklist

When you design test points for an interface, check the following items first:

* External input validation
  * Null pointers
  * Invalid enumeration values
  * Out-of-range lengths, capacities, and indexes
  * Handles or states that do not meet the prerequisites
* Boundary values
  * Empty containers, zero length, minimum and maximum valid values
  * Single-element and multi-element scenarios
* Resource lifecycle
  * Whether allocation and release are paired
  * Whether failure paths leak resources
  * Whether repeated creation and repeated release are safe
* Global state and singletons
  * Global state switches such as `rtSetSocVersion`, `SetChipType`, and `rtSetDevice`
  * Whether environment variables, configuration switches, and static caches need to be restored
* Platform and chip branches
  * Whether the same interface has branch behavior under different SoCs and different driver capabilities
* Callbacks and side effects
  * Whether callbacks are registered and triggered
  * Whether files, directories, logs, and statistics are generated correctly

If a check item is irrelevant to the current interface, do not force a test case for it.

## How to Verify

### Perform Complete Verification

A UT case should completely verify the call result according to its design. Common verification points include:

* Whether the return value or error code is accurate
* Whether output parameters are filled correctly
* Whether the state of the object under test changes as expected
* Whether mocks are called with correct arguments and whether the call counts meet expectations
* Whether the cleanup logic on failure paths runs

A common problem is "verify only the return code and not the side effects". Such test cases hardly prevent behavior regressions. Avoid them.

### Avoid Duplicate Verification

Complete each type of verification in only one test case that best matches the scenario. Too much duplicate verification causes many invalid failures after later changes and reduces test case maintainability.

## Common Cautions in the Runtime Repository

### 1. Close Mock and Global State in TearDown

Many test cases in the Runtime repository depend on gmock or mockcpp. Whichever framework you use, complete verification and cleanup at the end of the test to avoid polluting subsequent test cases.

Common patterns follow:

```c++
class QueueTest : public testing::Test {
 protected:
  void SetUp() override {
    MockFunctionTest::aclStubInstance().ResetToDefaultMock();
  }

  void TearDown() override {
    Mock::VerifyAndClear((void *)(&MockFunctionTest::aclStubInstance()));
  }
};
```

Or:

```c++
class PackageProcessConfigTest : public testing::Test {
 protected:
  void TearDown() override {
    GlobalMockObject::verify();
  }
};
```

If a test changes the chip type, device, environment variables, static flags, or singleton internal state, restore them in `TearDown` / `TearDownTestCase` as well.

### 2. Access Private Members with Caution

Existing code in the repository uses `#define private public` / `#define protected public`, but use it only as a supplement in restricted scenarios. Do not make it the default solution.

Recommended priority order:

1. Verify the behavior exposed by public interfaces first.
2. If you must observe internal state, reuse existing helpers, stubs, or accessors first.
3. Only when no better option exists, use `#define private public` temporarily.

### 3. Ensure Isolation and Cleanup for File System Scenarios

Many Runtime tests read and write `/tmp`, relative path directories, or temporary files. When you add such test cases:

* Include the module or test case feature in path names to avoid conflicts with other test cases
* Clean up temporary files and directories after the test
* Do not depend on other test cases to create directories or files in advance

### 4. Add Corresponding Tests for Compatibility Changes

If you modify ACL public structures, enumerations, constants, interface signatures, or ABI-related content, check whether you need to add or update compatibility tests at the same time, for example:

* `tests/ut/acl/testcase/compatibility/`
* Existing ABI and interface regression test cases of the corresponding module

## Discouraged UT Designs

Be careful with the following types of test cases:

* Verify only "call success/failure" and verify no result
* Chain multiple weakly related scenarios in one test case
* Force unrealistic abnormal combinations just for coverage
* Test cases that depend on residual state from a previous test case

If a scenario already crosses module boundaries and needs a simulator, a device environment, or a complete process, it usually fits ST better. Do not keep stacking it in UT.
