# 函数：get\_notify\_id

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

获取指定Notify的ID。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtGetNotifyId(aclrtNotify notify, uint32_t *notifyId)
    ```

- **python函数**

    ```python
    notify_id, ret = acl.rt.get_notify_id(notify)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| notify | int，指定要查询的Notify指针地址。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| notify_id | int，获取的Notify ID。 |
| ret | int，返回0表示成功，返回其他值表示失败。 |
