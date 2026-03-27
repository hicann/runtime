# aclrtMemcpyAsyncWithCondition

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Ascend 950PR/Ascend950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

实现内存复制。

本接口中的Host内存支持锁页内存（例如通过aclrtMallocHost接口申请的内存）、非锁页内存（通过malloc接口申请的内存）。当Host内存是非锁页内存时，本接口在内存复制任务完成后才返回；当Host内存是锁页内存时，本接口是异步接口，调用接口成功仅表示任务下发成功，不表示任务执行成功，调用本接口后，需调用同步等待接口（例如，[aclrtSynchronizeStream](aclrtSynchronizeStream.md)）确保内存复制的任务已执行完成。

## 函数原型

```
aclError aclrtMemcpyAsyncWithCondition(void *dst, size_t destMax, const void *src, size_t count, aclrtMemcpyKind kind, aclrtStream stream)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| dst | 输入 | 目的内存地址指针。 |
| destMax | 输入 | 目的内存地址的最大内存长度，单位Byte。 |
| src | 输入 | 源内存地址指针。 |
| count | 输入 | 内存复制的长度，单位Byte。 |
| kind | 输入 | 内存复制的类型。类型定义请参见[aclrtMemcpyKind](aclrtMemcpyKind.md)。 |
| stream | 输入 | 指定执行内存复制任务的Stream。类型定义请参见[aclrtStream](aclrtStream.md)。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

## 约束说明

-   Ascend EP形态下，本接口不支持异步Host内的内存复制功能，若传入的kind为ACL\_MEMCPY\_HOST\_TO\_HOST时，接口返回报错ACL\_ERROR\_RT\_FEATURE\_NOT\_SUPPORT 。

