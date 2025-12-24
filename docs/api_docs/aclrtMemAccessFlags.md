# aclrtMemAccessFlags<a name="ZH-CN_TOPIC_0000002505554601"></a>

```
typedef enum {
    ACL_RT_MEM_ACCESS_FLAGS_NONE = 0x0,      // 该地址范围不可访问 
    ACL_RT_MEM_ACCESS_FLAGS_READ = 0x1,      // 地址范围可读
    ACL_RT_MEM_ACCESS_FLAGS_READWRITE = 0x3, // 地址范围可读可写
} aclrtMemAccessFlags;
```

