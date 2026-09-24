# 函数：execute\_async

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

执行模型推理，异步接口。

## 函数原型

- **C函数原型**

    ```c
    aclError aclmdlExecuteAsync(uint32_t modelId, const aclmdlDataset *input, aclmdlDataset *output, aclrtStream stream)
    ```

- **python函数**

    ```python
    ret = acl.mdl.execute_async(model_id, input, output, stream)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| model_id | int，指定需要执行推理的模型的ID。调用模型加载接口（例如[acl.mdl.load_from_file](function-load_from_file.md)接口、[acl.mdl.load_from_mem](function-load_from_mem.md)等）成功后，会返回模型ID，该ID作为本接口的输入。 |
| input | int，模型推理的输入数据的指针地址，具体请参见[acl.mdl.load_from_file](function-load_from_file.md)。 |
| output | int，模型推理的输出数据的指针地址，具体请参见[acl.mdl.load_from_file](function-load_from_file.md)。 |
| stream | int，指定已创建的Stream指针地址，如需指定新的Stream，可通过`acl.rt.create_stream`等接口创建并获取Stream指针地址。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，错误码，返回0表示成功，返回[其它值](aclError.md)表示失败。 |

## 约束说明

- 该接口是异步接口，调用接口成功仅表示任务下发成功，不表示任务执行成功。调用该接口后，需调用同步等待接口（例如，`acl.rt.synchronize\_stream`）确保任务已执行完成。
- 对同一个model\_id的模型，不可通过acl.mdl.execute\_async接口执行多Stream并发场景下的模型推理。
- 如需在多线程中使用同一个model\_id，则用户线程间需加锁，保证刷新输入输出内存、保证执行是连续操作，例如：

    ```python
    # 线程A的接口调用顺序：
    lock(handle1) -> acl.rt.memcpy_async(stream1)刷新输入输出内存 -> acl.mdl.execute_async(modelId1,stream1)执行推理 -> unlock(handle1)

    # 线程B的接口调用顺序：
    lock(handle1) -> acl.rt.memcpy_async(stream1)刷新输入输出内存 -> acl.mdl.execute_async(modelId1,stream1)执行推理 -> unlock(handle1)
    ```

- 模型加载、模型执行、模型卸载的操作必须在同一个Context下（关于Context的创建请参见acl.rt.create\_context）。
- 存放模型输入/输出数据的内存，可以使用以下接口申请：acl.rt.malloc、acl.rt.malloc\_host、acl.rt.malloc\_cached接口、acl.media.dvpp\_malloc接口或acl.himpi.dvpp\_malloc接口。

 其中，acl.media.dvpp\_malloc接口和acl.himpi.dvpp\_malloc接口是媒体数据处理功能专用的内存申请接口，一般从性能角度，为了减少拷贝，媒体数据处理的输出作为模型推理的输入，实现内存复用。

- 但由于媒体数据处理访问的地址空间有限，为确保媒体数据处理时内存足够，除媒体数据处理功能外的其它功能（例如，模型加载），建议调用其它接口申请内存，例如acl.rt.malloc接口。

## 资源参考

- 接口调用流程，参见[接口调用流程](https://www.hiascend.com/document/detail/zh/CANNCommunityEdition/latest/others/acldevg/aclpythondevg_0037.html)。
- 接口调用示例，参见[示例代码](https://www.hiascend.com/document/detail/zh/CANNCommunityEdition/latest/others/acldevg/aclpythondevg_0038.html)。
- Stream创建与管理，请参见[Stream管理](https://www.hiascend.com/document/detail/zh/CANNCommunityEdition/latest/others/acldevg/aclpythondevg_0017.html)。
