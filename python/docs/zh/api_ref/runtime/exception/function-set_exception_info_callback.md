# 函数：set\_exception\_info\_callback

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

设置异常回调函数。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtSetExceptionInfoCallback(aclrtExceptionInfoCallback callback)
    ```

- **python函数**

    ```python
    ret = acl.rt.set_exception_info_callback(fn)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| callback | function，表示Python侧的回调函数，格式如下：<br>def exception_callback(exception_info)<br>"""<br>:exception_info: 表示异常信息aclrtExceptionInfo的指针地址<br>:return:<br>""" |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，错误码，返回0表示成功，返回[其它值](../datatypes/aclError.md)表示失败。 |

## 约束说明

- 回调函数涉及共享资源（例如锁），因此在使用回调函数需慎重，在回调函数内调用资源申请&释放、Stream同步、Device同步、任务下发、任务终止等接口，可能会导致错误或死锁。
- 您需要在执行异步任务之前，设置异常回调函数，当Device上的任务执行异常时，系统会向用户设置的异常回调函数中传入一个包含任务ID、Stream ID、线程ID、Device ID以及错误码的aclrtExceptionInfo的指针地址，并执行回调函数，用户可以再分别调用[acl.rt.get\_task\_id\_from\_exception\_info](function-get_task_id_from_exception_info.md)、[acl.rt.get\_stream\_id\_from\_exception\_info](function-get_stream_id_from_exception_info.md)、[acl.rt.get\_thread\_id\_from\_exception\_info](function-get_thread_id_from_exception_info.md)、[acl.rt.get\_device\_id\_from\_exception\_info](function-get_device_id_from_exception_info.md)、[acl.rt.get\_error\_code\_from\_exception\_info](function-get_error_code_from_exception_info.md)接口获取产生异常的任务ID、Stream ID、线程ID、Device ID以及错误码，便于定位问题。

    **使用场景举例**：例如，在调用`acl.op.execute_v2`接口前，调用acl.rt.set\_exception\_info\_callback接口设置异常回调函数，当算子在Device执行异常时，系统会向用户设置的异常回调函数中传入一个包含任务ID、Stream ID、线程ID、Device ID以及错误码的aclrtExceptionInfo的指针地址，并执行回调函数。

- 如果多次设置异常回调函数，以最后一次设置为准。
- 如果想清空回调函数，可再次调用acl.rt.set\_exception\_info\_callback接口进行重置（传入None或不传入参数）。

## 接口调用流程

使用场景举例：执行整网模型推理时（不支持动态Shape场景），如果产生AI Core报错，可以调用本接口获取报错算子的描述信息，再做进一步错误排查。

推荐的接口调用顺序如下：

1. 定义并实现异常回调函数**fn\(aclrtExceptionInfoCallback类型\)**，回调函数原型请参见[acl.rt.set\_exception\_info\_callback](function-set_exception_info_callback.md)。

    实现回调函数的关键步骤如下：

    a. 在异常回调函数**fn**内调用[acl.rt.get\_device\_id\_from\_exception\_info](function-get_device_id_from_exception_info.md)、[acl.rt.get\_stream\_id\_from\_exception\_info](function-get_stream_id_from_exception_info.md)、[acl.rt.get\_task\_id\_from\_exception\_info](function-get_task_id_from_exception_info.md)接口分别获取Device ID、Stream ID、Task ID。
    b. 在异常回调函数**fn**内调用`acl.mdl.create_and_get_op_desc`接口获取算子的描述信息。
    c. 在异常回调函数**fn**内调用`acl.get_tensor_desc_by_index`接口获取指定算子输入/输出的Tensor描述。
    d. 在异常回调函数**fn**内参考如下接口获取Tensor描述中的数据，进行进一步分析。

    例如，调用`acl.get_tensor_desc_address`接口获取Tensor数据的内存地址（用户可从该内存地址中获取Tensor数据）、调用`acl.get_tensor_desc_type`接口获取Tensor描述中的数据类型、调用`acl.get_tensor_desc_format`接口获取Tensor描述中的Format、调用`acl.get_tensor_desc_num_dims`接口获取Tensor描述中的Shape维度个数、调用`acl.get_tensor_desc_dim_v2`接口获取Shape中指定维度的大小。

2. 调用`acl.rt.set_exception_info_callback`接口设置异常回调函数。
3. 执行模型推理。

    如果存在AI Core报错，则触发回调函数**fn**，获取算子的信息，进行进一步分析。

## 示例代码

调用接口后，需增加异常处理的分支，示例代码中不一一列举。以下是关键步骤的代码示例，不可以直接拷贝运行，仅供参考。

示例中，运行时资源申请与释放请参见《应用开发》Python部分的运行时资源申请与释放，模型加载的接口调用流程请参见模型管理中的接口调用流程，模型推理的接口调用流程、准备模型推理的输入/输出数据的接口调用流程请参见准备模型执行的输入/输出数据结构。

```python
import acl
import numpy as np
# ......

# 1.申请运行时资源。
# ......

# 2.模型加载，加载成功后，返回标识模型的model_id。
# ......

# 3.创建aclmdlDataset类型的数据，用于描述模型的输入数据input、输出数据output。
# ......

# 4.实现异常回调函数。
def exception_callback(info):
    stream_id = acl.rt.get_stream_id_from_exception_info(info)
    device_id = acl.rt.get_device_id_from_exception_info(info)
    task_id = acl.rt.get_task_id_from_exception_info(info)
    # 用户可以将获取的算子信息写入到文件，或者另起线程侦听异常回调，当发生异常回调时触发线程处理函数，在线程处理函数中将算子信息打屏。
    op_name, input_desc, num_inputs, output_desc, num_outputs, ret = \
        acl.mdl.create_and_get_op_desc(device_id, stream_id, task_id, 256)

    # 可以调用acl Tensor的相关接口，获取算子的相关信息，用户可以根据自己需要调用。
    for i in range(num_inputs):
        desc = acl.get_tensor_desc_by_index(input_desc, i)
        address = acl.get_tensor_desc_address(desc)
        num_dims = acl.get_tensor_desc_num_dims(desc)
        dim_0, ret = acl.get_tensor_desc_dim_v2(desc, 0)

    for i in range(num_outputs):
        desc = acl.get_tensor_desc_by_index(output_desc, i)
        address = acl.get_tensor_desc_address(desc)
        num_dims = acl.get_tensor_desc_num_dims(desc)
        dim_0, ret = acl.get_tensor_desc_dim_v2(desc, 0)

    acl.destroy_tensor_desc(input_desc)
    acl.destroy_tensor_desc(output_desc)

# 5.设置异常回调。
ret = acl.rt.set_exception_info_callback(exception_callback)

# 6.执行模型。
ret = acl.mdl.execute(model_id, input, output)

# 7.处理模型推理结果。
# ......

# 8.释放描述模型输入/输出信息、内存等资源，卸载模型。
# ......

# 9.释放运行时资源。
# ......
```
