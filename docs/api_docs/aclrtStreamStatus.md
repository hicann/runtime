# aclrtStreamStatus<a name="ZH-CN_TOPIC_0000001651125572"></a>

```
typedef enum aclrtStreamStatus {
    ACL_STREAM_STATUS_COMPLETE  = 0,      // Stream上的所有任务已完成
    ACL_STREAM_STATUS_NOT_READY = 1,      // Stream上至少有一个任务未完成
    ACL_STREAM_STATUS_RESERVED  = 0xFFFF, // 预留
} aclrtStreamStatus;
```

