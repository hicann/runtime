# aclrtGetMemcpyDescSize

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

获取当前Device的内存复制描述符占用的内存大小。

本接口需与其它关键接口配合使用，以便实现内存复制，详细描述请参见[aclrtMemcpyAsyncWithDesc](aclrtMemcpyAsyncWithDesc.md)。

## 函数原型

```
aclError aclrtGetMemcpyDescSize(aclrtMemcpyKind kind, size_t *descSize)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| kind | 输入 | 内存复制的类型。<br>当前仅支持ACL_MEMCPY_INNER_DEVICE_TO_DEVICE，表示Device内的内存复制。 |
| descSize | 输出 | 内存大小，单位Byte。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

