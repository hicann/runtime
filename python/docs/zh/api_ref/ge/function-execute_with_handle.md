# 函数：execute\_with\_handle

## 产品支持情况

<!-- npu="950" id1 -->
- Ascend 950PR&950DT系列产品：不支持
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

以Handle方式调用一个算子，不支持动态Shape算子，动态Shape算子请使用[acl.op.execute\_v2](function-execute_v2-1.md)。异步接口。

## 函数原型

- **C函数原型**

    ```c
    aclError aclopExecWithHandle(aclopHandle *handle, int numInputs, const aclDataBuffer *const inputs[], int numOutputs, aclDataBuffer *const outputs[], aclrtStream stream)
    ```

- **python函数**

    ```python
    ret = acl.op.execute_with_handle(handle, inputs, outputs, stream)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| handle | int，指定执行算子的handle，指针地址。需提前调用[acl.op.create_handle](function-create_handle.md)接口创建aclopHandle类型的数据。 |
| inputs | list，算子输入Tensor，整形列表，包含多个aclDataBuffer数据地址对象。需提前调用`acl.create_data_buffer`接口创建aclDataBuffer类型的数据。 |
| outputs | list，算子输出Tensor，整形列表，包含多个aclDataBuffer数据地址对象。需提前调用`acl.create_data_buffer`接口创建aclDataBuffer类型的数据。 |
| stream | int，执行算子所在的Stream，stream地址对象。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，错误码，返回0表示成功，返回[其它值](aclError.md)表示失败。 |

## 约束说明

- 该接口是异步接口，调用接口成功仅表示任务下发成功，不表示任务执行成功。调用该接口后，需调用同步等待接口（例如，`acl.rt.synchronize\_stream`）确保任务已执行完成。

- 多线程场景下，不支持调用本接口时指定同一个Stream或使用默认Stream，否则可能任务执行异常。
- 执行有可选输入的算子时，如果可选输入不使用，则需参考以下方式创建aclDataBuffer类型的数据。

    ```python
    acl.create_data_buffer(nullptr, 0)
    ```

 同时aclDataBuffer中的数据不需要释放，因为是空的数据类型。
