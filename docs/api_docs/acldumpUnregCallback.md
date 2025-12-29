# acldumpUnregCallback

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

Dump数据回调函数取消注册接口。acldumpUnregCallback需要和acldumpRegCallback配合使用，且必须在acldumpRegCallback调用后才有效。

[aclmdlInitDump](aclmdlInitDump.md)接口、[acldumpRegCallback](acldumpRegCallback.md)接口（通过该接口注册的回调函数需由用户自行实现，回调函数实现逻辑中包括获取Dump数据及数据长度）、[acldumpUnregCallback](acldumpUnregCallback.md)接口、[aclmdlFinalizeDump](aclmdlFinalizeDump.md)接口配合使用，用于通过回调函数获取Dump数据。场景举例如下：

-   执行一个模型，通过回调获取Dump数据：

    [aclInit](aclInit.md)接口--\>[acldumpRegCallback](acldumpRegCallback.md)接口--\>[aclmdlInitDump](aclmdlInitDump.md)接口--\>模型加载--\>模型执行--\>[aclmdlFinalizeDump](aclmdlFinalizeDump.md)接口--\>[acldumpUnregCallback](acldumpUnregCallback.md)接口--\>模型卸载--\>[aclFinalize](aclFinalize.md)接口

-   执行两个不同的模型，通过回调获取Dump数据，该场景下，只要不调用[acldumpUnregCallback](acldumpUnregCallback.md)接口取消注册回调函数，则可通过回调函数获取两个模型的Dump数据：

    [aclInit](aclInit.md)接口--\>[acldumpRegCallback](acldumpRegCallback.md)接口--\>[aclmdlInitDump](aclmdlInitDump.md)接口--\>模型1加载--\>模型1执行--\>--\>模型2加载--\>模型2执行--\>[aclmdlFinalizeDump](aclmdlFinalizeDump.md)接口--\>模型卸载--\>[acldumpUnregCallback](acldumpUnregCallback.md)接口--\>[aclFinalize](aclFinalize.md)接口

## 函数原型

```
void acldumpUnregCallback()
```

## 参数说明

无

## 返回值说明

无

