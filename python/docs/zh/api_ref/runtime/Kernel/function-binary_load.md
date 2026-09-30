# 函数：binary\_load

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

解析、加载算子二进制文件，输出指向算子二进制的binHandle，同时将算子二进制文件数据拷贝至当前Context对应的Device上。仅支持Ascend C自定义算子。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtBinaryLoad(const aclrtBinary binary, aclrtBinHandle *binHandle)
    ```

- **python函数**

    ```python
    bin_handle, ret = acl.rt.binary_load(binary)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| binary | int，算子二进制信息。此处需先调用[acl.rt.create_binary](function-create_binary.md)接口，获取acl.rt.binary类型数据的指针。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| bin_handle | int，指向二进制的handle的指针地址。 |
| ret | int，错误码，返回0表示成功，返回[其它值](../datatypes/aclError.md)表示失败。 |
