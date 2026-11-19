# UT Code Guidelines

This document defines the mandatory guidelines for UT code in the Runtime repository. The guidelines supplement the methodology-oriented and design-oriented content in `dt_guide/ut_case_development_guide.md`.

## 1. Assertion Guidelines

### Rule 1: Every test case must have a valid assertion

- Every test case must contain at least one valid `EXPECT` or `ASSERT`.
- Do not write test code that only calls an interface without validating the result.

### Rule 2: Assertions must cover key observable results

- Besides the return value, validate output parameters, state changes, side effects, callbacks, and file or directory results directly related to the scenario.
- For failure scenarios, validate the error code, error state, or key protection behavior. Do not assert only that "execution ends".

## 2. Mock and Global State Guidelines

### Rule 3: Mock objects must be `verify` or `reset` when the test exits

- Every test class should complete mock cleanup in `TearDown`, `TearDownTestCase`, or an equivalent closing point.
- Mock state must not leak into subsequent test cases.

### Rule 4: Global state must be restored after modification

- If a test modifies the SoC type, device, environment variables, singleton state, static cache, global pointers, or member pointers, restore the original values when the test exits.
- Test code must not depend on another test setting a global state first.

## 3. Test Isolation Guidelines

### Rule 5: Test cases must not depend on each other

- Every test must construct its input, directory, configuration, and context independently.
- Do not depend on the execution order, and do not assume that a previous test has created temporary files or directories or registered state.

### Rule 6: Temporary files and directories must be cleaned up

- When you use `/tmp`, relative path directories, or temporary files, the code must have cleanup logic.
- Path names should include the module or test case characteristics to avoid conflicts with other test cases.

## 4. Maintainability Guidelines

### Rule 7: Reduce direct access to private members

- Prefer to validate behavior through public interfaces.
- Use `#define private public` or `#define protected public` only when no reasonable alternative exists.

### Rule 8: Reduce direct calls to `SetChipType` in UT

- If a call is necessary, explain the reason and restore the state when the test exits.

### Rule 9: Naming and directory style must be consistent

- New test file names should follow the existing style of the directory.
- Test class names, test case names, and auxiliary file names should express the tested object, the scenario, and the expected behavior.
