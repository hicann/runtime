# aclrtPtrAttributes

```
typedef struct aclrtPtrAttributes {
    aclrtMemLocation location; 
    uint32_t pageSize;   
    uint32_t rsv[4];    
} aclrtPtrAttributes;
```


| 成员名称 | 说明 |
| --- | --- |
| location | 内存所在位置。 |
| pageSize | 页表大小，单位Byte。 |
| rsv | 预留参数。当前固定配置为0。 |

