# 函数：ipc\_mem\_import\_by\_key

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

在本进程中获取key的信息，并返回本进程可以使用的Device内存地址指针。本接口需与其它接口配合使用，以便实现内存共享的目的，配合使用流程请参见[函数：ipc\_mem\_get\_export\_key](function-ipc_mem_get_export_key.md)接口处的说明。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtIpcMemImportByKey(void **devPtr, const char *key, uint64_t flag)
    ```

- **python函数**

    ```python
    dev_ptr, ret = acl.rt.ipc_mem_import_by_key(key, flags)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| key | str，共享内存key。 |
| flags | 是否开启两个Device之间的数据交互。<br>取值为如下：<br>0x0：ACL_RT_IPC_MEM_IMPORT_FLAG_DEFAULT，默认值，关闭两个Device之间的数据交互。配置为该值时，需单独调用[acl.rt.device_enable_peer_access](../device/function-device_enable_peer_access.md)接口开启两个Device之间的数据交互。<br>0x1：ACL_RT_IPC_MEM_IMPORT_FLAG_ENABLE_PEER_ACCESS，开启两个Device之间的数据交互。配置为该值时，则无需调用[acl.rt.device_enable_peer_access](../device/function-device_enable_peer_access.md)接口。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| dev_ptr | int，Device内存地址指针。 |
| ret | int，错误码，返回0表示成功，返回[其它值](../datatypes/aclError.md)表示失败。 |
