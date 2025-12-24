# aclrtEventRecordedStatus<a name="ZH-CN_TOPIC_0000001265400262"></a>

```
typedef enum aclrtEventRecordedStatus {
    ACL_EVENT_RECORDED_STATUS_NOT_READY = 0,  //Event未被记录到Stream中，或记录到Stream中的Event未被执行或执行失败
    ACL_EVENT_RECORDED_STATUS_COMPLETE = 1,   //记录到Stream中的Event执行成功
} aclrtEventRecordedStatus;
```

