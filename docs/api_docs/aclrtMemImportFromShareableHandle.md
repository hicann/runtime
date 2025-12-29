# aclrtMemImportFromShareableHandle

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

在本进程中获取shareableHandle里的信息，并返回本进程中的handle，用于在本进程中建立虚拟地址与物理地址之间的映射关系。本接口还支持生成指定Device上的handle。

本接口需与其它接口配合使用，以便实现内存共享的目的，配合使用流程请参见[aclrtMemExportToShareableHandle](aclrtMemExportToShareableHandle.md)接口处的说明。

## 函数原型

```
aclError aclrtMemImportFromShareableHandle(uint64_t shareableHandle, int32_t deviceId, aclrtDrvMemHandle *handle)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| shareableHandle | 输入 | 待共享的shareableHandle，与[aclrtMemExportToShareableHandle](aclrtMemExportToShareableHandle.md)接口中导出的shareableHandle保持一致。<br>handle与shareableHandle是一一对应的关系，在同一个进程中，不允许一对多、或多对一。 |
| deviceId | 输入 | 用于生成指定Device ID上的handle。<br>用户调用[aclrtGetDeviceCount](aclrtGetDeviceCount.md)接口获取可用的Device数量后，这个Device ID的取值范围：[0, (可用的Device数量-1)] |
| handle | 输出 | 本进程的物理内存handle。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

## 约束说明

-   在调用本接口前，需确保待共享的物理内存存在，不能提前释放。
-   不支持同一个进程中调用aclrtMemImportFromShareableHandle、[aclrtMemExportToShareableHandle](aclrtMemExportToShareableHandle.md)这两个接口，只支持跨进程调用。
-   支持在一个Device上调用[aclrtMemExportToShareableHandle](aclrtMemExportToShareableHandle.md)接口导出handle，然后调用本接口生成另一个Device上的handle。
-   内存使用完成后，要及时调用[aclrtFreePhysical](aclrtFreePhysical.md)销毁handle，并且需所有调用本接口的进程都销毁shareableHandle的情况下，handle才会真正销毁。

