# aclmdlRITaskParams

```
typedef struct aclmdlRITaskParams {
    aclmdlRITaskType type;
    uint32_t rsv0[3];
    aclrtTaskGrp taskGrp;
    void* opInfoPtr;
    size_t opInfoSize;
    uint8_t rsv1[32];

    union {
        uint8_t rsv2[128];
        struct aclmdlRIKernelTaskParams kernelTaskParams;
        struct aclmdlRIEventRecordTaskParams eventRecordTaskParams;
        struct aclmdlRIEventWaitTaskParams eventWaitTaskParams;
        struct aclmdlRIEventResetTaskParams eventResetTaskParams;
        struct aclmdlRIValueWriteTaskParams valueWriteTaskParams;
        struct aclmdlRIValueWaitTaskParams valueWaitTaskParams;
    };
} aclmdlRITaskParams;
```

| 成员名称 | 描述 |
| --- | --- |
| type | 任务类型，类型为 [aclmdlRITaskType](aclmdlRITaskType.md)。|
| rsv0 | 预留参数。 |
| taskGrp | 用于更新aclGraph模型的taskGrp句柄，类型为 [aclrtTaskGrp](aclrtTaskGrp.md)。<br>该参数作为查询接口的输出，设置接口无需关注。|
| opInfoPtr | 存放算子shape信息的地址指针。 |
| opInfoSize | 算子shape信息的大小，单位为Byte。 |
| rsv1 | 预留参数。 |
| rsv2 | 预留参数。 |
| kernelTaskParams | 算子类型任务的参数，类型为 [aclmdlRIKernelTaskParams](aclmdlRIKernelTaskParams.md)。 |
| eventRecordTaskParams | Event Record任务的参数，类型为 [aclmdlRIEventRecordTaskParams](aclmdlRIEventRecordTaskParams.md)。 |
| eventWaitTaskParams | Event Wait任务的参数，类型为 [aclmdlRIEventWaitTaskParams](aclmdlRIEventWaitTaskParams.md)。 |
| eventResetTaskParams | Event Reset任务的参数，类型为 [aclmdlRIEventResetTaskParams](aclmdlRIEventResetTaskParams.md)。 |
| valueWriteTaskParams | Value Write任务的参数，类型为 [aclmdlRIValueWriteTaskParams](aclmdlRIValueWriteTaskParams.md)。 |
| valueWaitTaskParams | Value Wait任务的参数，类型为 [aclmdlRIValueWaitTaskParams](aclmdlRIValueWaitTaskParams.md)。 |
