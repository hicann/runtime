# 函数：binary\_get\_function

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

根据kernel\_name，查找到对应的kernel对象，使用func\_handle表达。

对于同一个bin\_handle，首次调用acl.rt.binary\_get\_function接口时，会默认将bin\_handle关联的算子二进制数据拷贝至当前Context对应的Device上。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtBinaryGetFunction(const aclrtBinHandle binHandle, const char *kernelName, aclrtFuncHandle *funcHandle)
    ```

- **python函数**

    ```python
    func_handle, ret = acl.rt.binary_get_function(bin_handle, kernel_name)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| bin_handle | int，指向算子二进制的handle。调用[acl.rt.binary_load](function-binary_load.md)接口获取binHandle。 |
| kernel_name | str，kernel名称。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| func_handle | int，标识指定kernel的func_handle表达的指针地址。 |
| ret | int，错误码，返回0表示成功，返回[其它值](../datatypes/aclError.md)表示失败。 |
