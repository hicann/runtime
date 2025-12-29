# aclrtMemSharedHandleType

```
typedef enum aclrtMemSharedHandleType {
    ACL_MEM_SHARE_HANDLE_TYPE_DEFAULT = 0x1,  
    ACL_MEM_SHARE_HANDLE_TYPE_FABRIC = 0x2,
} aclrtMemSharedHandleType;
```

**表 1**  枚举项说明


| 枚举项 | 说明 |
| --- | --- |
| ACL_MEM_SHARE_HANDLE_TYPE_DEFAULT | 默认值，AI Server内跨进程共享内存。 |
| ACL_MEM_SHARE_HANDLE_TYPE_FABRIC | 跨AI Server跨进程共享内存，包含一个AI Server内的场景。<br>仅Atlas A3 训练系列产品/Atlas A3 推理系列产品支持该选项。<br>其它产品型号当前不支持该选项。 |

