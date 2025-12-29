# aclrtIpcMemClose

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

关闭IPC共享内存，调用[aclrtIpcMemImportByKey](aclrtIpcMemImportByKey.md)接口的进程中、调用[aclrtIpcMemGetExportKey](aclrtIpcMemGetExportKey.md)接口的进程中都需要调用此接口。

对于同一个共享内存key，需所有调用[aclrtIpcMemImportByKey](aclrtIpcMemImportByKey.md)接口的进程中都调用aclrtIpcMemClose接口后，调用[aclrtIpcMemGetExportKey](aclrtIpcMemGetExportKey.md)接口的进程中才可以调用aclrtIpcMemClose接口，否则可能导致异常。

本接口需与其它接口配合使用，以便实现内存共享的目的，配合使用流程请参见[aclrtIpcMemGetExportKey](aclrtIpcMemGetExportKey.md)接口处的说明。

## 函数原型

```
aclError aclrtIpcMemClose(const char *key)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| key | 输入 | 通过aclrtIpcMemGetExportKey接口获取的共享内存key。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

