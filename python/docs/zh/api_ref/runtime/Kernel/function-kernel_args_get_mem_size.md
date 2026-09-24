# 函数：kernel\_args\_get\_mem\_size

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

获取Kernel Launch时参数列表所需内存的实际大小。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtKernelArgsGetMemSize(aclrtFuncHandle funcHandle, size_t userArgsSize, size_t *actualArgsSize)
    ```

- **python函数**

    ```python
    actual_args_size, ret = acl.rt.kernel_args_get_mem_size(func_handle, user_args_size)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| func_handle | int，核函数句柄。<br>调用[acl.rt.binary_get_function](function-binary_get_function.md)获取核函数句柄，再将其作为入参传入本接口。 |
| user_args_size | int，在内存中存放参数列表数据所需的大小，单位为Byte。<br>每个参数数据的内存大小都需要8字节对齐，这里的user_args_size是这些对齐后的参数数据内存大小相加的总和。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| actual_args_size | int，Kernel Launch时参数列表所需内存的实际大小，单位为Byte。 |
| ret | int，返回0表示成功，返回其他值表示失败。 |
