# kernel

This directory focuses on Kernel loading, parameter organization, execution, and resource limit capabilities.

## Sample List

- [0_launch_kernel](./0_launch_kernel/README_en.md): Demonstrates Kernel binary loading, parameter assembly, and execution.
- [1_launch_kernel_with_reslimit](./1_launch_kernel_with_reslimit/README_en.md): Demonstrates Kernel execution under Device resource limits.
- [2_binary_enumerate_functions](./2_binary_enumerate_functions/README_en.md): Demonstrates enumerating multiple kernel functions in the same operator binary, then launching them and verifying the results.
- [3_binary_get_function_count](./3_binary_get_function_count/README_en.md): Demonstrates querying the number of kernel functions in a Kernel binary.
- [4_launch_blocking](./4_launch_blocking/README_en.md): Demonstrates environment control, per-stream modes, and nested non-blocking sections for Kernel Launch Blocking.
- [5_fdtd_stencil](./5_fdtd_stencil/README_en.md): Demonstrates a three-dimensional finite-difference stencil update configured through Kernel attributes and a Device variable.
