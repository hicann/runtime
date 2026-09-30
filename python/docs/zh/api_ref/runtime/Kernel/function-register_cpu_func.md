# 函数：register\_cpu\_func

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

若使用[acl.rt.binary\_load\_from\_data](function-binary_load_from_data.md)接口加载AI CPU算子二进制数据，还需配合使用本接口注册AI CPU算子信息，得到对应的func\_handle。本接口只用于AI CPU算子，其它算子会返回报错ACL\_ERROR\_RT\_PARAM\_INVALID。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtRegisterCpuFunc(const aclrtBinHandle handle, const char *funcName, const char *kernelName, aclrtFuncHandle *funcHandle)
    ```

- **python函数**

    ```python
    func_handle, ret = acl.rt.register_cpu_func(bin_handle, func_name, kernel_name)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| bin_handle | int，算子二进制句柄。调用[acl.rt.binary_load_from_data](function-binary_load_from_data.md)接口获取算子二进制句柄，再将其作为入参传入本接口。 |
| func_name | str，执行AI CPU算子的入口函数。不能为空。 |
| kernel_name | str，AI CPU算子的opType。不能为空。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| func_handle | int，核函数句柄。 |
| ret | int，返回0表示成功，返回其他值表示失败。 |
