# aclprofAicoreMetrics

```
typedef enum {
    ACL_AICORE_ARITHMETIC_UTILIZATION = 0,     // 各种计算类指标占比统计
    ACL_AICORE_PIPE_UTILIZATION = 1,           // 计算单元和搬运单元耗时占比
    ACL_AICORE_MEMORY_BANDWIDTH = 2,           // 外部内存读写类指令占比
    ACL_AICORE_L0B_AND_WIDTH = 3,              // 内部内存读写类指令占比
    ACL_AICORE_RESOURCE_CONFLICT_RATIO = 4,    // 流水线队列类指令占比
    ACL_AICORE_MEMORY_UB = 5,                  // 内部内存读写指令占比
    ACL_AICORE_L2_CACHE = 6,                   // 读写cache命中次数和缺失后重新分配次数
    ACL_AICORE_PIPE_EXECUTE_UTILIZATION = 7,   // 计算单元和搬运单元耗时占比
    ACL_AICORE_MEMORY_ACCESS = 8,              // 算子在核上访存的带宽数据量
    ACL_AICORE_NONE = 0xFF
}aclprofAicoreMetrics;
```

Atlas A2 训练系列产品/Atlas A2 推理系列产品：不支持ACL\_AICORE\_PIPE\_EXECUTE\_UTILIZATION

Atlas A3 训练系列产品/Atlas A3 推理系列产品：不支持ACL\_AICORE\_PIPE\_EXECUTE\_UTILIZATION

Ascend 950PR/Ascend950DT：不支持ACL\_AICORE\_L2\_CACHE、ACL\_AICORE\_PIPE\_EXECUTE\_UTILIZATION、ACL\_AICORE\_MEMORY\_ACCESS

