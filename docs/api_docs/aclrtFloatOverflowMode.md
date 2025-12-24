# aclrtFloatOverflowMode<a name="ZH-CN_TOPIC_0000001382754406"></a>

```
typedef enum aclrtFloatOverflowMode {
    ACL_RT_OVERFLOW_MODE_SATURATION = 0, // 溢出检测饱和模式，设置成该模式，计算精度可能存在误差，该模式仅为兼容旧版本，后续不演进
    ACL_RT_OVERFLOW_MODE_INFNAN,         // 溢出检测Inf/NaN模式，默认值
    ACL_RT_OVERFLOW_MODE_UNDEF,
} aclrtFloatOverflowMode;
```

