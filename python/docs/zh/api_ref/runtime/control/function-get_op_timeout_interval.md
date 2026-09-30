# 函数：get\_op\_timeout\_interval

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

获取硬件支持的算子超时配置的最短时间间隔interval，单位为微秒。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtGetOpTimeoutInterval(uint64_t *interval)
    ```

- **python函数**

    ```python
    interval, ret = acl.rt.get_op_timeout_interval()
    ```

## 参数说明

无

## 返回值说明

| 参数名 | 说明 |
| --- | --- |
| interval | int，最短时间间隔，单位为微秒。<br>用户可配置且生效的超时时间是interval *N，N的取值为[1, 254]的整数，如果用户配置的超时时间不等于interval* N，则向上对齐到interval *N，假设interval = 100微秒，用户设置的超时时间为50微秒，则实际生效的超时时间为100*1 = 100微秒；用户设置的超时时间为30000微秒，则实际生效的超时时间为100 *254 =25400微秒。 |
| ret | int，返回0表示成功，返回其他值表示失败。 |
