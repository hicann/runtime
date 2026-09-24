# 函数：acl.rt.device\_get\_limit

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

获取当前进程的Device资源限制。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtDeviceGetLimit(aclrtDeviceLimit limit, size_t *value)
    ```

- **python函数**

    ```python
    value, ret = acl.rt.device_get_limit(limit)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| limit | int，资源类型，取值见[aclrtDeviceLimit](../datatypes/aclrtDeviceLimit.md) |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| value | int，资源限制的大小，单位Byte。 |
| ret | int，错误码，返回0表示成功，返回[其它值](../datatypes/aclError.md)表示失败。 |

## 约束说明

- 通过acl.rt.device\_set\_limit接口配置的Device资源限制作用于当前进程，所有Device共用同一套配置，任意Device上查询返回相同值。
- 通过本接口获取的是当前进程的瞬时值，不保证多线程并发安全。

    例如：首先调用acl.rt.device\_set\_limit将栈大小设置为A，随后调用acl.rt.set\_device使其生效。此时，调用acl.rt.device\_get\_limit接口查询得到的值为A，且资源限制的大小亦为A。随后再次调用acl.rt.device\_set\_limit将其修改为B，但未重新调用acl.rt.set\_device。此时，调用acl.rt.device\_get\_limit接口查询得到的值为B，而实际资源限制的大小仍为A。
