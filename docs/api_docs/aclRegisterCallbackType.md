# aclRegisterCallbackType<a name="ZH-CN_TOPIC_0000002452458288"></a>

```
typedef enum aclRegisterCallbackType {
ACL_REG_TYPE_ACL_MODEL,           // 模型管理
ACL_REG_TYPE_ACL_OP_EXECUTOR,     // 单算子调用
ACL_REG_TYPE_ACL_OP_CBLAS,        // 单算子调用中的CBLAS接口
ACL_REG_TYPE_ACL_OP_COMPILER,     // 单算子编译
ACL_REG_TYPE_ACL_TDT_CHANNEL,     // Tensor数据传输
ACL_REG_TYPE_ACL_TDT_QUEUE,       // 共享队列管理
ACL_REG_TYPE_ACL_DVPP,            // 媒体数据处理
ACL_REG_TYPE_ACL_RETR,            // 特征向量检索
ACL_REG_TYPE_OTHER = 0xFFFF,      // 自定义功能
} aclRegisterCallbackType;
```

