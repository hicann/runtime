# 函数：allocator\_unregister

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
- Atlas推理系列产品：支持
<!-- end id5 -->
<!-- npu="910" id6 -->
- Atlas训练系列产品：支持
<!-- end id6 -->

## 功能说明

取消注册用户提供的Allocator以及Allocator对应的回调函数，用于取消使用用户提供的Allocator。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtAllocatorUnregister(aclrtStream stream)
    ```

- **python函数**

    ```python
    ret = acl.rt.allocator_unregister(stream)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| stream | int，该Allocator对应的stream。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，错误码，返回0表示成功，返回[其它值](../datatypes/aclError.md)表示失败。 |

## 约束说明

- 用户销毁Allocator前，调用本接口取消注册。
- 待取消注册的Stream不存在，或多次调用本接口取消注册，本接口内部不做任何操作，返回成功。
