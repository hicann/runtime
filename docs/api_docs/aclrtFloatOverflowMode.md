# aclrtFloatOverflowMode

```
typedef enum aclrtFloatOverflowMode {
    ACL_RT_OVERFLOW_MODE_SATURATION = 0, // 溢出检测饱和模式
    ACL_RT_OVERFLOW_MODE_INFNAN,         // 溢出检测Inf/NaN模式，默认值
    ACL_RT_OVERFLOW_MODE_UNDEF,
} aclrtFloatOverflowMode;
```

对比于Inf/NaN模式，饱和模式下，计算结果如果是Inf，最终结果是一个极大值；计算结果如果是NaN，最终结果是0。若设置成饱和模式，计算精度可能存在误差，该模式仅为兼容旧版本，后续不演进。

