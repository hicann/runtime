# kernel

This directory focuses on Kernel loading, parameter organization, execution, and resource limit capabilities.

## Sample List

- [0_launch_kernel](./0_launch_kernel/README_en.md): Demonstrates Kernel binary loading, parameter assembly, and execution.
- [1_launch_kernel_with_reslimit](./1_launch_kernel_with_reslimit/README_en.md): Demonstrates Kernel execution under Device resource limits.
- [2_binary_enumerate_functions](./2_binary_enumerate_functions/README_en.md): Demonstrates enumerating multiple kernel functions in the same operator binary, then launching them and verifying the results.
- [3_binary_get_function_count](./3_binary_get_function_count/README_en.md): Demonstrates querying the number of kernel functions in a Kernel binary.
- [4_launch_blocking](./4_launch_blocking/README_en.md): Demonstrates environment control, per-stream modes, and nested non-blocking sections for Kernel Launch Blocking.
- [5_fdtd_stencil](./5_fdtd_stencil/README_en.md): Demonstrates a three-dimensional finite-difference stencil update configured through Kernel attributes and a Device variable.
- [6_memory_loaded_vector_add](./6_memory_loaded_vector_add/README_en.md): Demonstrates loading a Kernel binary from Host memory and running vector addition.
- [7_binary_introspection](./7_binary_introspection/README_en.md): Demonstrates querying Kernel binary, function parameter, code segment, and Device global variable metadata after loading.
- [8_reusable_kernel_args](./8_reusable_kernel_args/README_en.md): Demonstrates user-managed argument memory and reuse of the same Kernel argument list through parameter updates.
- [9_device_symbol_io](./9_device_symbol_io/README_en.md): Demonstrates asynchronously initializing a Device variable, updating its state in a Kernel, and verifying synchronous and asynchronous readback.
