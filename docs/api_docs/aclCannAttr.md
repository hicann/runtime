# aclCannAttr

```
typedef enum {
    ACL_CANN_ATTR_UNDEFINED = -1,   // 未知特性
    ACL_CANN_ATTR_INF_NAN = 0,      // 溢出检测Inf/NaN模式
    ACL_CANN_ATTR_BF16 = 1,         // bf16数据类型
    ACL_CANN_ATTR_JIT_COMPILE = 2   // 算子二进制特性
} aclCannAttr;
```

