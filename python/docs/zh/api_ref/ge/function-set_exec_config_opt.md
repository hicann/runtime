# 函数：set\_exec\_config\_opt

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

设置模型执行的配置对象中的各属性的取值。

## 函数原型

- **C函数原型**

    ```c
    aclError aclmdlSetExecConfigOpt(aclmdlExecConfigHandle *handle, aclmdlExecConfigAttr attr, const void *attrValue, size_t valueSize)
    ```

- **python函数**

    ```python
    ret = acl.mdl.set_exec_config_opt(handle, attr, attrValue)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| handle | int，模型执行的配置对象的指针地址。需提前调用[acl.mdl.create_exec_config_handle](function-create_exec_config_handle.md)接口创建该对象的指针地址。 |
| attr | int，指定需设置的属性。具体请参见[aclmdlExecConfigAttr](aclmdlExecConfigAttr.md)。 |
| attrValue | int，attr对应的属性取值。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，错误码，返回0表示成功，返回[其它值](aclError.md)表示失败。 |

## 约束说明

本接口需要配合其它接口一起使用，实现模型执行，接口调用顺序如下：

1. 调用[acl.mdl.create\_exec\_config\_handle](function-create_exec_config_handle.md)接口创建模型执行的配置对象。
2. 多次调用[acl.mdl.set\_exec\_config\_opt](function-set_exec_config_opt.md)接口设置配置对象中每个属性的值。
3. 调用[acl.mdl.execute\_v2](function-execute_v2.md)接口指定模型执行时需要的配置信息，并进行模型执行。
4. 模型加载成功后，调用[acl.mdl.destroy\_exec\_config\_handle](function-destroy_exec_config_handle.md)接口销毁。
