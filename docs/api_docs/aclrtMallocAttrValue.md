# aclrtMallocAttrValue

```
typedef union {
    uint16_t moduleId; 
    uint32_t deviceId;  
    uint32_t vaFlag;
    uint8_t rsv[8]; 
} aclrtMallocAttrValue;
```


| 成员名称 | 说明 |
| --- | --- |
| moduleId | 模块ID，建议配置为33，表示APP，用于表示该内存是由用户的应用程序申请的，便于维测场景下定位问题。 |
| deviceId | Device ID，若此处配置的Device ID与当前用于计算的Device ID不一致，接口会返回报错，建议不配置该属性值。 |
| vaFlag | 使用aclrtMallocHostWithCfg接口申请Host内存时，是否使用VA（virtual address）一致性功能：<br><br>  - 0：不使用（默认值）。<br>  - 1：使用，申请的Host内存通过[aclrtHostRegister](aclrtHostRegister.md)接口注册后，返回的devPtr与ptr（表示Host内存地址）一致，Host和Device可以使用相同的VA访问。<br><br>仅部分产品型号支持使用VA一致性功能，不支持的型号使用该功能将返回报错。支持的产品型号如下：<br>Atlas A3 训练系列产品/Atlas A3 推理系列产品<br>Atlas A2 训练系列产品/Atlas A2 推理系列产品 |
| rsv | 预留参数。当前固定配置为0。 |

