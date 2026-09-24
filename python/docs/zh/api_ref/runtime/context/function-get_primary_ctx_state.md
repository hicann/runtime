# 函数：get\_primary\_ctx\_state

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

获取默认Context的状态。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtGetPrimaryCtxState(int32_t deviceId, uint32_t *flags, int32_t *active)
    ```

- **python函数**

    ```python
    active, flags, ret = acl.rt.get_primary_ctx_state(device_id)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| device_id | int，device id。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| active | int，存放默认Context状态的指针，0：未激活 1：激活。 |
| flags | int，预留值，当前固定返回0。 |
| ret | int，返回0表示成功，返回其他值表示失败。 |
