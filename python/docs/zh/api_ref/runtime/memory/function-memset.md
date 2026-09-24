# 函数：memset

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

初始化内存，将内存中的内容设置为指定的值。

待初始化的内存支持在Host侧或Device侧，系统根据地址判定是Host还是Device。如果Host内存不是用acl接口（例如acl.rt.malloc\_host）申请的，将会导致未定义的行为。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtMemset(void *devPtr, size_t maxCount, int32_t value, size_t count)
    ```

- **python函数**

    ```python
    ret = acl.rt.memset(dev_ptr, max_count, value, count)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| dev_ptr | int，内存的起始地址。 |
| max_count | int，内存的最大长度，单位Byte。 |
| value | int，设置的值。 |
| count | int，需要设置为指定值的内存长度，单位Byte。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，错误码，返回0表示成功，返回[其它值](../datatypes/aclError.md)表示失败。 |

## 约束说明

本接口会立刻进行内存初始化，函数内部不会进行隐式的Device同步或流同步。
