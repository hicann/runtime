# 函数：launch\_kernel\_with\_host\_args

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

基于Host内存传递核函数入参，并启动对应算子的计算任务。异步接口。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtLaunchKernelWithHostArgs(aclrtFuncHandle funcHandle, uint32_t numBlocks, aclrtStream stream, aclrtLaunchKernelCfg *cfg, void *hostArgs, size_t argsSize, aclrtPlaceHolderInfo *placeHolderArray, size_t placeHolderNum)
    ```

- **python函数**

    ```python
    ret = acl.rt.launch_kernel_with_host_args(func_handle, num_blocks, stream, cfg, host_args_ptr, host_args_size, place_holder_list, place_holder_num)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| func_handle | int，核函数句柄。 |
| num_blocks | int，指定核函数将会在几个核上执行。 |
| stream | int，指定执行任务的Stream。 |
| cfg | list，任务下发的配置信息。list中每个元素的数据类型为字典，具体请参见[aclrtLaunchKernelCfg](../datatypes/aclrtLaunchKernelCfg.md)。不指定配置时，此处可传空列表。 |
| host_args_ptr | int, 存放核函数所有入参数据的Host内存地址指针。 |
| host_args_size | int, host_args参数值的大小，单位为Byte。 |
| place_holder_list | list, placeholder参数列表。list中每个元素的数据类型为字典，具体请参见[aclrtPlaceHolderInfo](../datatypes/aclrtPlaceHolderInfo.md)。 |
| place_holder_num | int, placeholder参数列表的大小。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，返回0表示成功，返回其他值表示失败。 |
