# aclrtKernelType

```
typedef enum {
    ACL_KERNEL_TYPE_AICORE = 0,    // AI Core
    ACL_KERNEL_TYPE_CUBE = 1,      // Cube Core
    ACL_KERNEL_TYPE_VECTOR = 2,    // Vector Core
    ACL_KERNEL_TYPE_MIX = 3,       // 会同时启动AI Core上的Cube Core和Vector Core
    ACL_KERNEL_TYPE_AICPU = 100,   // AI CPU
} aclrtKernelType;
```

不同产品上的AI数据处理核心单元不同，关于Core的定义及详细说明，请参见[aclrtDevAttr](aclrtDevAttr.md)。

