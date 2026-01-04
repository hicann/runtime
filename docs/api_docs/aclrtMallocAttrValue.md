# aclrtMallocAttrValue

```
typedef union {
    uint16_t moduleId; 
    uint32_t deviceId;  
    uint8_t rsv[8]; 
} aclrtMallocAttrValue;
```


| 成员名称 | 说明 |
| --- | --- |
| moduleId | 模块ID，建议配置为33，表示APP，用于表示该内存是由用户的应用程序申请的，便于维测场景下定位问题。 |
| deviceId | Device ID，若此处配置的Device ID与当前用于计算的Device ID不一致，接口会返回报错，建议不配置该属性值。 |
| rsv | 预留参数。当前固定配置为0。 |

