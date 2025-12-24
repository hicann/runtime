# aclprofAicoreMetrics<a name="ZH-CN_TOPIC_0000001312481645"></a>

```
typedef enum {
    ACL_AICORE_ARITHMETIC_UTILIZATION = 0,  //各种计算类指标占比统计
    ACL_AICORE_PIPE_UTILIZATION = 1,        //计算单元和搬运单元耗时占比
    ACL_AICORE_MEMORY_BANDWIDTH = 2,        //外部内存读写类指令占比
    ACL_AICORE_L0B_AND_WIDTH = 3,           //内部内存读写类指令占比
    ACL_AICORE_RESOURCE_CONFLICT_RATIO = 4,    //流水线队列类指令占比
    ACL_AICORE_MEMORY_UB = 5,               //内部内存读写指令占比
    ACL_AICORE_L2_CACHE = 6,                //读写cache命中次数和缺失后重新分配次数，支持的产品型号：
                                            //Ascend 910B
                                            //Ascend 910C
    ACL_AICORE_MEMORY_ACCESS = 8,           //算子在核上访存的带宽数据量，支持的产品型号：
                                            //Ascend 910B
                                            //Ascend 910C
    ACL_AICORE_NONE = 0xFF
}aclprofAicoreMetrics;
```

