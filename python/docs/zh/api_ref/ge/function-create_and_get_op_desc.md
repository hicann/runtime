# 函数：create\_and\_get\_op\_desc

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

获取指定算子的描述信息，包括算子名、输入Tensor描述、输出Tensor描述，如果查询不到指定算子，则返回报错。该接口不支持动态Shape场景。

## 函数原型

- **C函数原型**

    ```c
    aclError aclmdlCreateAndGetOpDesc(uint32_t deviceId, uint32_t streamId, uint32_t taskId, char *opName, size_t opNameLen, aclTensorDesc **inputDesc, size_t *numInputs, aclTensorDesc **outputDesc, size_t *numOutputs)
    ```

- **python函数**

    ```python
    op_name, input_desc, num_inputs, output_desc, num_outputs, ret = acl.mdl.create_and_get_op_desc(device_id, stream_id, task_id, op_name_len)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| device_id | int，指定Device ID。调用`acl.rt.get_device_id_from_exception_info`接口获取异常信息中的Device ID，作为本接口的输入。 |
| stream_id | int，指定Stream ID。调用`acl.rt.get_stream_id_from_exception_info`接口获取异常信息中的Stream ID，作为本接口的输入。 |
| task_id | int，指定Task ID。调用`acl.rt.get_task_id_from_exception_info`接口获取异常信息中的Task ID，作为本接口的输入。 |
| op_name_len | int，算子名称字符串长度。若用户指定的长度比实际算子名称的长度短，则返回报错。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| op_name | string，算子名称字符串。 |
| input_desc | int，算子所有输入的Tensor描述，指向一块连续内存的首地址。 |
| num_inputs | int，输入个数。 |
| output_desc | int，算子所有输出的Tensor描述，指向一块连续内存的首地址。 |
| num_outputs | int，输出个数。 |
| ret | int，错误码，返回0表示成功，返回[其它值](aclError.md)表示失败。 |

## 约束说明

使用场景举例：执行整网模型推理时（不支持动态Shape场景），如果产生AI Core报错，可以调用本接口获取报错算子的描述信息，再做进一步错误排查。

推荐的接口调用顺序如下：

1. 定义并实现异常回调函数**fn\(aclrtExceptionInfoCallback类型\)**，回调函数原型请参见`acl.rt.set\_exception\_info\_callback`。

 实现回调函数的关键步骤如下：

    1.  在异常回调函数**fn**内调用`acl.rt.get\_device\_id\_from\_exception\_info`、`acl.rt.get\_stream\_id\_from\_exception\_info`、`acl.rt.get\_task\_id\_from\_exception\_info`接口分别获取Device ID、Stream ID、Task ID。
    2.  在异常回调函数**fn**内调用[acl.mdl.create\_and\_get\_op\_desc](function-create_and_get_op_desc.md)接口获取算子的描述信息。
    3.  在异常回调函数**fn**内调用[acl.get\_tensor\_desc\_by\_index](function-get_tensor_desc_by_index.md)接口获取指定算子输入/输出的Tensor描述。
    4.  在异常回调函数**fn**内参考如下接口获取Tensor描述中的数据，进行进一步分析。

    例如，调用[acl.get\_tensor\_desc\_address](function-get_tensor_desc_address.md)接口获取Tensor数据的内存地址（用户可从该内存地址中获取Tensor数据）、调用[acl.get\_tensor\_desc\_type](function-get_tensor_desc_type.md)接口获取Tensor描述中的数据类型、调用[acl.get\_tensor\_desc\_format](function-get_tensor_desc_format.md)接口获取Tensor描述中的Format、调用[acl.get\_tensor\_desc\_num\_dims](function-get_tensor_desc_num_dims.md)接口获取Tensor描述中的Shape维度个数、调用[acl.get\_tensor\_desc\_dim\_v2](function-get_tensor_desc_dim_v2.md)接口获取Shape中指定维度的大小。

2. 调用`acl.rt.set\_exception\_info\_callback`接口设置异常回调函数。
3. 执行模型推理。

 如果存在AI Core报错，则触发回调函数**fn**，获取算子的信息，进行进一步分析。
