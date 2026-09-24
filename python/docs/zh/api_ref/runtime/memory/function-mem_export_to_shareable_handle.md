# 函数：mem\_export\_to\_shareable\_handle

## 产品支持情况

<!-- npu="950" id1 -->
- Ascend 950PR&950DT系列产品：支持
<!-- end id1 -->
<!-- npu="A3" id2 -->
- Atlas A3系列产品：支持
<!-- end id2 -->
<!-- npu="910b" id3 -->
- Atlas A2系列产品：支持
<!-- end id3 -->
<!-- npu="310b" id4 -->
- Atlas 200I/500 A2推理产品：支持
<!-- end id4 -->
<!-- npu="310p" id5 -->
- Atlas推理系列产品：支持
<!-- end id5 -->
<!-- npu="910" id6 -->
- Atlas训练系列产品：支持
<!-- end id6 -->

## 功能说明

将本进程通过[acl.rt.malloc\_physical](function-malloc_physical.md)接口获取到的Device物理内存handle导出，以便后续将Device物理内存共享给其它进程。

**本接口需与以下其它接口配合使用**，以便实现内存共享的目的（此处以A、B进程为例，说明两个进程间的物理内存共享接口调用流程）：

1. 在A进程中：
    a. 调用[acl.rt.malloc\_physical](function-malloc_physical.md)接口，申请物理内存。

    先调用[acl.rt.mem\_get\_allocation\_granularity](function-mem_get_allocation_granularity.md)接口获取内存申请粒度，然后在调用[acl.rt.malloc\_physical](function-malloc_physical.md)接口申请物理内存时size按获取到的内存申请粒度对齐，以便节约内存。

    若需申请地址连续的虚拟内存、最大化利用物理内存地址的目的，此处可配合[acl.rt.reserve\_mem\_address](function-reserve_mem_address.md)、[acl.rt.map\_mem](function-map_mem.md)等接口申请虚拟内存、建立虚拟内存与物理内存之间的映射，请参见对应接口的说明。

    b. 调用[acl.rt.mem\_export\_to\_shareable\_handle](function-mem_export_to_shareable_handle.md)接口，导出物理内存handle，输出shareable\_handle。

    调用[acl.rt.mem\_export\_to\_shareable\_handle](function-mem_export_to_shareable_handle.md)接口时，可指定是否启用进程白名单校验，若启用，则需单独调用[acl.rt.mem\_set\_pid\_to\_shareable\_handle](function-mem_set_pid_to_shareable_handle.md)接口将B进程的进程ID设置为白名单；反之，则无需调用[acl.rt.mem\_set\_pid\_to\_shareable\_handle](function-mem_set_pid_to_shareable_handle.md)接口。

    c. 调用[acl.rt.free\_physical](function-free_physical.md)接口，释放物理内存。

    内存使用完成后，要及时调用[acl.rt.free\_physical](function-free_physical.md)接口释放物理内存，实现销毁shareableHandle。若有进程还在使用shareableHandle，则等待shareableHandle使用完成后再执行销毁任务。

        所有涉及共享内存的进程都必须释放其物理内存，只有当所有相关进程都完成释放操作后，物理内存才能真正被释放。释放物理内存后，原先分配的内存将被归还给操作系统，此后使用该handle将导致未定义的行为。

2. 在B进程中：
    a. 调用[acl.rt.device\_get\_bare\_tgid](../device/function-device_get_bare_tgid.md)接口，获取B进程的进程ID。

    本接口内部在获取进程ID时已适配物理机、虚拟机场景，用户只需调用本接口获取进程ID，再配置其它接口使用，达到物理内存共享的目的。若用户不调用本接口、自行获取进程ID，可能会导致后续使用进程ID异常。

    b. 调用[acl.rt.mem\_import\_from\_shareable\_handle](function-mem_import_from_shareable_handle.md)，获取shareable\_handle里的信息，并返回本进程中的handle。（在调用[acl.rt.mem\_import\_from\_shareable\_handle](function-mem_import_from_shareable_handle.md)接口前，需确保待共享的物理内存存在，不能提前释放。）

    若需申请地址连续的虚拟内存、最大化利用物理内存地址的目的，此处可配合[acl.rt.reserve\_mem\_address](function-reserve_mem_address.md)、[acl.rt.map\_mem](function-map_mem.md)等接口申请虚拟内存、建立虚拟内存与物理内存之间的映射，请参见对应接口的说明。

    c. 调用[acl.rt.free\_physical](function-free_physical.md)接口，释放物理内存。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtMemExportToShareableHandle(aclrtDrvMemHandle handle, aclrtMemHandleType handleType, uint64_t flags, uint64_t *shareableHandle)
    ```

- **python函数**

    ```python
    shareable_handle, ret = acl.rt.mem_export_to_shareable_handle(handle, handle_type, flags)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| handle | int，存放物理内存信息的handle。<br>需先在本进程调用[acl.rt.malloc_physical](function-malloc_physical.md)接口申请物理内存，该接口调用成功，会返回一个handle。<br>handle与shareableHandle是一一对应的关系，在同一个进程中，不允许一对多、或多对一，否则报错，例如重复调用本接口导出时则会返回报错。 |
| handle_type | int，预留参数，当前固定输入ACL_MEM_HANDLE_TYPE_NONE = 0。 |
| flags | int，是否启用进程白名单校验。<br>取值为如下：<br>0x0：ACL_RT_VMM_EXPORT_FLAG_DEFAULT，默认值，启用进程白名单校验。<br>配置为该值时，需单独调用[acl.rt.mem_set_pid_to_shareable_handle](function-mem_set_pid_to_shareable_handle.md)接口将使用shareable_handle的进程ID设置为白名单。<br>0x1：ACL_RT_IPC_MEM_EXPORT_FLAG_DISABLE_PID_VALIDATION，关闭进程白名单校验。<br>配置为该值时，则无需调用[acl.rt.mem_set_pid_to_shareable_handle](function-mem_set_pid_to_shareable_handle.md)接口。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| shareable_handle | int，标识共享给其它进程的shareable_handle。 |
| ret | int，错误码，返回0表示成功，返回[其它值](../datatypes/aclError.md)表示失败。 |

## 约束说明

<!-- npu="310b" id7 -->
- Atlas 200I/500 A2推理产品上，Ascend RC形态不支持调用本接口。
<!-- end id7 -->

- 支持AI Server内跨进程共享物理内存的产品型号如下，若跨Device还需配合[acl.rt.device\_enable\_peer\_access](../device/function-device_enable_peer_access.md)接口使用。AI Server通常多个NPU设备组成的服务器形态的统称。
- 不支持昇腾虚拟化实例场景。
