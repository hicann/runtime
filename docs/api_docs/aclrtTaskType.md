# aclrtTaskType

```
typedef enum aclrtTaskType {
    ACL_RT_TASK_DEFAULT,      // 除以下类型之外的其他类型
    ACL_RT_TASK_KERNEL,       // Cube Core或Vector Core上计算任务
    ACL_RT_TASK_EVENT_RECORD, // EVENT RECORD任务，通常对应aclrtRecordEvent接口下发的任务
    ACL_RT_TASK_EVENT_WAIT,   // EVENT WAIT任务，通常对应aclrtStreamWaitEvent或aclrtStreamWaitEventWithTimeout接口下发的任务
    ACL_RT_TASK_EVENT_RESET,  // EVENT RESET任务，通常对应aclrtResetEvent接口下发的任务
    ACL_RT_TASK_VALUE_WRITE,  // VALUE WRITE任务，通常对应aclrtValueWrite接口下发的任务
    ACL_RT_TASK_VALUE_WAIT,   // VALUE WAIT任务，通常对应aclrtValueWait接口下发的任务
} aclrtTaskType;
```

