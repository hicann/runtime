# 函数：launch\_kernel\_with\_config

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

指定任务下发的配置信息，并启动对应算子的计算任务。异步接口。

若使用本接口下发AI Core算子的计算任务，需配套使用[acl.rt.binary\_load\_from\_file](function-binary_load_from_file.md)接口加载并解析算子二进制文件。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtLaunchKernelWithConfig(aclrtFuncHandle funcHandle, uint32_t numBlocks, aclrtStream stream, aclrtLaunchKernelCfg *cfg, aclrtArgsHandle argsHandle, void *reserve)
    ```

- **python函数**

    ```python
    ret = acl.rt.launch_kernel_with_config(func_handle, num_blocks, stream, cfg, args_handle, reserve)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| func_handle | int，核函数句柄。 |
| num_blocks | int，指定核函数将会在几个核上执行。 |
| stream | int，指定执行任务的Stream。 |
| cfg | list，任务下发的配置信息。不指定配置时，此处可传空列表。list中每个元素的数据类型为字典，具体请参见[aclrtLaunchKernelCfg](../datatypes/aclrtLaunchKernelCfg.md)。 |
| args_handle | int，参数列表句柄。 |
| reserve | int，预留参数。当前固定传0。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，返回0表示成功，返回其他值表示失败。 |
