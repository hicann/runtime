# aclrtAicAivTaskUpdateAttr

```
typedef struct { 
    void *binHandle;      
    void *funcEntryAddr;  
    void *blockDimAddr;   
    uint32_t rsv[4];      
} aclrtAicAivTaskUpdateAttr;
```


| 成员名称 | 说明 |
| --- | --- |
| binHandle | 存放待刷新的算子二进制句柄，可调用[aclrtBinaryLoadFromFile](aclrtBinaryLoadFromFile.md)或[aclrtBinaryLoadFromData](aclrtBinaryLoadFromData.md)接口获取算子二进制句柄。 |
| funcEntryAddr | 存放Function Entry（用于标识函数的关键字）的Device内存地址。 |
| blockDimAddr | 存放blockDim(用于指定核函数将会在几个核上执行)的Device内存地址 |
| rsv | 预留参数。当前固定配置为0。 |

