# 函数：notify\_import\_by\_key

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

在本进程中获取key的信息，并返回本进程可以使用的Notify指针地址。

本接口需与其它接口配合使用，以便实现多Device上不同进程间的任务同步，请参见[acl.rt.notify\_get\_export\_key](function-notify_get_export_key.md)接口处的说明。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtNotifyImportByKey(aclrtNotify *notify, const char *key, uint64_t flag)
    ```

- **python函数**

    ```python
    notify, ret = acl.rt.notify_import_by_key(key, flags)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| key | str，Notify共享名称。<br>必须先调用[acl.rt.notify_get_export_key](function-notify_get_export_key.md)接口获取指定Notify的共享名称，再作为参数传入。 |
| flags | int，是否开启两个Device之间的数据交互。<br>取值为如下：<br>0x0：ACL_RT_NOTIFY_IMPORT_FLAG_DEFAULT，默认值，关闭两个Device之间的数据交互。<br>配置为该值时，需单独调用[acl.rt.device_enable_peer_access](../device/function-device_enable_peer_access.md)接口开启两个Device之间的数据交互。<br>0x02：ACL_RT_NOTIFY_IMPORT_FLAG_ENABLE_PEER_ACCESS，开启两个Device之间的数据交互。<br>配置为该值时，则无需调用[acl.rt.device_enable_peer_access](../device/function-device_enable_peer_access.md)接口。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| notify | int，Notify指针。 |
| ret | int，返回0表示成功，返回其他值表示失败。 |

## 约束说明

昇腾虚拟化实例场景不支持该操作。
