# aclrtMemcpyAsyncWithOffset

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

实现内存复制，适用于基地址是二级指针、有地址偏移的场景。异步接口。

## 函数原型

```
aclError aclrtMemcpyAsyncWithOffset(void **dst, size_t destMax, size_t dstDataOffset, const void **src, size_t count, size_t srcDataOffset, aclrtMemcpyKind kind, aclrtStream stream)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| dst | 输入 | 目的内存地址指针。 |
| destMax | 输入 | 目的内存地址的最大内存长度，单位Byte。 |
| dstDataOffset | 输入 | 目的内存地址偏移。 |
| src | 输入 | 源内存地址指针。 |
| count | 输入 | 内存复制的长度，单位Byte。 |
| srcDataOffset | 输入 | 源内存地址偏移。 |
| kind | 输入 | 内存复制的类型。<br>当前kind只支持ACL_MEMCPY_INNER_DEVICE_TO_DEVICE（Device内的内存复制）。 |
| stream | 输入 | 指定执行内存复制任务的Stream。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

