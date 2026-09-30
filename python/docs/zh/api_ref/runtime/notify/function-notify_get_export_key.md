# 函数：notify\_get\_export\_key

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

将本进程中指定Notify设置为IPC（Inter- Process Communication） Notify，并返回key（即Notify共享名称），用于在多Device上不同进程间实现任务同步，调用本接口前，需调用[acl.rt.device\_enable\_peer\_access](../device/function-device_enable_peer_access.md)接口开启两个Device之间的数据交互。

**本接口需与以下其它关键接口配合使用**，以便实现多Device上不同进程间的任务同步，此处以Device 0上的A进程、Device 1上的B进程为例，说明两个进程间的任务同步接口调用流程:

1. 在A进程中：
    a. 调用[acl.rt.create\_notify](function-create_notify.md)接口创建Notify。
    b. 调用[acl.rt.notify\_get\_export\_key](function-notify_get_export_key.md)接口导出key（即Notify共享名称）。
    c. 获取B进程的进程ID，并调用[acl.rt.notify\_set\_import\_pid](function-notify_set_import_pid.md)接口，将B进程的进程ID设置为白名单。
    d. 调用[acl.rt.wait\_and\_reset\_notify](function-wait_and_reset_notify.md)接口下发等待任务。
    e. 调用[acl.rt.destroy\_notify](function-destroy_notify.md)接口销毁Notify。涉及IPC Notify的进程都需要释放Notify，所有涉及IPC Notify的进程都完成释放操作，Notify才真正释放。

2. 在B进程中：
    a. 调用[acl.rt.device\_get\_bare\_tgid](../device/function-device_get_bare_tgid.md)接口，获取B进程的进程ID。本接口内部在获取进程ID时已适配物理机、虚拟机场景，用户只需调用本接口获取进程ID，再配合其它接口使用，达到内存共享的目的。若用户不调用本接口、自行获取进程ID，可能会导致后续使用进程ID异常。
    b. 调用[acl.rt.notify\_import\_by\_key](function-notify_import_by_key.md)获取key的信息，并返回本进程可以使用的Notify指针。在调用[acl.rt.notify\_import\_by\_key](function-notify_import_by_key.md)接口前，需确保IPC Notify，不能提前释放。
    c. 调用[acl.rt.record\_notify](function-record_notify.md)接口下发Record任务。
    d. 调用[acl.rt.destroy\_notify](function-destroy_notify.md)接口销毁Notify。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtNotifyGetExportKey(aclrtNotify notify, char *key, size_t len, uint64_t flag)
    ```

- **python函数**

    ```python
    key, ret = acl.rt.notify_get_export_key(notify, len, flags)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| notify | int，指定Notify指针地址。 |
| len | int，Notify共享名称的长度，最小长度为65。 |
| flags | int，是否启用进程白名单校验。取值如下：<br>0：ACL_RT_NOTIFY_EXPORT_FLAG_DEFAULT，默认值，启用进程白名单校验。<br>配置为该值时，需单独调用aclrtNotifySetImportPid接口将使用Notify共享名称的进程ID设置为白名单。<br>2：ACL_RT_NOTIFY_EXPORT_FLAG_DISABLE_PID_VALIDATION，关闭进程白名单校验。<br>配置为该值时，则无需调用aclrtNotifySetImportPid接口。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| key | str，Notify共享名称。 |
| ret | int，返回0表示成功，返回其他值表示失败。 |

## 约束说明

昇腾虚拟化实例场景不支持该操作。
