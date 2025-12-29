# aclrtSetMemcpyDesc

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

设置内存复制描述符，此接口调用完成后，会将源地址，目的地址、内存复制长度记录到内存复制描述符中。

本接口需与其它关键接口配合使用，以便实现内存复制，详细描述请参见[aclrtMemcpyAsyncWithDesc](aclrtMemcpyAsyncWithDesc.md)。

## 函数原型

```
aclError aclrtSetMemcpyDesc(void *desc, aclrtMemcpyKind kind, void *srcAddr, void *dstAddr, size_t count, void *config)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| desc | 输出 | 内存复制描述符地址指针。<br>需先调用[aclrtGetMemcpyDescSize](aclrtGetMemcpyDescSize.md)接口获取内存描述符所需的内存大小，再申请Device内存后（例如aclrtMalloc接口），将Device内存地址作为入参传入此处。 |
| kind | 输入 | 内存复制的类型。<br>当前仅支持ACL_MEMCPY_INNER_DEVICE_TO_DEVICE，表示Device内的内存复制。 |
| srcAddr | 输入 | 源内存地址指针。<br>由用户申请内存并管理内存。 |
| dstAddr | 输入 | 目的内存地址指针。<br>由用户申请内存并管理内存。 |
| count | 输入 | 内存复制的长度，单位Byte。 |
| config | 输入 | 预留参数，当前固定传NULL。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

