# aclrtMemcpyAsyncWithDesc

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

使用内存复制描述符（二级指针方式）进行内存复制。异步接口。

本接口需与以下其它关键接口配合使用，以便实现内存复制：

1.  调用[aclrtGetMemcpyDescSize](aclrtGetMemcpyDescSize.md)接口获取内存描述符所需的内存大小。
2.  申请Device内存，用于存放内存描述符。
3.  申请源内存、目的内存，分别用于存放复制前后的数据。
4.  调用[aclrtSetMemcpyDesc](aclrtSetMemcpyDesc.md)接口将源内存地址、目的内存地址等信息设置到内存描述符中。
5.  调用aclrtMemcpyAsyncWithDesc接口实现内存复制。

## 函数原型

```
aclError aclrtMemcpyAsyncWithDesc(void *desc, aclrtMemcpyKind kind, aclrtStream stream)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| desc | 输入 | 内存复制描述符地址指针，Device侧内存地址。<br>此处需先调用[aclrtSetMemcpyDesc](aclrtSetMemcpyDesc.md)接口设置内存复制描述符，再将内存复制描述符地址指针作为入参传入本接口。 |
| kind | 输入 | 内存复制的类型。<br>当前仅支持ACL_MEMCPY_INNER_DEVICE_TO_DEVICE，表示Device内的内存复制。 |
| stream | 输入 | 指定执行内存复制任务的Stream。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

