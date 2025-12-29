# aclrtAllocatorSetAllocAdviseFuncToDesc

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

使用用户提供的Allocator场景下，设置"根据建议地址申请内存block"的回调函数，一般用于内存复用场景。

## 函数原型

```
aclError aclrtAllocatorSetAllocAdviseFuncToDesc(aclrtAllocatorDesc allocatorDesc, aclrtAllocatorAllocAdviseFunc func)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| allocatorDesc | 输入 | Allocator描述符指针。<br>需提前调用[aclrtAllocatorCreateDesc](aclrtAllocatorCreateDesc.md)接口设置Allocator描述信息。 |
| func | 输入 | 根据建议地址申请内存block的回调函数。<br>回调函数定义如下：<br>typedef void *(*aclrtAllocatorAllocAdviseFunc)([aclrtAllocator](aclrtAllocator.md) allocator, size_t size, [aclrtAllocatorAddr](aclrtAllocatorAddr.md) addr); |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

