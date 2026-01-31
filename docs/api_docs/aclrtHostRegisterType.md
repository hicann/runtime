# aclrtHostRegisterType

```
typedef enum {
    ACL_HOST_REGISTER_MAPPED = 0,
    ACL_HOST_REGISTER_IOMEMORY = 0x04,
    ACL_HOST_REGISTER_READONLY = 0x08
}aclrtHostRegisterType;
```


| 枚举项 | 说明 |
| --- | --- |
| ACL_HOST_REGISTER_MAPPED | Host内存映射注册为Device可访问，包括读写。 |
| ACL_HOST_REGISTER_IOMEMORY | 将Host上第三方PCIe设备的IO space(寄存器、缓存)映射注册为Device可访问，包括读写。 |
| ACL_HOST_REGISTER_READONLY | Host内存映射注册为Device只读。<br>仅Atlas A3 训练系列产品/Atlas A3 推理系列产品、Atlas A2 训练系列产品/Atlas A2 推理系列产品支持该选项。 |

