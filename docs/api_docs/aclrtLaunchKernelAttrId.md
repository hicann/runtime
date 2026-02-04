# aclrtLaunchKernelAttrId

```
typedef enum aclrtLaunchKernelAttrId {
    ACL_RT_LAUNCH_KERNEL_ATTR_SCHEM_MODE = 1,           // 调度模式
    ACL_RT_LAUNCH_KERNEL_ATTR_LOCAL_MEMORY_SIZE = 2,    // 用于指定SIMT算子执行时需要的VECTOR CORE内部UB buffer的大小
    ACL_RT_LAUNCH_KERNEL_ATTR_ENGINE_TYPE = 3,          // 算子执行引擎
    ACL_RT_LAUNCH_KERNEL_ATTR_BLOCKDIM_OFFSET,          // blockDim偏移量
    ACL_RT_LAUNCH_KERNEL_ATTR_BLOCK_TASK_PREFETCH,      // 任务下发时，是否阻止硬件预取本任务的信息
    ACL_RT_LAUNCH_KERNEL_ATTR_DATA_DUMP,                // 是否开启Dump
    ACL_RT_LAUNCH_KERNEL_ATTR_TIMEOUT,                  // 任务调度器等待任务执行的超时时间，单位秒
    ACL_RT_LAUNCH_KERNEL_ATTR_TIMEOUT_US = 8,           // 任务调度器等待任务执行的超时时间，单位微秒
} aclrtLaunchKernelAttrId;
```

