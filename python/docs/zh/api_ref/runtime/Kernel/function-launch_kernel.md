# 函数：launch\_kernel

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

启动对应Kernel的计算任务。仅支持Ascend C自定义算子。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtLaunchKernel(aclrtFuncHandle funcHandle, uint32_t numBlocks, const void *argsData, size_t argsSize, aclrtStream stream)
    ```

- **python函数**

    ```python
    ret = acl.rt.launch_kernel(func_handle, num_blocks, args_data, args_size, stream)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| func_handle | int，调用[acl.rt.binary_get_function](function-binary_get_function.md)接口根据kernel_name获取func_handle。 |
| num_blocks | int，指定核函数将会在几个核上执行。 |
| args_data | int，存放Kernel所有入参数据的Device内存地址指针。内存申请接口请参见[内存管理](../memory/memory_management.md)。 |
| args_size | int，argsData参数值的大小，单位为Byte。 |
| stream | int，指定执行任务的Stream，可复用已创建的Stream节省资源或调用[acl.rt.create_stream](../stream/function-create_stream.md)接口创建Stream，再作为入参在此处传入。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，错误码，返回0表示成功，返回[其它值](../datatypes/aclError.md)表示失败。 |

## 约束说明

该接口是异步接口，调用接口成功仅表示任务下发成功，不表示任务执行成功。调用该接口后，需调用同步等待接口（例如，[acl.rt.synchronize\_stream](../stream/function-synchronize_stream.md)）确保任务已执行完成。
