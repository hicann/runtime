# aclmdlRIValueWaitTaskParams

```
typedef struct aclmdlRIValueWaitTaskParams {
    void *devAddr;
    uint64_t value;
    uint32_t flag;
} aclmdlRIValueWaitTaskParams;
```

| 成员名称 | 描述 |
| --- | --- |
| devAddr | Device侧内存地址。<br>devAddr的有效内存位宽为64bit。|
| value | 需与内存中的数据作比较的值。|
| flag | 与内存中数据的比较方式，参照 [aclrtValueWait](aclrtValueWait.md)。|
