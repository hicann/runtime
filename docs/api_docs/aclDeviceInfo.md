# aclDeviceInfo<a name="ZH-CN_TOPIC_0000001819827396"></a>

```
typedef enum {
    ACL_DEVICE_INFO_UNDEFINED = -1,       // 未知规格
    ACL_DEVICE_INFO_AI_CORE_NUM = 0,      // AI Core数量
    ACL_DEVICE_INFO_VECTOR_CORE_NUM = 1,  // Vector Core数量
    ACL_DEVICE_INFO_L2_SIZE = 2           // L2 Buffer大小，单位Byte
} aclDeviceInfo;
```

