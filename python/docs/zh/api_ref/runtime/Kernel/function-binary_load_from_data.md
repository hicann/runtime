# 函数：binary\_load\_from\_data

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

从内存加载并解析AI CPU算子二进制数据，输出指向算子二进制的binHandle。

调用本接口用于加载AI CPU算子信息（aclrtBinaryLoadOptions中的option\_type包含ACL\_RT\_BINARY\_LOAD\_OPT\_CPU\_KERNEL\_MODE）时，还需配合使用[acl.rt.register\_cpu\_func](function-register_cpu_func.md)接口注册AI CPU算子信息。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtBinaryLoadFromData(const void *data, size_t length, const aclrtBinaryLoadOptions *options, aclrtBinHandle *binHandle)
    ```

- **python函数**

    ```python
    bin_handle, ret = acl.rt.binary_load_from_data(mem_addr, length, options)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| mem_addr | int，存放算子二进制数据的Host内存地址，不能为空。 |
| length | int，算子二进制数据的内存大小，必须大于0，单位Byte。 |
| options | list，加载算子二进制文件的可选参数，结构参考[aclrtBinaryLoadOptions](../datatypes/aclrtBinaryLoadOptions.md)，若参数为空，可将options设置为[]。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| bin_handle | int，标识算子二进制的句柄。 |
| ret | int，返回0表示成功，返回其他值表示失败。 |
