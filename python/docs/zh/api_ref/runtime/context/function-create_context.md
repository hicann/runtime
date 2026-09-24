# 函数：create\_context

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

在当前进程或线程中显式创建一个Context。

如果在应用程序中没有调用[acl.rt.set\_device](../device/function-set_device.md)接口，那么在首次调用acl.rt.create\_context接口时，系统内部会根据该接口传入的Device ID，为该Device绑定一个默认Stream（一个Device仅绑定一个默认Stream），因此在首次调用acl.rt.create\_context接口时，占用的Stream数量=Device上绑定的默认Stream+Context中包含的Stream。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtCreateContext(aclrtContext *context, int32_t deviceId)
    ```

- **python函数**

    ```python
    context, ret = acl.rt.create_context(device_id)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| device_id | int，指定需要创建Context的Device设备号。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| context | int，表示创建的Context的指针地址。 |
| ret | int，错误码，返回0表示成功，返回[其它值](../datatypes/aclError.md)表示失败。 |

## 约束说明

支持以下使用场景：

- 若不调用[acl.rt.create\_context](function-create_context.md)接口显式创建Context，那系统会使用默认Context，该默认Context是在调用[acl.rt.set\_device](../device/function-set_device.md)接口时隐式创建的。
  - 隐式创建Context：适合简单、无复杂交互逻辑的应用，但缺点在于，在多线程编程中，执行结果取决于线程调度的顺序。
  - 显式创建Context：适合大型、复杂交互逻辑的应用，便于提高程序的可读性、可维护性。

- 在某一进程中指定Device，该进程内的多个线程可共用在此Device上显式创建的Context（调用[acl.rt.create\_context](function-create_context.md)接口显式创建Context）。
- 若在某一进程内创建多个Context（Context的数量与Stream相关，Stream数量有限制，请参见[acl.rt.create\_stream](../stream/function-create_stream.md)），当前线程在同一时刻内只能使用其中一个Context，建议通过[acl.rt.set\_context](../context/function-set_context.md)接口明确指定当前线程的Context，增加程序的可维护性**。**

## 资源参考

接口调用流程与示例，请参见《应用开发》Python部分的运行时资源申请与释放章节。
