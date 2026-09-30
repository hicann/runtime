# 函数：ipc\_mem\_get\_export\_key

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
- Atlas 200I/500 A2推理产品：不支持
<!-- end id4 -->
<!-- npu="310p" id5 -->
- Atlas推理系列产品：支持
<!-- end id5 -->
<!-- npu="910" id6 -->
- Atlas训练系列产品：支持
<!-- end id6 -->

## 功能说明

在本进程中将指定Device内存设置为IPC（Inter-Process Communication）共享内存，并返回共享内存key，以便后续将内存共享给其它进程。**本接口需与以下其它关键接口配合使用**，以便实现内存共享，此处以A、B进程为例，说明两个进程间的内存共享接口调用流程:

1. 在A进程中：

    a. 若为不同Device上的两个进程共享内存场景，调用[acl.rt.device\_enable\_peer\_access](../device/function-device_enable_peer_access.md)接口使能P2P。

    b. 调用[acl.rt.malloc](../memory/function-malloc.md)接口申请P2P内存（通过该接口的policy参数配置）。

    c. 调用[acl.rt.ipc\_mem\_get\_export\_key](function-ipc_mem_get_export_key.md)接口导出共享内存key。

    d. 获取B进程的进程ID，并调用[acl.rt.ipc\_mem\_set\_import\_pid](function-ipc_mem_set_import_pid.md)接口，将B进程的进程ID设置为白名单。

    e. 调用[acl.rt.ipc\_mem\_close](function-ipc_mem_close.md)接口关闭IPC共享内存。B进程调用[acl.rt.ipc\_mem\_close](function-ipc_mem_close.md)接口关闭IPC共享内存后，A进程再关闭IPC共享内存，否则可能导致异常。

    f. 调用[acl.rt.free](../memory/function-free.md)接口释放内存。

2. 在B进程中：

    a. 若为不同Device上的两个进程共享内存场景，调用[acl.rt.device\_enable\_peer\_access](../device/function-device_enable_peer_access.md)接口使能P2P。

    b. 调用[acl.rt.device\_get\_bare\_tgid](../device/function-device_get_bare_tgid.md)接口，获取B进程的进程ID。

    本接口内部在获取进程ID时已适配物理机、虚拟机场景，用户只需调用本接口获取进程ID，再配合其它接口使用，达到内存共享的目的。若用户不调用本接口、自行获取进程ID，可能会导致后续使用进程ID异常。

    c. 调用aclrtIpcMemImportByKey获取key的信息，并返回本进程可以使用的Device内存地址指针。

    在调用[acl.rt.ipc\_mem\_import\_by\_key](function-ipc_mem_import_by_key.md)接口前，需确保待共享内存存在，不能提前释放。

    d. 调用[acl.rt.ipc\_mem\_close](function-ipc_mem_close.md)接口关闭IPC共享内存。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtIpcMemGetExportKey(void *devPtr, size_t size, char *key, size_t len, uint64_t flag)
    ```

- **python函数**

    ```python
    key, ret = acl.rt.ipc_mem_get_export_key(dev_ptr, size, len, flags)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| dev_ptr | int，Device内存地址。 |
| size | int，内存大小，单位Byte。 |
| len | int，key的长度，固定配置为65。 |
| flags | int，是否启用进程白名单校验。<br>取值如下：<br>0x0：ACL_RT_IPC_MEM_EXPORT_FLAG_DEFAULT，默认值，启用进程白名单校验。配置为该值时，需单独调用[acl.rt.ipc_mem_set_import_pid](function-ipc_mem_get_export_key.md)接口将使用共享内存key的进程ID设置为白名单。<br>0x1：ACL_RT_IPC_MEM_EXPORT_FLAG_DISABLE_PID_VALIDATION，关闭进程白名单校验。配置为该值时，则无需调用[acl.rt.ipc_mem_set_import_pid](function-ipc_mem_set_import_pid.md)接口。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| key | str，共享内存key。 |
| ret | int，返回0表示成功，返回[其它值](../datatypes/aclError.md)表示失败。 |

## 约束说明

不同Device上的两个进程通过IPC共享时，如下图，Device 0上的A进程通过IPC方式将内存共享给Device 1上的B进程，在B进程中使用此共享内存地址时：

- 需配合[acl.rt.device\_enable\_peer\_access](../device/function-device_enable_peer_access.md)接口使用，使能2个Device之间的通信。
- 在Atlas推理系列产品上，调用[aclrtMalloc](function-malloc.md)接口申请Device内存时，policy处需选择P2P类型，例如ACL\_MEM\_MALLOC\_HUGE\_FIRST\_P2P。
- 内存复制时，不支持根据源内存地址指针、目的内存地址指针自动判断复制方向；不支持Host-\>Device或Device-\>Host方向的内存复制操作，同步复制、异步复制都不支持；不支持同一个Device内的同步内存复制，但支持同一个Device内的异步内存复制；
- 支持Cube计算单元、Vector计算单元跨片访问。

![](../figures/IPC_shared_memory_diagram.png)

同一个Device上的两个进程通过IPC共享内存时，不存在以上约束。
