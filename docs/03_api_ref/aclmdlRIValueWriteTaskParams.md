# aclmdlRIValueWriteTaskParams

```
typedef struct aclmdlRIValueWriteTaskParams {
    void *devAddr;
    uint64_t value;
} aclmdlRIValueWriteTaskParams;
```

| 成员名称 | 描述 |
| --- | --- |
| devAddr | Device侧内存地址。<br>此处需用户提前申请Device内存（例如调用aclrtMalloc接口），devAddr要求8字节对齐，有效内存位宽为64bit。|
| value | 需向内存中写入的数据。|
