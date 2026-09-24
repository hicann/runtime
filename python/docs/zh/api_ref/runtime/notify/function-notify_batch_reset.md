# 函数：notify\_batch\_reset

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
- Atlas推理系列产品：不支持
<!-- end id5 -->
<!-- npu="910" id6 -->
- Atlas训练系列产品：不支持
<!-- end id6 -->

## 功能说明

批量复位Notify。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtNotifyBatchReset(aclrtNotify *notifies, size_t num)
    ```

- **python函数**

    ```python
    ret = acl.rt.notify_batch_reset(notifies)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| notifies | list，存放Notify指针地址的列表。<br>定义：notifies=[notify_1, notify_2, ...]<br>列表中Notify指针地址元素通过[acl.rt.create_notify](function-create_notify.md)接口获取 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，返回0表示成功，返回其他值表示失败。 |

## 约束说明

昇腾虚拟化实例场景不支持该操作。
