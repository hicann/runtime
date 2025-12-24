# aclrtCntNotifyRecordMode<a name="ZH-CN_TOPIC_0000002462072616"></a>

```
typedef enum {
    ACL_RT_CNT_NOTIFY_RECORD_SET_VALUE_MODE = 0,      // 覆盖模式，CntNotify计数值 = value
    ACL_RT_CNT_NOTIFY_RECORD_ADD_MODE = 1,            // 累加模式，CntNotify计数值 = 当前值 + value
    ACL_RT_CNT_NOTIFY_RECORD_BIT_OR_MODE = 2,         // bit或模式，CntNotify计数值 = 当前值 | value
    ACL_RT_CNT_NOTIFY_RECORD_BIT_AND_MODE = 4,        // bit与模式，CntNotify计数值 = 当前值 & value
} aclrtCntNotifyRecordMode;
```

