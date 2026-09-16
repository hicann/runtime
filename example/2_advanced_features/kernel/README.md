# kernel

本目录聚焦 Kernel 加载、参数组织、执行与资源限制能力。

## 样例列表

- [0_launch_kernel](./0_launch_kernel/README.md)：演示 Kernel 二进制加载、参数组装和执行。
- [1_launch_kernel_with_reslimit](./1_launch_kernel_with_reslimit/README.md)：演示在 Device 资源限制下的 Kernel 执行。
- [2_binary_enumerate_functions](./2_binary_enumerate_functions/README.md)：演示枚举同一算子二进制中的多个核函数，并依次下发和校验计算结果。
- [3_binary_get_function_count](./3_binary_get_function_count/README.md)：演示查询 Kernel 二进制中的核函数数量。
- [4_launch_blocking](./4_launch_blocking/README.md)：演示 Kernel Launch Blocking 的环境变量控制、流级三态及嵌套非阻塞区间。
- [5_fdtd_stencil](./5_fdtd_stencil/README.md)：演示通过 Kernel 属性和 Device 变量配置执行三维有限差分模板更新。
- [6_memory_loaded_vector_add](./6_memory_loaded_vector_add/README.md)：演示从 Host 内存加载 Kernel 二进制并执行向量加法。
- [7_binary_introspection](./7_binary_introspection/README.md)：演示加载后查询 Kernel 二进制、函数参数、代码段和 Device 全局变量元数据。
- [8_reusable_kernel_args](./8_reusable_kernel_args/README.md)：演示由用户管理参数内存，并通过参数句柄更新和复用同一 Kernel 参数列表。
- [9_device_symbol_io](./9_device_symbol_io/README.md)：演示异步初始化 Device 变量、由 Kernel 更新状态，并通过同步和异步方式读回校验。
