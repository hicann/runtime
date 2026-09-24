# 函数：mem\_invalidate

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

将cache中的数据设置成无效。

该版本不需要用户处理CPU与NPU之间的cache一致性，无需调用该接口。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtMemInvalidate(void *devPtr, size_t size)
    ```

- **python函数**

    ```python
    ret = acl.rt.mem_invalidate(dev_ptr, size)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| devPtr | int，需要指定DDR内存对应的cache无效。 |
| size | int，DDR内存大小，单位Byte。“size”不能为0。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，错误码，返回0表示成功，返回[其它值](../datatypes/aclError.md)表示失败。 |
