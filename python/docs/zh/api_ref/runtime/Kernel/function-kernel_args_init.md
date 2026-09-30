# 函数：kernel\_args\_init

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

根据核函数句柄初始化参数列表，并获取标识参数列表的句柄。

与[acl.rt.kernel\_args\_init\_by\_user\_mem](function-kernel_args_init_by_user_mem.md)接口的区别在于，调用本接口表示由系统管理内存。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtKernelArgsInit(aclrtFuncHandle funcHandle, aclrtArgsHandle *argsHandle)
    ```

- **python函数**

    ```python
    args_handle, ret = acl.rt.kernel_args_init(func_handle)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| func_handle | int，核函数句柄。<br>调用[acl.rt.binary_get_function](function-binary_get_function.md)获取核函数句柄，再将其作为入参传入本接口。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| args_handle | int，参数列表句柄。 |
| ret | int，返回0表示成功，返回其他值表示失败。 |
