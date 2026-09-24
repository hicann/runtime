# 函数：create\_binary

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

创建acl.rt.binary类型的数据，该数据类型用于描述算子二进制信息。仅支持Ascend C自定义算子。

如需销毁acl.rt.binary类型的数据，请参见[acl.rt.destroy\_binary](function-destroy_binary.md)。

## 函数原型

- **C函数原型**

    ```c
    aclrtBinary aclrtCreateBinary(const void *data, size_t dataLen)
    ```

- **python函数**

    ```python
    binary = acl.rt.create_binary(data, data_len)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| data | int，存放算子二进制文件（*.o文件）数据的内存地址指针地址 |
| data_len | int，内存大小，单位Byte。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| binary | int，返回acl.rt.binary类型的指针地址。 |

## 约束说明

Ascend EP标准形态下，data参数处需申请Host上的内存；Ascend RC形态或Control CPU开放形态下，data参数处需申请Device上的内存。
