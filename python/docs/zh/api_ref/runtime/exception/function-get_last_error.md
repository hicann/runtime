# 函数：get\_last\_error

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

获取当前线程的Runtime（运行时管理模块）错误码，获取后清空当前线程的错误码，这时在线程中无新增错误码之前，调用本接口获取到的是表示成功的返回码ACL\_SUCCESS。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtGetLastError(aclrtLastErrLevel level)
    ```

- **python函数**

    ```python
    ret = acl.rt.get_last_error(level)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| level | int，指定获取错误码的级别，当前仅支持线程级别。参考[aclrtLastErrLevel](../datatypes/aclrtLastErrLevel.md) |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，返回0表示成功，返回非0表示失败。 |
