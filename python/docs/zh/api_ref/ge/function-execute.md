# 函数：execute

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

执行模型推理，直到返回推理结果。

## 函数原型

- **C函数原型**

    ```c
    aclError aclmdlExecute(uint32_t modelId, const aclmdlDataset *input, aclmdlDataset *output)
    ```

- **python函数**

    ```python
    ret = acl.mdl.execute(model_id, input, output)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| model_id | int，指定需要执行推理的模型的ID。调用模型加载接口（例如[acl.mdl.load_from_file](function-load_from_file.md)接口、[acl.mdl.load_from_mem](function-load_from_mem.md)等）成功后，会返回模型ID，该ID作为本接口的输入。 |
| input | int，模型推理的输入数据对应的指针地址，具体请参见[aclmdlDataset](aclmdlDataset.md)。 |
| output | int，模型推理的输出数据对应的指针地址，具体请参见[acl.mdl.load_from_file](function-load_from_file.md)。调用acl.create_data_buffer接口创建存放对应index输出数据的aclDataBuffer类型时，可通过data参数处传入0，同时设置size为0，创建一个空的aclDataBuffer类型，在模型执行过程中，系统内部自行计算并申请该index输出的内存。使用该方式可节省内存，但在内存数据使用结束后，需由用户释放内存并重置aclDataBuffer，并且系统内部在申请内存时涉及内存拷贝，可能涉及性能损耗。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，错误码，返回0表示成功，返回[其它值](aclError.md)表示失败。 |

## 约束说明

- 若由于业务需求，必须在多线程中使用同一个model\_id，则用户线程间需加锁，保证刷新输入输出内存、保证执行是连续操作，例如：

    ```python
    # 线程A的接口调用顺序：
    lock(handle1) -> acl.rt.memcpy刷新输入输出内存 -> acl.mdl.execute执行推理 -> unlock(handle1)

    # 线程B的接口调用顺序：
    lock(handle1) -> acl.rt.memcpy刷新输入输出内存 -> acl.mdl.execute执行推理 -> unlock(handle1)
    ```

- 模型加载、模型执行、模型卸载的操作必须在同一个Context下（关于Context的创建请参见acl.rt.create\_context）。
- 存放模型输入/输出数据的内存，可以使用以下接口申请：acl.rt.malloc、acl.rt.malloc\_host、acl.rt.malloc\_cached接口、acl.media.dvpp\_malloc接口或acl.himpi.dvpp\_malloc接口。

 其中：

    - 内存申请接口的具体使用场景及约束请参见相关接口的详细说明。
    - 当应用程序在Device上调用acl.rt.malloc\_host接口申请内存时，该内存为Device内存。
    - acl.media.dvpp\_malloc接口和acl.himpi.dvpp\_malloc接口是媒体数据处理功能专用的内存申请接口，一般从性能角度，为了减少拷贝，媒体数据处理的输出作为模型推理的输入，实现内存复用。
    - 但由于媒体数据处理访问的地址空间有限，为确保媒体数据处理时内存足够，除媒体数据处理功能外的其它功能（例如，模型加载），建议调用其它接口申请内存，例如acl.rt.malloc接口。

## 示例代码

```python
data_buffer = acl.mdl.get_dataset_buffer(output, 0) # 根据index获取对应的dataBuffer
data_addr = acl.get_data_buffer_addr(data_buffer)   # 获取data的Device指针地址
acl.rt.free(data_addr)                              # 释放Device内存
acl.update_data_buffer(data_buffer, 0, 0)           # 重置dataBuffer，以便下次推理
```
