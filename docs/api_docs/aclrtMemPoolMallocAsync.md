# aclrtMemPoolMallocAsync

**须知：本接口为试验特性，后续版本可能会存在变更，不支持应用于商用产品中。**

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | ✕ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明
异步内存申请接口，从内存池中申请指定大小的内存。

## 函数原型

```
aclError aclrtMemPoolMallocAsync(void **ptr, size_t size, aclrtMemPool memPool, aclrtStream stream)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| ptr | 输出 | 指向待分配内存地址的指针。 |
| size | 输入 | 待分配的内存大小，单位Byte。 |
| memPool | 输入 | 内存池实例，类型为 [aclrtMemPool](aclrtMemPool.md)。 |
| stream | 输入 | 指定的流，类型为 [aclrtStream](aclrtStream.md)。 |

## 返回值说明
返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。