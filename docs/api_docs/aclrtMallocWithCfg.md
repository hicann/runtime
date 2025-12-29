# aclrtMallocWithCfg

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

在Device上分配size大小的线性内存，并通过\*devPtr返回已分配内存的指针，且内存首地址64字节对齐。本接口分配的内存，会进行字节对齐，会对用户申请的size向上对齐成32字节整数倍后再多加32字节。与aclrtMalloc接口相比，本接口在申请内存时，还可以指定内存相关的配置信息。

## 函数原型

```
aclError aclrtMallocWithCfg(void **devPtr, size_t size, aclrtMemMallocPolicy policy, aclrtMallocConfig *cfg)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| devPtr | 输出 | “Device上已分配内存的指针”的指针。 |
| size | 输入 | 申请内存的大小，单位Byte。<br>size不能为0。 |
| policy | 输入 | 内存分配规则。<br>若配置的内存分配规则超出[aclrtMemMallocPolicy](aclrtMemMallocPolicy.md)取值范围，size≥2M时，按大页申请内存，否则按普通页申请内存。 |
| cfg | 输入 | 内存配置信息。<br>不指定配置时，此处可传NULL。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

