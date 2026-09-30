# 函数：execute\_v2

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

执行指定的算子。异步接口。

每个算子的输入、输出、属性不同，需要应用在调用时严格按照算子输入、输出、属性来组织算子。用户在调用acl.op.execute\_v2接口时，根据op\_type、输入Tensor的描述、输出Tensor的描述、attr等信息查找对应的任务，并下发执行。

## 函数原型

- **C函数原型**

    ```c
    aclError aclopExecuteV2(const char *opType, int numInputs, aclTensorDesc *inputDesc[], aclDataBuffer *inputs[], int numOutputs, aclTensorDesc *outputDesc[], aclDataBuffer *outputs[], aclopAttr *attr, aclrtStream stream)
    ```

- **python函数**

    ```python
    ret = acl.op.execute_v2(op_type, input_desc, inputs, output_desc, outputs, attr, stream)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| op_type | str，指定算子类型名称。 |
| input_desc | list，表示算子输入Tensor的描述，整形列表，包含多个acl的Tensor描述地址对象。 |
| inputs | list，表示算子输入Tensor，整形列表，包含多个aclDataBuffer数据地址对象。 |
| output_desc | list，表示算子输出Tensor的描述，整形列表，包含多个acl的Tensor描述地址对象。 |
| outputs | list，表示算子输出Tensor，整形列表，包含多个aclDataBuffer数据地址对象。 |
| attr | int，算子的属性地址对象。 |
| stream | int，该算子需要加载的Stream对象。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，错误码，返回0表示成功，返回[其它值](aclError.md)表示失败。 |

## 约束说明

- 多线程场景下，不支持调用本接口时指定同一个Stream或使用默认Stream，否则可能任务执行异常。

- 对于支持动态Shape的算子，无法明确算子输出Shape时，可调用acl.op.infer\_shape接口获取算子的输出Shape：
    - 若可获取到准确的输出Shape，则使用准确的输出Shape来构造outputDesc参数，作为acl.op.execute\_v2的输入。该场景下，acl.op.execute\_v2接口是异步接口，对于异步接口，调用接口成功仅表示任务下发成功，不表示任务执行成功。调用该接口后，需调用同步等待接口（例如，`acl.rt.synchronize\_stream`）确保任务已执行完成。
    - 若无法获取准确的输出Shape，仅能获取输出Shape范围，则使用Shape最大值来构造outputDesc参数，作为acl.op.execute\_v2的输入。该场景下，在调用acl.op.execute\_v2接口执行算子后，系统内部会计算出准确的输出Shape，通过acl.op.execute\_v2接口的outputDesc参数输出，此时acl.op.execute\_v2接口是同步接口。
    - （该场景预留）若无法获取准确的输出Shape以及Shape范围，则需由用户预估一个最大的Shape来构造outputDesc参数，作为acl.op.execute\_v2的输入。该场景下，在调用acl.op.execute\_v2接口执行算子后，系统内部会计算出准确的输出Shape，通过acl.op.execute\_v2接口的outputDesc参数输出，此时acl.op.execute\_v2接口是同步接口。

- 执行有可选输入的算子时，如果可选输入不使用：
    - 则需按此种方式创建aclTensorDesc类型的数据：[acl.create\_tensor\_desc](function-create_tensor_desc.md)\(ACL\_DT\_UNDEFINED, 0, \[\], ACL\_FORMAT\_UNDEFINED\)，表示数据类型设置为ACL\_DT\_UNDEFINED，Format设置为ACL\_FORMAT\_UNDEFINED，Shape信息为\[\]。
    - 则需按此种方式创建aclDataBuffer类型的数据：acl.create\_data\_buffer\(\[\], 0\)，同时aclDataBuffer中的数据不需要释放。

- 执行有constant输入的算子时，需要先调用[acl.set\_tensor\_const](function-set_tensor_const.md)接口设置constant输入。

    调用acl.op.execute\_v2接口时，设置的constant输入数据必须保持一致。

    <!-- npu="950,A3,910b,910,310p,310b" id7 -->
    对于算子有constant输入的场景，如果未调用[acl.set\_tensor\_const](function-set_tensor_const.md)接口设置constant输入，则需调用[acl.set\_tensor\_place\_ment](function-set_tensor_place_ment.md)设置TensorDesc的placement属性，将memType设置为Host内存。
    <!-- end id7 -->

<!-- npu="950,A3,910b,910,310p,310b" id8 -->   
- 在执行单算子时，一般要求用户传入的输入/输出Tensor数据是存放在Device内存的，比如两个Tensor相加的场景。但是，也存在部分算子，除了将featureMap、weight等Device内存中的Tensor数据作为输入外，还需Tensor shape信息、learningRate、Tensor的dims信息等通常在Host内存中的Tensor数据也作为输入，此时，用户不需要额外将这些Host内存中的Tensor数据拷贝到Device上作为输入，只需要调用[acl.set\_tensor\_place\_ment](function-set_tensor_place_ment.md)接口设置对应TensorDesc的placement属性为Host内存，在执行单算子时，设置了placement属性为Host内存的TensorDesc，其对应的Tensor数据必须存放在Host内存中，内部会自动将Host上的Tensor数据拷贝到Device上。
<!-- end id8 -->

## 资源参考

接口调用流程、示例，参见[单算子调用](https://www.hiascend.com/document/detail/zh/CANNCommunityEdition/latest/others/acldevg/aclpythondevg_0067.html)。
