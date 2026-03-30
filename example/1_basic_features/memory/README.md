# memory

本目录聚焦 Host/Device 间的数据传输、共享内存、IPC 以及多流内存同步能力。

## 样例列表

- [0_h2h_memory_copy](./0_h2h_memory_copy/README.md)：演示 Host 到 Host 的内存拷贝。
- [1_h2d_sync_memory_copy](./1_h2d_sync_memory_copy/README.md)：演示 Host 到 Device 的同步拷贝。
- [2_h2d_async_memory_copy](./2_h2d_async_memory_copy/README.md)：演示 Host 到 Device 的异步拷贝。
- [3_d2h_sync_memory_copy](./3_d2h_sync_memory_copy/README.md)：演示 Device 到 Host 的同步拷贝。
- [4_d2h_async_memory_copy](./4_d2h_async_memory_copy/README.md)：演示 Device 到 Host 的异步拷贝。
- [5_d2d_sync_memory_copy](./5_d2d_sync_memory_copy/README.md)：演示 Device 到 Device 的同步拷贝。
- [6_d2d_async_memory_copy](./6_d2d_async_memory_copy/README.md)：演示 Device 到 Device 的异步拷贝。
- [7_physical_memory_sharing_withpid](./7_physical_memory_sharing_withpid/README.md)：演示指定 PID 的物理内存共享。
- [8_physical_memory_sharing_withoutpid](./8_physical_memory_sharing_withoutpid/README.md)：演示不指定 PID 的物理内存共享。
- [9_multistream_sync_memory](./9_multistream_sync_memory/README.md)：演示多 Stream 场景下的内存同步。
- [10_ipc_memory_withpid](./10_ipc_memory_withpid/README.md)：演示指定 PID 的 IPC 内存共享。
- [11_ipc_memory_withoutpid](./11_ipc_memory_withoutpid/README.md)：演示不指定 PID 的 IPC 内存共享。
- [12_cross_server_physical_memory_sharing_withoutpid](./12_cross_server_physical_memory_sharing_withoutpid/README.md)：演示跨服物理内存共享。
