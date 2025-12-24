# aclrtEventWaitStatus<a name="ZH-CN_TOPIC_0000001264921498"></a>

```
typedef enum aclrtEventWaitStatus {
    ACL_EVENT_WAIT_STATUS_COMPLETE  = 0,      // 完成
    ACL_EVENT_WAIT_STATUS_NOT_READY = 1,      // 未完成
    ACL_EVENT_WAIT_STATUS_RESERVED  = 0xFFFF, // 预留
} aclrtEventWaitStatus;
```

