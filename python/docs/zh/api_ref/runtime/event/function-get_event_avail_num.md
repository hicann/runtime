# 函数：get\_event\_avail\_num

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

查询当前Device上可用的Event数量。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtGetEventAvailNum(uint32_t *eventCount)
    ```

- **python函数**

    ```python
    event_count, ret = acl.rt.get_event_avail_num()
    ```

## 参数说明

无

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| event_count | int，Event数量。 |
| ret | int，返回0表示成功，返回其他值表示失败。 |
