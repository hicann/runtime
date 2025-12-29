# aclrtMemcpyKind

```
typedef enum aclrtMemcpyKind {
    ACL_MEMCPY_HOST_TO_HOST,     // Host内的内存复制
    ACL_MEMCPY_HOST_TO_DEVICE,   // Host到Device的内存复制
    ACL_MEMCPY_DEVICE_TO_HOST,   // Device到Host的内存复制
    ACL_MEMCPY_DEVICE_TO_DEVICE, // Device内或两个Device间的内存复制
    ACL_MEMCPY_DEFAULT,          // 由系统根据源、目的内存地址自行判断拷贝方向
    ACL_MEMCPY_HOST_TO_BUF_TO_DEVICE,   // Host到Device的内存复制，但Host内存会暂存在Runtime管理的缓存中，内存复制接口调用成功后，就可以释放Host内存 
    ACL_MEMCPY_INNER_DEVICE_TO_DEVICE,  // Device内的内存复制 
    ACL_MEMCPY_INTER_DEVICE_TO_DEVICE,  // 两个Device之间的内存复制 
} aclrtMemcpyKind;
```

