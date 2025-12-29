# aclrtMemSetPidToShareableHandleV2

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

设置共享内存的进程白名单**。**

本接口是在接口[aclrtMemSetPidToShareableHandle](aclrtMemSetPidToShareableHandle.md)基础上进行了增强，用户可通过shareType参数指定导出AI Server内的共享句柄，或导出跨AI Server的共享句柄。

本接口的使用流程可参见[aclrtMemExportToShareableHandle](aclrtMemExportToShareableHandle.md)，但本接口需配合调用[aclrtMemExportToShareableHandleV2](aclrtMemExportToShareableHandleV2.md)接口导出共享句柄、调用[aclrtMemImportFromShareableHandleV2](aclrtMemImportFromShareableHandleV2.md)接口导入共享句柄。

## 函数原型

```
aclError aclrtMemSetPidToShareableHandleV2(void *shareableHandle, aclrtMemSharedHandleType shareType, int32_t *pid, size_t pidNum)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| shareableHandle | 输入 | 通过aclrtMemExportToShareableHandleV2接口导出的shareableHandle，表示指向共享句柄的指针。 |
| shareType | 输入 | 导出的共享句柄类型。 |
| pid | 输入 | 用于存放白名单进程ID的数组。<br>进程ID可调用[aclrtDeviceGetBareTgid](aclrtDeviceGetBareTgid.md)接口获取，Docker场景下获取到的是物理机上的进程ID，非Docker场景下获取到的是进程ID。 |
| pidNum | 输入 | 白名单进程数量，与pid参数数组的大小保持一致。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

