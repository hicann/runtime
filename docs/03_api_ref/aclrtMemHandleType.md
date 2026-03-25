# aclrtMemHandleType

```
typedef enum aclrtMemHandleType {
    ACL_MEM_HANDLE_TYPE_NONE = 0,  // 通用handle，无类型标识
    ACL_MEM_HANDLE_TYPE_POSIX = 2, // POSIX类型的hanlde，表示内存可以通过POSIX文件描述符导出，建议仅在POSIX系统中配置该属性
} aclrtMemHandleType;
```
