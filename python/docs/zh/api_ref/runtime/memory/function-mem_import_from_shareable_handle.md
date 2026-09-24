# 函数：mem\_import\_from\_shareable\_handle

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

在本进程中获取shareable\_handle里的信息，并返回本进程中的handle，用于在本进程中建立虚拟地址与物理地址之间的映射关系。本接口还支持生成指定Device上的handle。

本接口需与其它接口配合使用，以便实现内存共享的目的，配合使用流程请参见[acl.rt.mem\_export\_to\_shareable\_handle](function-mem_export_to_shareable_handle.md)接口处的说明。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtMemImportFromShareableHandle(uint64_t shareableHandle, int32_t deviceId, aclrtDrvMemHandle *handle)
    ```

- **python函数**

    ```python
    handle, ret = acl.rt.mem_import_from_shareable_handle(shareable_handle, device_id)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| shareable_handle | int，待共享的shareable_handle。<br>与[acl.rt.mem_export_to_shareable_handle](function-mem_export_to_shareable_handle.md)接口中导出的shareable_handle保持一致。 |
| deviceId | int，用于生成指定Device ID上的handle。<br>用户调用[acl.rt.get_device_count](../device/function-get_device_count.md)接口获取可用的Device数量后，这个Device ID的取值范围：[0, (*可用的Device数量* - 1)] |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| handle | int，本进程的物理内存handle。 |
| ret | int，错误码，返回0表示成功，返回[其它值](../datatypes/aclError.md)表示失败。 |

## 约束说明

<!-- npu="310b" id7 -->
- Atlas 200I/500 A2推理产品上，Ascend RC形态不支持调用本接口。
<!-- end id7 -->

- 在调用本接口前，需确保待共享的物理内存存在，不能提前释放。
- handle与shareableHandle是一一对应的关系，在同一个进程中，不允许一对多、或多对一。
- 支持在一个Device上调用[acl.rt.mem\_export\_to\_shareable\_handle](function-mem_export_to_shareable_handle.md)接口导出handle，然后调用本接口生成另一个Device上的handle。
- 内存使用完成后，要及时调用[acl.rt.free\_physical](function-free_physical.md)销毁handle，并且需所有调用本接口的进程都销毁shareable\_handle的情况下，handle才会真正销毁。
<!-- npu="A3,910b,910,310p" id8 -->
- 支持跨Device共享物理内存。

    跨Device共享物理内存仅支持如下型号，且需配合[acl.rt.device\_enable\_peer\_access](../device/function-device_enable_peer_access.md)接口使用：

    <!-- npu="A3" id9 -->
    Atlas A3系列产品
    <!-- end id9 -->

    <!-- npu="910b" id10 -->
    Atlas A2系列产品
    <!-- end id10 -->

    <!-- npu="910" id11 -->
    Atlas训练系列产品
    <!-- end id11 -->

    <!-- npu="310p" id12 -->
    Atlas推理系列产品
    <!-- end id12 -->
<!-- end id8 -->
