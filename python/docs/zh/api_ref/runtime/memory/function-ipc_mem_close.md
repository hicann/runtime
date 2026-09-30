# 函数：ipc\_mem\_close

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

关闭IPC 共享内存，调用[acl.rt.ipc\_mem\_import\_by\_key](function-ipc_mem_import_by_key.md)接口的进程中、调用[acl.rt.ipc\_mem\_get\_export\_key](function-ipc_mem_get_export_key.md)接口的进程中都需要调用此接口。对于同一个共享内存key，需所有调用[acl.rt.ipc\_mem\_import\_by\_key](function-ipc_mem_import_by_key.md)接口的进程中都调用[acl.rt.ipc\_mem\_close](function-ipc_mem_close.md)接口后，调用[acl.rt.ipc\_mem\_get\_export\_key](function-ipc_mem_get_export_key.md)接口的进程中才可以调用[acl.rt.ipc\_mem\_close](function-ipc_mem_close.md)接口，否则可能导致异常。 本接口需与其它接口配合使用，以便实现内存共享的目的，配合使用流程请参[acl.rt.ipc\_mem\_get\_export\_key](function-ipc_mem_get_export_key.md)接口处的说明。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtIpcMemClose(const char *key)
    ```

- **python函数**

    ```python
    ret = acl.rt.ipc_mem_close(key)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| key | str，共享内存key，通过[acl.rt.ipc_mem_get_export_key](function-ipc_mem_get_export_key.md)接口获取的内存key。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，返回0表示成功，返回[其它值](../datatypes/aclError.md)表示失败。 |
