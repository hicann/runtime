# 函数：kernel\_args\_append

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

调用本接口将用户设置的参数值追加拷贝到argsHandle指向的参数数据区域。若参数列表中有多个参数，则需按顺序追加参数。

如果要更新参数值，可调用[acl.rt.kernel\_args\_para\_update](function-kernel_args_para_update.md)接口进行更新。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtKernelArgsAppend(aclrtArgsHandle argsHandle, void *param, size_t paramSize, aclrtParamHandle *paramHandle)
    ```

- **python函数**

    ```python
    param_handle, ret = acl.rt.kernel_args_append(args_handle, param, param_size)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| args_handle | int，参数列表句柄。 |
| param | int，待追加参数值的内存地址。此处为Host内存地址。 |
| param_size | int，内存大小，单位Byte。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| param_handle | int，参数句柄。 |
| ret | int，返回0表示成功，返回其他值表示失败。 |
