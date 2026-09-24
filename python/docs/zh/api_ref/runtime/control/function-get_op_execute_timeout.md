# 函数：get\_op\_execute\_timeout

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

获取AI Core算子执行的超时时间。

如果AI Core算子永不超时，则time\_out\_ms参数输出的值为uint32\_t的最大值。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtGetOpExecuteTimeout(uint32_t *const timeoutMs)
    ```

- **python函数**

    ```python
    time_out_ms, ret = acl.rt.get_op_execute_timeout()
    ```

## 参数说明

无

## 返回值说明

| 参数名 | 说明 |
| --- | --- |
| time_out_ms | int，超时时间，单位为毫秒。<br>若已调用set接口（例如acl.rt.set_op_execute_time_out）设置过超时时间，则返回硬件的实际超时时间，否则，返回AI Core的默认超时时间。 |
| ret | int，返回0表示成功，返回其他值表示失败。 |
