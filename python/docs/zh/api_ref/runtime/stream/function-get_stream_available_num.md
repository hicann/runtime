# 函数：get\_stream\_available\_num

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

获取当前Device上剩余可用的Stream数量。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtGetStreamAvailableNum(uint32_t *streamCount)
    ```

- **python函数**

    ```python
    stream_count, ret = acl.rt.get_stream_available_num()
    ```

## 参数说明

无

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| stream_count | int，剩余可用的Stream数量。 |
| ret | int，返回0表示成功，返回其他值表示失败。 |
