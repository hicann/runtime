# 函数：update\_params

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

动态Shape场景下，设置算子Tiling参数、执行并发数。

## 函数原型

- **C函数原型**

    ```c
    aclError aclopUpdateParams(const char *opType,
    int numInputs,
    const aclTensorDesc *const inputDesc[],
    int numOutputs,
    const aclTensorDesc *const outputDesc[],
    const aclopAttr *attr)
    ```

- **python函数**

    ```python
    ret = acl.op.update_params(op_type, input_desc, output_desc, attr)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| op_type | str，算子类型名称。 |
| input_desc | list，算子输入Tensor的描述。 |
| output_desc | list，算子输出Tensor的描述。 |
| attr | int，算子属性。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，错误码，返回0表示成功，返回[其它值](aclError.md)表示失败。 |
