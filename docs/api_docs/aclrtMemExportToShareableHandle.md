# aclrtMemExportToShareableHandle

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

将本进程通过[aclrtMallocPhysical](aclrtMallocPhysical.md)接口获取到的Device物理内存handle导出，以便后续将Device物理内存共享给其它进程。

**本接口需与以下其它关键接口配合使用**，以便实现内存共享，此处以A、B进程为例，说明两个进程间的物理内存共享接口调用流程：

1.  在A进程中：
    1.  调用[aclrtMallocPhysical](aclrtMallocPhysical.md)接口，申请物理内存。

        先调用[aclrtMemGetAllocationGranularity](aclrtMemGetAllocationGranularity.md)接口获取内存申请粒度，然后再调用[aclrtMallocPhysical](aclrtMallocPhysical.md)接口申请物理内存时size按获取到的内存申请粒度对齐，以便节约内存。

        若需申请地址连续的虚拟内存、最大化利用物理内存，此处可配合[aclrtReserveMemAddress](aclrtReserveMemAddress.md)、[aclrtMapMem](aclrtMapMem.md)、[aclrtMemSetAccess](aclrtMemSetAccess.md)等接口申请虚拟内存、建立虚拟内存与物理内存之间的映射、设置虚拟内存的访问权限。

    2.  调用[aclrtMemExportToShareableHandle](aclrtMemExportToShareableHandle.md)接口，导出物理内存handle，输出shareableHandle。

        调用[aclrtMemExportToShareableHandle](aclrtMemExportToShareableHandle.md)接口时，可指定是否启用进程白名单校验，若启用，则需单独调用[aclrtMemSetPidToShareableHandle](aclrtMemSetPidToShareableHandle.md)接口将B进程的进程ID设置为白名单；反之，则无需调用[aclrtMemSetPidToShareableHandle](aclrtMemSetPidToShareableHandle.md)接口。

    3.  调用[aclrtFreePhysical](aclrtFreePhysical.md)接口，释放物理内存。

        内存使用完成后，要及时调用[aclrtFreePhysical](aclrtFreePhysical.md)接口释放物理内存，实现销毁shareableHandle。若有进程还在使用shareableHandle，则等待shareableHandle使用完成后再执行销毁任务。

        所有涉及共享内存的进程都必须释放其物理内存，只有当所有相关进程都完成释放操作后，物理内存才能真正被释放。释放物理内存后，原先分配的内存将被归还给操作系统，此后使用该handle将导致未定义的行为。

2.  在B进程中：
    1.  调用[aclrtDeviceGetBareTgid](aclrtDeviceGetBareTgid.md)接口，获取B进程的进程ID。

        本接口内部在获取进程ID时已适配物理机、虚拟机场景，用户只需调用本接口获取进程ID，再配合其它接口使用，达到物理内存共享的目的。若用户不调用本接口、自行获取进程ID，可能会导致后续使用进程ID异常。

    2.  调用[aclrtMemImportFromShareableHandle](aclrtMemImportFromShareableHandle.md)，获取shareableHandle里的信息，并返回本进程中的handle。

        在调用[aclrtMemImportFromShareableHandle](aclrtMemImportFromShareableHandle.md)接口前，需确保待共享的物理内存存在，不能提前释放。

        若需申请地址连续的虚拟内存、最大化利用物理内存地址，此处可配合[aclrtReserveMemAddress](aclrtReserveMemAddress.md)、[aclrtMapMem](aclrtMapMem.md)、[aclrtMemSetAccess](aclrtMemSetAccess.md)等接口申请虚拟内存、建立虚拟内存与物理内存之间的映射、设置虚拟内存的访问权限，请参见对应接口的说明。

    3.  调用[aclrtFreePhysical](aclrtFreePhysical.md)接口，释放物理内存。

## 函数原型

```
aclError aclrtMemExportToShareableHandle(aclrtDrvMemHandle handle, aclrtMemHandleType handleType, uint64_t flags, uint64_t *shareableHandle)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| handle | 输入 | 存放物理内存信息的handle。<br>需先在本进程调用aclrtMallocPhysical接口申请物理内存，该接口调用成功，会返回一个handle。<br>handle与shareableHandle是一一对应的关系，在同一个进程中，不允许一对多、或多对一，否则报错，例如重复调用本接口导出时则会返回报错。 |
| handleType | 输入 | 预留参数，当前固定填ACL_MEM_HANDLE_TYPE_NONE。 |
| flags | 输入 | 是否启用进程白名单校验。<br>取值为如下宏：<br><br>  - ACL_RT_VMM_EXPORT_FLAG_DEFAULT：默认值，启用进程白名单校验。配置为该值时，需单独调用[aclrtMemSetPidToShareableHandle](aclrtMemSetPidToShareableHandle.md)接口将使用shareableHandle的进程ID设置为白名单。<br>  - ACL_RT_IPC_MEM_EXPORT_FLAG_DISABLE_PID_VALIDATION：关闭进程白名单校验。配置为该值时，则无需调用[aclrtMemSetPidToShareableHandle](aclrtMemSetPidToShareableHandle.md)接口。<br><br><br>宏的定义如下：<br>#define ACL_RT_VMM_EXPORT_FLAG_DEFAULT  0x0UL<br>#define ACL_RT_VMM_EXPORT_FLAG_DISABLE_PID_VALIDATION 0x1UL |
| shareableHandle | 输出 | 标识共享给其它进程的shareableHandle。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

## 约束说明

-   支持AI Server内跨进程共享物理内存的产品型号如下，若跨Device还需配合[aclrtDeviceEnablePeerAccess](aclrtDeviceEnablePeerAccess.md)接口使用。AI Server通常多个NPU设备组成的服务器形态的统称。

    Atlas A3 训练系列产品/Atlas A3 推理系列产品

    Atlas A2 训练系列产品/Atlas A2 推理系列产品

-   不支持昇腾虚拟化实例场景。

