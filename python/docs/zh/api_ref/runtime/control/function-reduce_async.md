# 函数：reduce\_async

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

执行Reduce操作，包括SUM、MIN、MAX等。

本接口是异步接口，调用接口成功仅表示任务下发成功，不表示任务执行成功。调用该接口后，需调用同步等待接口（例如，[synchronize\_stream](../stream/function-synchronize_stream.md)）确保任务已执行完成，否则可能会导致训练或推理等业务异常、Device断链掉卡等未知情况。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtReduceAsync(void *dst, const void *src, uint64_t count, aclrtReduceKind kind, aclDataType type, aclrtStream stream, void *reserve)
    ```

- **python函数**

    ```python
    ret = acl.rt.reduce_async(dst, src, count, kind, type, stream, reserve)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| dst | int，目的内存地址指针。 |
| src | int，源内存地址指针。 |
| count | int，源内存大小，单位为Byte。 |
| kind | int，操作类型。具体请参见新增数据结构[aclrtReduceKind](../datatypes/aclrtReduceKind.md)。 |
| type | int，数据类型。<br>具体请参见[aclDataType](../datatypes/aclDataType.md)。 |
| stream | int，指定Stream。如果使用默认Stream，此处设置为0。 |
| reserve | int，预留参数。当前固定传NULL。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，错误码，返回0表示成功，返回[其它值](../datatypes/aclError.md)表示失败。 |

## 约束说明

dts、src必须跟stream所在的Device是同一个设备。
<!-- npu="A3" id7 -->
Atlas A3系列产品支持如下类型：int8、int16、int32、fp16、fp32、bf16。
<!-- end id7 -->
<!-- npu="910b" id8 -->
Atlas A2系列产品支持如下类型：int8、int16、int32、fp16、fp32、bf16。
<!-- end id8 -->
<!-- npu="310b" id9 -->
Atlas 200I/500 A2推理产品支持如下类型：int8、int16、int32、fp16、fp32。
<!-- end id9 -->
<!-- npu="310p" id10 -->
Atlas推理系列产品支持如下类型：fp32  、fp16、int16。
<!-- end id10 -->
<!-- npu="910" id11 -->
Atlas训练系列产品仅支持fp32类型。
<!-- end id11 -->
