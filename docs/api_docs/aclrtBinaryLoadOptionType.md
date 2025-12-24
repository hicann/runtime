# aclrtBinaryLoadOptionType<a name="ZH-CN_TOPIC_0000002253071373"></a>

```
typedef enum aclrtBinaryLoadOptionType {
    ACL_RT_BINARY_LOAD_OPT_LAZY_LOAD = 1,       // 指定解析算子二进制、注册算子后，是否加载算子到Device侧
    ACL_RT_BINARY_LOAD_OPT_LAZY_MAGIC = 2,      // 废弃，请使用ACL_RT_BINARY_LOAD_OPT_MAGIC
    ACL_RT_BINARY_LOAD_OPT_MAGIC = 2,           // 标识算子类型的魔术数字
    ACL_RT_BINARY_LOAD_OPT_CPU_KERNEL_MODE = 3, // AI CPU算子注册模式
} aclrtBinaryLoadOptionType;
```

