# 函数：free

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

释放Device上的内存。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtFree(void *devPtr)
    ```

- **python函数**

    ```python
    ret = acl.rt.free(dev_ptr)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| dev_ptr | int，待释放内存的指针地址。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，错误码，返回0表示成功，返回[其它值](../datatypes/aclError.md)表示失败。 |

## 约束说明

- acl.rt.free接口只能释放通过[acl.rt.malloc](../memory/function-malloc.md)接口或[acl.rt.malloc\_cached](function-malloc_cached.md)接口。
- 本接口会立刻释放传入的内存，函数内部不会进行隐式的Device同步或流同步。用户需要确保调用完本接口后不再对该内存指针进行访问。
