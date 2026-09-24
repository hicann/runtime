# 函数：mem\_set\_pid\_to\_shareable\_handle

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

设置可共享内存的进程白名单。

在调用[acl.rt.mem\_export\_to\_shareable\_handle](function-mem_export_to_shareable_handle.md)接口的进程中，调用本接口设置进程白名单，本接口需与其它接口配合使用，以便实现内存共享的目的，请参见[acl.rt.mem\_export\_to\_shareable\_handle](function-mem_export_to_shareable_handle.md)接口处的说明。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtMemSetPidToShareableHandle(uint64_t shareableHandle, int32_t *pid, size_t pidNum)
    ```

- **python函数**

    ```python
    ret = acl.rt.mem_set_pid_to_shareable_handle(shareable_handle, pid)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| shareable_handle | int，通过[acl.rt.mem_export_to_shareable_handle](function-mem_export_to_shareable_handle.md)接口导出的shareable_handle。 |
| pid | list，用于存放白名单进程ID的数组。<br>进程ID可调用[acl.rt.device_get_bare_tgid](../device/function-device_get_bare_tgid.md)接口获取，Docker场景下获取到的是物理机上的进程ID，非Docker场景下获取到的是进程ID。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，错误码，返回0表示成功，返回[其它值](../datatypes/aclError.md)表示失败。 |
