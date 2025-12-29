# aclrtAllocatorGetByStream

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

根据Stream查询用户注册的Allocator信息。

## 函数原型

```
aclError aclrtAllocatorGetByStream(aclrtStream stream, aclrtAllocatorDesc *allocatorDesc, aclrtAllocator *allocator, aclrtAllocatorAllocFunc *allocFunc, aclrtAllocatorFreeFunc *freeFunc, aclrtAllocatorAllocAdviseFunc *allocAdviseFunc, aclrtAllocatorGetAddrFromBlockFunc *getAddrFromBlockFunc)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| stream | 输入 | 注册的类型，按照不同的子模块区分。 |
| allocatorDesc | 输出 | Allocator描述符指针。 |
| allocator | 输出 | 用户提供的Allocator对象指针。 |
| allocFunc | 输出 | 申请内存block的回调函数。<br>回调函数定义如下：<br>typedef void *(*aclrtAllocatorAllocFunc)([aclrtAllocator](aclrtAllocator.md) allocator, size_t size); |
| freeFunc | 输出 | 释放内存block的回调函数。<br>回调函数定义如下：<br>typedef void (*aclrtAllocatorFreeFunc)([aclrtAllocator](aclrtAllocator.md) allocator, [aclrtAllocatorBlock](aclrtAllocatorBlock.md) block); |
| allocAdviseFunc | 输出 | 根据建议地址申请内存block的回调函数。<br>回调函数定义如下：<br>typedef void *(*aclrtAllocatorAllocAdviseFunc)([aclrtAllocator](aclrtAllocator.md) allocator, size_t size, [aclrtAllocatorAddr](aclrtAllocatorAddr.md) addr); |
| getAddrFromBlockFunc | 输出 | 根据申请来的block获取device内存地址的回调函数。<br>回调函数定义如下：<br>typedef void *(*aclrtAllocatorGetAddrFromBlockFunc)([aclrtAllocatorBlock](aclrtAllocatorBlock.md) block); |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

