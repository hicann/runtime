# aclrtMemcpyBatchAttr

```
typedef struct {
    aclrtMemLocation dstLoc;   
    aclrtMemLocation srcLoc;   
    uint8_t rsv[16];           
} aclrtMemcpyBatchAttr;
```


| 成员名称 | 说明 |
| --- | --- |
| dstLoc | 目的内存所在位置。类型定义请参见[aclrtMemLocation](aclrtMemLocation.md)。 |
| srcLoc | 源内存所在位置。类型定义请参见[aclrtMemLocation](aclrtMemLocation.md)。 |
| rsv | 预留参数，当前固定配置为0。 |

