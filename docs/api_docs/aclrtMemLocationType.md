# aclrtMemLocationType

```
typedef enum aclrtMemLocationType {
    ACL_MEM_LOCATION_TYPE_HOST = 0,      // 通过acl接口（例如aclrtMallocHost）申请的Host内存
    ACL_MEM_LOCATION_TYPE_DEVICE,        // 通过acl接口（例如aclrtMalloc）申请的Device内存
    ACL_MEM_LOCATION_TYPE_UNREGISTERED,  // 未通过acl接口申请的内存
    ACL_MEM_LOCATION_TYPE_HOST_NUMA = 4, // 通过aclrtMallocPhysical接口按照NUMA ID申请Host内存，预留选项
} aclrtMemLocationType;
```

