# aclrtCntNotifyWaitMode<a name="ZH-CN_TOPIC_0000002495155221"></a>

```
typedef enum {
    ACL_RT_CNT_NOTIFY_WAIT_LESS_MODE = 0,               // CntNotify的当前计数值 < value，则解除Wait
    ACL_RT_CNT_NOTIFY_WAIT_EQUAL_MODE = 1,              // CntNotify的当前计数值 = value，则解除Wait
    ACL_RT_CNT_NOTIFY_WAIT_BIGGER_MODE = 2,             // CntNotify的当前计数值 > value，则解除Wait
    ACL_RT_CNT_NOTIFY_WAIT_BIGGER_OR_EQUAL_MODE = 3,    // CntNotify的当前计数值 >= value，则解除Wait
    ACL_RT_CNT_NOTIFY_WAIT_EQUAL_WITH_BITMASK_MODE = 4, // CntNotify的当前计数值 & value = value，则解除Wait
} aclrtCntNotifyWaitMode;
```

