# 函数：get\_function\_name

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

根据核函数句柄获取核函数名称。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtGetFunctionName(aclrtFuncHandle funcHandle, uint32_t maxLen, char *name)
    ```

- **python函数**

    ```python
    func_name, ret = acl.rt.get_function_name(func_handle, max_len)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| func_handle | int，核函数句柄。 |
| max_len | int，用户申请用于存储核函数名称的最大内存大小，单位Byte。取值范围：[0, 1024)。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| func_name | str，核函数名称。 |
| ret | int，返回0表示成功，返回其他值表示失败。 |
