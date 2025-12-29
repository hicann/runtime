# aclrtRandomNumTaskInfo

```
typedef struct { 
    aclDataType dataType; 
    aclrtRandomNumFuncParaInfo randomNumFuncParaInfo;
    void *randomParaAddr;  
    void *randomResultAddr; 
    void *randomCounterAddr;
    aclrtRandomParaInfo randomSeed; 
    aclrtRandomParaInfo randomNum; 
    uint8_t rsv[10]; 
} aclrtRandomNumTaskInfo;
```


| 成员名称 | 说明 |
| --- | --- |
| dataType | 随机数数据类型。仅支持如下数据类型：ACL_INT32、ACL_INT64、ACL_UINT32、ACL_UINT64、ACL_BF16、ACL_FLOAT16、ACL_FLOAT。 |
| randomNumFuncParaInfo | 随机数函数信息，包括函数类别、参数信息。 |
| randomParaAddr | 此处传NULL时，由接口内部自行申请Device内存，存放randomNumFuncParaInfo参数中的数据；否则，由用户申请Device内存，将内存地址作为参数传入。 |
| randomResultAddr | 存放随机数结果的内存地址。<br>由用户提前申请Device内存，将内存地址作为参数传入。 |
| randomCounterAddr | 生成随机数的偏移量。<br>由用户提前申请Device内存，读入偏移量数据后，再将内存地址作为参数传入 |
| randomSeed | 随机种子。 |
| randomNum | 随机数个数。 |
| rsv | 预留参数。当前固定配置为0。 |

