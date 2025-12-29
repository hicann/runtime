# aclrtMemImportFromShareableHandleV2

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

在本进程中获取shareableHandle里的信息，并返回本进程中的handle，用于在本进程中建立虚拟地址与物理地址之间的映射关系。

本接口是在接口[aclrtMemImportFromShareableHandle](aclrtMemImportFromShareableHandle.md)基础上进行了增强，用户可通过shareType参数指定导出AI Server内的共享句柄，或导出跨AI Server的共享句柄。

本接口的使用流程可参见[aclrtMemExportToShareableHandle](aclrtMemExportToShareableHandle.md)，但本接口需配合调用[aclrtMemExportToShareableHandleV2](aclrtMemExportToShareableHandleV2.md)接口导出共享句柄、调用[aclrtMemSetPidToShareableHandleV2](aclrtMemSetPidToShareableHandleV2.md)接口设置进程白名单。

## 函数原型

```
aclError aclrtMemImportFromShareableHandleV2(void *shareableHandle, aclrtMemSharedHandleType shareType, uint64_t flags, aclrtDrvMemHandle *handle);
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| shareableHandle | 输入 | 待共享的shareableHandle，与[aclrtMemExportToShareableHandleV2](aclrtMemExportToShareableHandleV2.md)接口中导出的shareableHandle保持一致。<br>handle与shareableHandle是一一对应的关系，在同一个进程中，不允许一对多、或多对一。 |
| shareType | 输入 | 导出的共享句柄类型。 |
| flags | 输入 | 预留参数，当前固定设置为0。 |
| handle | 输出 | 本进程的物理内存handle。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

## 约束说明

-   在调用本接口前，需确保待共享的物理内存存在，不能提前释放。
-   不支持同一个进程中调用aclrtMemImportFromShareableHandleV2、[aclrtMemExportToShareableHandle](aclrtMemExportToShareableHandle.md)V2这两个接口，只支持跨进程调用。
-   内存使用完成后，要及时调用[aclrtFreePhysical](aclrtFreePhysical.md)销毁handle，并且需所有调用本接口的进程都销毁shareableHandle的情况下，handle才会真正销毁。

