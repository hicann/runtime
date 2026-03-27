# aclrtMallocConfig

```
typedef struct {
    aclrtMallocAttribute* attrs; 
    size_t numAttrs;     
} aclrtMallocConfig;
```


| 成员名称 | 说明 |
| --- | --- |
| attrs | 属性，本参数是数组，可存放多个属性。类型定义请参见[aclrtMallocAttribute](aclrtMallocAttribute.md)。 |
| numAttrs | 属性个数。 |

