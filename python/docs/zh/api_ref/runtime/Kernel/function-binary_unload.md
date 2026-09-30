# 函数：binary\_unload

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

删除binHandle指向的算子二进制数据，同时也删除通过[acl.rt.binary\_load](function-binary_load.md)接口拷贝到Device上的算子二进制数据。仅支持Ascend C自定义算子。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtBinaryUnLoad(aclrtBinHandle binHandle)
    ```

- **python函数**

    ```python
    ret = acl.rt.binary_unload(bin_handle)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| bin_handle | int，指向算子二进制的handle。该handle在调用[acl.rt.binary_load](function-binary_load.md)接口时生成。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，错误码，返回0表示成功，返回[其它值](../datatypes/aclError.md)表示失败。 |

## 约束说明

调用本接口删除算子二进制数据时，需跟[acl.rt.binary\_load](function-binary_load.md)接口在同一个Context下，这样才能一并删除通过[acl.rt.binary\_load](function-binary_load.md)接口拷贝到Device上的算子二进制数据，否则可能会导致Device上的算子二进制数据删除异常。
