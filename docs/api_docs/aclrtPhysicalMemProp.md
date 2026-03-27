# aclrtPhysicalMemProp

```
typedef struct aclrtPhysicalMemProp {
    aclrtMemHandleType handleType;
    aclrtMemAllocationType allocationType;
    aclrtMemAttr memAttr;
    aclrtMemLocation location;
    uint64_t reserve; 
} aclrtPhysicalMemProp;
```


| 成员名称 | 描述 |
| --- | --- |
| handleType | handle类型。类型定义请参见[aclrtMemHandleType](aclrtMemHandleType.md)。<br>当前仅支持ACL_MEM_HANDLE_TYPE_NONE 。 |
| allocationType | 内存分配类型。类型定义请参见[aclrtMemAllocationType](aclrtMemAllocationType.md)。<br>当前仅支持ACL_MEM_ALLOCATION_TYPE_PINNED，表示锁页内存。 |
| memAttr | 内存属性。类型定义请参见[aclrtMemAttr](aclrtMemAttr.md)。 |
| location | 内存所在位置。类型定义请参见[aclrtMemLocation](aclrtMemLocation.md)。<br>当type为ACL_MEM_LOCATION_TYPE_HOST时，id无效，固定设置为0即可。 |
| reserve | 预留。 |

