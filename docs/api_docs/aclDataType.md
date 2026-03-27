# aclDataType

```
typedef enum {
    ACL_DT_UNDEFINED = -1,  //未知数据类型，默认值
    ACL_FLOAT = 0,          // fp32
    ACL_FLOAT16 = 1,
    ACL_INT8 = 2,
    ACL_INT32 = 3,
    ACL_UINT8 = 4,
    ACL_INT16 = 6,
    ACL_UINT16 = 7,
    ACL_UINT32 = 8,
    ACL_INT64 = 9,
    ACL_UINT64 = 10,
    ACL_DOUBLE = 11,
    ACL_BOOL = 12,
    ACL_STRING = 13,
    ACL_COMPLEX64 = 16,
    ACL_COMPLEX128 = 17,
    ACL_BF16 = 27,
    ACL_INT4 = 29,
    ACL_UINT1 = 30,
    ACL_COMPLEX32 = 33,
    ACL_HIFLOAT8 = 34,      
    ACL_FLOAT8_E5M2 = 35,   
    ACL_FLOAT8_E4M3FN = 36, 
    ACL_FLOAT8_E8M0 = 37,   
    ACL_FLOAT6_E3M2 = 38,   
    ACL_FLOAT6_E2M3 = 39,   
    ACL_FLOAT4_E2M1 = 40,   
    ACL_FLOAT4_E1M2 = 41,   
} aclDataType;
```

对于33\~41的枚举选项，各产品型号的支持情况如下：

Ascend 950PR/Ascend950DT，支持

Atlas A3 训练系列产品/Atlas A3 推理系列产品，不支持

Atlas A2 训练系列产品/Atlas A2 推理系列产品，不支持

