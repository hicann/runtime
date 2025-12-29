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
| dstLoc | 目的内存所在位置。 |
| srcLoc | 源内存所在位置。 |
| rsv | 预留参数，当前固定配置为0。 |

