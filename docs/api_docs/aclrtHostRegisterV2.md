# aclrtHostRegisterV2

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

注册Host内存地址。

取消注册需调用[aclrtHostUnregister](aclrtHostUnregister.md)接口。

## 函数原型

```
aclError aclrtHostRegisterV2(void *ptr, uint64_t size, uint32_t flag)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| ptr | 输入 | Host内存地址。<br>Host内存地址需4K页对齐。<br>当os内核版本为5.10或更低时，使用非锁页内存会导致异常，因此必须调用aclrtMallocHost接口来申请Host锁页内存。<br>当os内核版本为5.10以上时，支持使用非锁页的Host内存，因此既支持调用aclrtMallocHost接口申请Host锁页内存，也支持使用malloc接口申请Host非锁页内存。 |
| size | 输入 | 内存大小，单位Byte。 |
| flag | 输入 | 内存注册类型。<br>取值为如下宏，支持配置单个宏，也支持配置多个宏位或（例如ACL_HOST_REG_MAPPED | ACL_HOST_REG_PINNED）。：<br><br>  - ACL_HOST_REG_MAPPED：将Host内存映射注册为Device可访问的内存地址，再配合调用[aclrtHostGetDevicePointer](aclrtHostGetDevicePointer.md)接口获取映射后的Device内存地址。<br>  - ACL_HOST_REG_PINNED：将Host内存注册为锁页内存。<br><br><br>宏定义如下：<br>#define ACL_HOST_REG_MAPPED 0x2UL<br>#define ACL_HOST_REG_PINNED 0X10000000UL |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

