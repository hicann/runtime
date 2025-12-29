# aclrtRandomTaskUpdateAttr

```
typedef struct { 
    void *srcAddr;    
    size_t size;      
    uint32_t rsv[4];  
} aclrtRandomTaskUpdateAttr;
```


| 成员名称 | 说明 |
| --- | --- |
| srcAddr | 存放待刷新数据的Device内存地址，需按照[aclrtRandomNumTaskInfo](aclrtRandomNumTaskInfo.md)结构体组织数据，且仅支持更新该结构体内的randomParaAddr、randomResultAddr、randomCounterAddr、randomSeed、randomNum参数值。 |
| size | 内存大小，单位Byte。 |
| rsv | 预留参数。当前固定配置为0。 |

