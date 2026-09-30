# 函数：notify\_set\_import\_pid

## 产品支持情况

<!-- npu="950" id1 -->
- Ascend 950PR&950DT系列产品：不支持
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

设置共享Notify的进程白名单，只有配置了白名单的进程才能使用[acl.rt.notify\_get\_export\_key](function-notify_get_export_key.md)接口导出的Notify共享名称。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtNotifySetImportPid(aclrtNotify notify, int32_t *pid, size_t num)
    ```

- **python函数**

    ```python
    ret = acl.rt.notify_set_import_pid(notify, pid)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| notify | int，指定Notify指针地址，与[acl.rt.notify_get_export_key](function-notify_get_export_key.md)接口中的Notify保持一致。 |
| pid | list，用于存放白名单进程ID的列表。<br>定义：pid=[pid_1, pid_2, ...]<br>进程ID可调用[acl.rt.device_get_bare_tgid](../device/function-device_get_bare_tgid.md)接口获取，Docker场景下获取到的是物理机上的进程ID，非Docker场景下获取到的是进程ID。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，返回0表示成功，返回其他值表示失败。 |

## 约束说明

昇腾虚拟化实例场景不支持该操作。
