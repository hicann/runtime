# aclrtMallocAttrType

```
typedef enum {
    ACL_RT_MEM_ATTR_RSV = 0,    // 预留值
    ACL_RT_MEM_ATTR_MODULE_ID,  // 表示模块ID
    ACL_RT_MEM_ATTR_DEVICE_ID,  // 表示Device ID
    ACL_RT_MEM_ATTR_VA_FLAG,    // 使用aclrtMallocHostWithCfg接口申请Host内存时，是否使用VA（virtual address）一致性功能
} aclrtMallocAttrType;
```

