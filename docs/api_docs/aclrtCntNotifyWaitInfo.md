# aclrtCntNotifyWaitInfo<a name="ZH-CN_TOPIC_0000002461956130"></a>

```
typedef struct {
    aclrtCntNotifyWaitMode mode;  // Wait的行为模式
    uint32_t value;
    uint32_t timeout;             // 超时时间，单位是秒，其中，0表示永久等待
    bool isClear;                 // wait解除阻塞后是否CntNotify的计数值自动清空为0，取值：1表示清空，0表示不清空
    uint8_t rev[3U];
} aclrtCntNotifyWaitInfo;
```

