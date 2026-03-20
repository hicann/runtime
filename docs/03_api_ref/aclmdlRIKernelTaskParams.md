# aclmdlRIKernelTaskParams

```
typedef struct aclmdlRIKernelTaskParams {
    aclrtFuncHandle funcHandle;
    aclrtLaunchKernelCfg* cfg;
    void* args;
    uint32_t isHostArgs;
    size_t argsSize;
    uint32_t numBlocks;
    uint32_t rsv[10];
} aclmdlRIKernelTaskParams;
```

| 成员名称 | 描述 |
| --- | --- |
| funcHandle | 核函数句柄，类型为 [aclrtFuncHandle](aclrtFuncHandle.md)。|
| cfg | 下发任务的配置信息，类型为 [aclrtLaunchKernelCfg](aclrtLaunchKernelCfg.md)。|
| args | 存放核函数所有入参数据的地址指针。|
| isHostArgs | 标识args的内存属性，0：device内存，1：host内存，该参数在查询接口中固定为0。 |
| argsSize | args参数值的大小，单位为Byte。 |
| numBlocks | 指定核函数将会在几个核上执行。 |
| rsv | 预留参数。 |