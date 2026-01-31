# aclrtMemGetAddressRange

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

获取待查询地址所属内存块的起始地址以及内存块大小。

## 函数原型

```
aclError aclrtMemGetAddressRange(void *ptr, void **pbase, size_t *psize)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| ptr | 输入 | 待查询的内存地址。 |
| pbase | 输出 | 返回待查询地址所属内存块的起始地址。 |
| psize | 输出 | 返回待查询地址所属内存块的大小，单位Byte。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

## 参考信息


| 使用场景 | aclrtMemGetAddressRange接口行为 |
| --- | --- |
| 查询通过aclrtMalloc接口或aclrtMallocWithCfg接口返回的Device内存内存 | 返回内存块的起始地址和内存大小 |
| 查询通过aclrtMallocHost接口或aclrtMallocHostWithCfg接口返回的Host内存内存 | 返回内存块的起始地址和内存大小。 |
| 查询通过aclrtReserveMemAddress、aclrtMallocPhysical、aclrtMapMem等接口映射过的虚拟内存地址 | 返回经过映射的内存块的起始地址和内存大小 |

