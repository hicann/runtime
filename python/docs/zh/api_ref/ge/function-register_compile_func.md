# 函数：register\_compile\_func

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

动态Shape场景下，注册算子选择器，用于在算子执行时，能针对不同shape，选择相应的Tiling策略。

如果某算子已注册算子选择器，则不允许重新注册，如果需要变更算子选择器，必须先调用`acl.op.unregister\_compile\_func`接口取消注册，然后再调用`acl.op.register\_compile\_func`接口重新注册。

## 函数原型

- **C函数原型**

    ```c
    aclError aclopRegisterCompileFunc(const char *opType, aclopCompileFunc func)
    ```

- **python函数**

    ```python
    ret = acl.op.register_compile_func(op_type, func)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| op_type | str，算子类型。 |
| func | python函数对象，算子选择器回调函数。<br>函数定义：def call_back_func(num_inputs, input_desc, num_outputs, output_desc, op_attr, aclop_kernel_desc): pass |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，错误码，返回0表示成功，返回[其它值](aclError.md)表示失败。 |

## 资源参考

接口调用流程、示例，参见[单算子调用](https://www.hiascend.com/document/detail/zh/CANNCommunityEdition/latest/others/acldevg/aclpythondevg_0067.html)。
