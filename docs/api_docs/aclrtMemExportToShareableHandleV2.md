# aclrtMemExportToShareableHandleV2

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

将本进程通过[aclrtMallocPhysical](aclrtMallocPhysical.md)接口获取到的Device物理内存handle导出，以便后续将Device物理内存共享给其它进程。

本接口是在接口[aclrtMemExportToShareableHandle](aclrtMemExportToShareableHandle.md)基础上进行了增强，用户可通过shareType参数指定导出AI Server内的共享句柄，或导出跨AI Server的共享句柄。AI Server通常多个NPU设备组成的服务器形态的统称。

本接口的使用流程可参见[aclrtMemExportToShareableHandle](aclrtMemExportToShareableHandle.md)，但本接口需配合调用[aclrtMemSetPidToShareableHandleV2](aclrtMemSetPidToShareableHandleV2.md)接口设置进程白名单、调用[aclrtMemImportFromShareableHandleV2](aclrtMemImportFromShareableHandleV2.md)接口导入共享句柄。

## 函数原型

```
aclError aclrtMemExportToShareableHandleV2(aclrtDrvMemHandle handle, uint64_t flags, aclrtMemSharedHandleType shareType, void *shareableHandle)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| handle | 输入 | 存放物理内存信息的handle。<br>需先在本进程调用aclrtMallocPhysical接口申请物理内存，该接口调用成功，会返回一个handle。<br>handle与shareableHandle是一一对应的关系，在同一个进程中，不允许一对多、或多对一，否则报错，例如重复调用本接口导出时则会返回报错。 |
| flags | 输入 | 是否启用进程白名单校验。<br>取值为如下宏：<br><br>  - ACL_RT_VMM_EXPORT_FLAG_DEFAULT：默认值，启用进程白名单校验。配置为该值时，需单独调用[aclrtMemSetPidToShareableHandleV2](aclrtMemSetPidToShareableHandleV2.md)接口将使用shareableHandle的进程ID设置为白名单。<br>  - ACL_RT_IPC_MEM_EXPORT_FLAG_DISABLE_PID_VALIDATION：关闭进程白名单校验。配置为该值时，则无需调用[aclrtMemSetPidToShareableHandleV2](aclrtMemSetPidToShareableHandleV2.md)接口。<br><br><br>宏的定义如下：<br>#define ACL_RT_VMM_EXPORT_FLAG_DEFAULT  0x0UL<br>#define ACL_RT_VMM_EXPORT_FLAG_DISABLE_PID_VALIDATION 0x1UL |
| shareType | 输入 | 导出的共享句柄类型。 |
| shareableHandle | 输出 | 指向共享句柄的指针。其指向的内存由调用者提供，大小根据shareType决定：<br>若shareType为ACL_MEM_SHARE_HANDLE_TYPE_DEFAULT，则指向一个uint64_t变量。<br>若shareType为ACL_MEM_SHARE_HANDLE_TYPE_FABRIC，则指向一个aclrtMemFabricHandle结构体。<br>typedef struct aclrtMemFabricHandle { <br>   uint8_t data[128];<br>} aclrtMemFabricHandle; |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

## 约束说明

-   支持AI Server内跨进程共享物理内存的产品型号如下，若跨Device还需配合[aclrtDeviceEnablePeerAccess](aclrtDeviceEnablePeerAccess.md)接口使用。

    Atlas A3 训练系列产品/Atlas A3 推理系列产品

    Atlas A2 训练系列产品/Atlas A2 推理系列产品

-   仅Atlas A3 训练系列产品/Atlas A3 推理系列产品支持跨AI Server的跨进程共享物理内存。
-   不支持昇腾虚拟化实例场景。

