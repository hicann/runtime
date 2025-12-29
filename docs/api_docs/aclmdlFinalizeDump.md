# aclmdlFinalizeDump

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

Dump去初始化。

本接口需与其它接口配合使用实现以下功能：

-   **Dump数据落盘到文件**

    [aclmdlInitDump](aclmdlInitDump.md)接口、[aclmdlSetDump](aclmdlSetDump.md)接口、[aclmdlFinalizeDump](aclmdlFinalizeDump.md)接口配合使用，用于将Dump数据记录到文件中。一个进程内，可以根据需求多次调用这些接口，基于不同的Dump配置信息，获取Dump数据。场景举例如下：

    -   执行两个不同的模型，需要设置不同的Dump配置信息，接口调用顺序：[aclInit](aclInit.md)接口--\>[aclmdlInitDump](aclmdlInitDump.md)接口--\>[aclmdlSetDump](aclmdlSetDump.md)接口--\>模型1加载--\>模型1执行--\>[aclmdlFinalizeDump](aclmdlFinalizeDump.md)接口--\>模型1卸载--\>[aclmdlInitDump](aclmdlInitDump.md)接口--\>[aclmdlSetDump](aclmdlSetDump.md)接口--\>模型2加载--\>模型2执行--\>[aclmdlFinalizeDump](aclmdlFinalizeDump.md)接口--\>模型2卸载--\>执行其它任务--\>[aclFinalize](aclFinalize.md)接口
    -   同一个模型执行两次，第一次需要Dump，第二次无需Dump，接口调用顺序：[aclInit](aclInit.md)接口--\>[aclmdlInitDump](aclmdlInitDump.md)接口--\>[aclmdlSetDump](aclmdlSetDump.md)接口--\>模型加载--\>模型执行--\>[aclmdlFinalizeDump](aclmdlFinalizeDump.md)接口--\>模型卸载--\>模型加载--\>模型执行--\>执行其它任务--\>[aclFinalize](aclFinalize.md)接口

-   **Dump数据不落盘到文件，直接通过回调函数获取**

    [aclmdlInitDump](aclmdlInitDump.md)接口、[acldumpRegCallback](acldumpRegCallback.md)接口（通过该接口注册的回调函数需由用户自行实现，回调函数实现逻辑中包括获取Dump数据及数据长度）、[acldumpUnregCallback](acldumpUnregCallback.md)接口、[aclmdlFinalizeDump](aclmdlFinalizeDump.md)接口配合使用，用于通过回调函数获取Dump数据。场景举例如下：

    -   执行一个模型，通过回调获取Dump数据：

        [aclInit](aclInit.md)接口--\>[acldumpRegCallback](acldumpRegCallback.md)接口--\>[aclmdlInitDump](aclmdlInitDump.md)接口--\>模型加载--\>模型执行--\>[aclmdlFinalizeDump](aclmdlFinalizeDump.md)接口--\>[acldumpUnregCallback](acldumpUnregCallback.md)接口--\>模型卸载--\>[aclFinalize](aclFinalize.md)接口

    -   执行两个不同的模型，通过回调获取Dump数据，该场景下，只要不调用[acldumpUnregCallback](acldumpUnregCallback.md)接口取消注册回调函数，则可通过回调函数获取两个模型的Dump数据：

        [aclInit](aclInit.md)接口--\>[acldumpRegCallback](acldumpRegCallback.md)接口--\>[aclmdlInitDump](aclmdlInitDump.md)接口--\>模型1加载--\>模型1执行--\>--\>模型2加载--\>模型2执行--\>[aclmdlFinalizeDump](aclmdlFinalizeDump.md)接口--\>模型卸载--\>[acldumpUnregCallback](acldumpUnregCallback.md)接口--\>[aclFinalize](aclFinalize.md)接口

## 函数原型

```
aclError aclmdlFinalizeDump()
```

## 参数说明

无

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

## 参考资源

当前还提供了[aclInit](aclInit.md)接口，在初始化阶段，通过\*.json文件传入Dump配置信息，运行应用后获取Dump数据的方式。该种方式，一个进程内，只能调用一次[aclInit](aclInit.md)接口，如果要修改Dump配置信息，需修改\*.json文件中的配置。

