# 函数：reset\_device

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

复位当前运算的Device，释放Device上的资源。释放的资源包括默认Context、默认Stream以及默认Context下创建的所有Stream。若默认Context或默认Stream下的任务还未完成，系统会等待任务完成后再释放。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtResetDevice(int32_t deviceId)
    ```

- **python函数**

    ```python
    ret = acl.rt.reset_device(device_id)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| device_id | int，Device设备号。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，错误码，返回0表示成功，返回[其它值](../datatypes/aclError.md)表示失败。 |

## 约束说明

若要复位的Device上存在显式创建的Context、Stream、Event，在复位前，建议遵循如下接口调用顺序，否则可能会导致业务异常。

**接口调用顺序**：调用[acl.rt.destroy\_event](../event/function-destroy_event.md)接口释放Event/调用[acl.rt.destroy\_stream](../stream/function-destroy_stream.md)接口释放显式创建的Stream--\>调用[acl.rt.destroy\_context](../context/function-destroy_context.md)释放显式创建的Context--\>调用[acl.rt.reset\_device](../device/function-reset_device.md)接口。

## 资源参考

接口调用流程与示例，请参见《应用开发》Python部分的运行时资源申请与释放、同步等待章节。
