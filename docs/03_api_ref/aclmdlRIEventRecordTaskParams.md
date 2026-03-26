# aclmdlRIEventRecordTaskParams

```
typedef struct aclmdlRIEventRecordTaskParams {
    aclrtEvent event;
    uint64_t eventFlag;
} aclmdlRIEventRecordTaskParams;
```

| 成员名称 | 描述 |
| --- | --- |
| event | Event句柄，类型为 [aclrtEvent](aclrtEvent.md)。|
| eventFlag | Event指针的flag，详细说明见 [aclrtCreateEventExWithFlag](aclrtCreateEventExWithFlag.md) 和 [aclrtCreateEventWithFlag](aclrtCreateEventWithFlag.md)。 |
