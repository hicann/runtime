# aclrtHostRegister

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

将Host内存映射注册为Device可访问的内存地址，并获取映射后的Device内存地址。映射后的Device内存地址不能用于内存操作，例如内存复制。

如果注册的ptr是通过[aclrtMallocHostWithCfg](aclrtMallocHostWithCfg.md)申请的，并且申请时配置的attr类型是ACL\_RT\_MEM\_ATTR\_VA\_FLAG，vaFlag的值为1，则映射后的Device地址与Host地址一致，可以进行内存操作。

取消注册Host内存需调用[aclrtHostUnregister](aclrtHostUnregister.md)接口。

## 函数原型

```
aclError aclrtHostRegister(void *ptr, uint64_t size, aclrtHostRegisterType type, void **devPtr)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| ptr | 输入 | Host内存地址。<br>Host内存地址需4K页对齐。<br>当os内核版本为5.10或更低时，使用非锁页内存会导致异常，因此必须调用aclrtMallocHost接口来申请Host锁页内存。<br>当os内核版本为5.10以上时，支持使用非锁页的Host内存，因此既支持调用aclrtMallocHost接口申请Host锁页内存，也支持使用malloc接口申请Host非锁页内存。 |
| size | 输入 | 内存大小，单位Byte。 |
| type | 输入 | 内存注册类型。 |
| devPtr | 输出 | Host内存映射成的Device可访问的内存地址。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

