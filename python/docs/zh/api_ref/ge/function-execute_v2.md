# 函数：execute\_v2

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

根据[acl.mdl.set\_exec\_config\_opt](function-set_exec_config_opt.md)接口所配置的属性，执行模型推理，直到返回推理结果。该接口是在[acl.mdl.execute](function-execute.md)接口基础上进行了增强，支持在执行模型推理时控制Stream任务的超时时间、Event任务的超时时间。

## 函数原型

- **C函数原型**

    ```c
    aclError aclmdlExecuteV2(uint32_t modelId, const aclmdlDataset*input, aclmdlDataset *output, aclrtStream stream, const aclmdlExecConfigHandle *handle)
    ```

- **python函数**

    ```python
    ret = acl.mdl.execute_v2(model_id, input, output, stream, handle)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| model_id | int，指定需要执行推理的模型的ID。调用模型加载接口（例如[acl.mdl.load_from_file](function-load_from_file.md)接口、[acl.mdl.load_from_mem](function-load_from_mem.md)等）成功后，会返回模型ID，该ID作为本接口的输入。 |
| input | int，模型推理的输入数据的指针地址，具体请参见[acl.mdl.load_from_file](function-load_from_file.md)。 |
| output | int，模型推理的输出数据的指针地址，具体请参见[acl.mdl.load_from_file](function-load_from_file.md)。调用acl.create_data_buffer接口创建存放对应index输出数据的aclDataBuffer类型时，可通过data参数处传入0，同时设置size为0，创建一个空的aclDataBuffer类型，在模型执行过程中，系统内部自行计算并申请该index输出的内存。使用该方式可节省内存，但内存数据使用结束后，需由用户释放内存并重置aclDataBuffer，并且系统内部申请内存时涉及内存拷贝，可能涉及性能损耗。释放内存并重置aclDataBuffer的示例代码如下：data_buffer = acl.mdl.get_dataset_buffer(output, 0) # 根据index获取对应的dataBuffer data_addr = acl.get_data_buffer_addr(data_buffer) # 获取data的Device指针地址acl.rt.free(data_addr) # 释放Device内存acl.update_data_buffer(data_buffer, 0, 0) # 重置dataBuffer，以便下次推理 |
| stream | int，指定已创建的Stream指针地址，如需指定新的Stream，可通过`acl.rt.create_stream`等接口创建并获取Stream指针地址。 |
| handle | int，模型执行的配置对象的指针地址，与[acl.mdl.set_exec_config_opt](function-set_exec_config_opt.md)中的handle保持一致。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，错误码，返回0表示成功，返回[其它值](aclError.md)表示失败。 |

## 约束说明

- 本接口需要配合其它接口一起使用，实现模型执行，接口调用顺序如下：
    1. 调用[acl.mdl.create\_exec\_config\_handle](function-create_exec_config_handle.md)接口创建模型执行的配置对象的指针地址。
    2. 多次调用[acl.mdl.set\_exec\_config\_opt](function-set_exec_config_opt.md)接口设置配置对象中每个属性的值。
    3. 调用acl.mdl.execute\_v2接口指定模型执行时需要的配置信息，并进行模型执行。
    4. 模型加载成功后，调用[acl.mdl.destroy\_exec\_config\_handle](function-destroy_exec_config_handle.md)接口销毁。

- 其他约束与[acl.mdl.execute](function-execute.md)一致。

## 资源参考

- 接口调用流程及示例代码，参见[模型执行](https://www.hiascend.com/document/detail/zh/CANNCommunityEdition/latest/others/acldevg/aclpythondevg_0032.html)。
- Stream创建与管理，请参见[Stream管理](https://www.hiascend.com/document/detail/zh/CANNCommunityEdition/latest/others/acldevg/aclpythondevg_0017.html)。
