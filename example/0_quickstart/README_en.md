# 0_quickstart

This chapter is for developers who are first exposed to Runtime sample projects. First, complete the compilation and execution process through a minimum computation closed loop, then supplement entry topics such as error handling, system information query, cross-version compatibility, and custom Kernel invocation.

## Sample List

- [0_hello_cann](./0_hello_cann/README_en.md): Demonstrates initialization configuration, Device/Stream management, Tensor and DataBuffer preparation, workspace application, `aclnnAdd` vector addition execution, synchronization waiting, and resource release.
- [1_error_handling](./1_error_handling/README_en.md): Demonstrates unified return value checking, thread-level Runtime error code query, recent error description acquisition, and detailed error summary query.
- [2_system_info](./2_system_info/README_en.md): Demonstrates Runtime API version, CANN software package version, run mode, float16/float32 conversion, and data type size query.
- [4_custom_kernel_launch](./4_custom_kernel_launch/README_en.md): Demonstrates the minimum process of dispatching custom AscendC Kernel using the `<<<>>>` kernel call operator.

## Related Topics

- [3_cross_version](./3_cross_version/README_en.md): Cross-version compilation, interface difference adaptation, and compatibility handling.