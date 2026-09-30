# 函数：kernel\_args\_get\_place\_holder\_buffer

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

根据用户指定的内存大小，获取param\_handle占位符指向的内存地址。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtKernelArgsGetPlaceHolderBuffer(aclrtArgsHandle argsHandle, aclrtParamHandle paramHandle, size_t dataSize, void **bufferAddr)
    ```

- **python函数**

    ```python
    buffer_addr, ret = acl.rt.kernel_args_get_place_holder_buffer(args_handle, param_handle, data_size)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| args_handle | int，参数列表句柄。 |
| param_handle | int，参数句柄。<br>此处的param_handle需与[acl.rt.kernel_args_append_place_holder](function-kernel_args_append_place_holder.md)接口中的param_handle保持一致。 |
| data_size | int，内存大小 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| buffer_addr | int，param_handle占位符指向的内存地址。<br>后续由用户管理该内存中的数据，但无需管理该内存的生命周期。 |
| ret | int，返回0表示成功，返回其他值表示失败。 |
