# 函数：set\_device

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

指定当前线程中用于运算的Device。在不同线程中支持调用aclrtSetDevice接口指定同一个Device用于运算。

多Device场景下，可在进程中通过aclrtSetDevice接口切换到其他Device。

调用本接口会隐式创建默认Context，该默认Context中包含一个默认Stream。在同一个进程的多个线程中，如果调用aclrtSetDevice接口并指定相同的Device用于计算，那么这些线程将共享同一个默认Context。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtSetDevice(int32_t deviceId)
    ```

- **python函数**

    ```python
    ret = acl.rt.set_device(device_id)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| device_id | int，Device设备号。<br>用户调用[acl.rt.get_device_count](function-get_device_count.md)接口获取可用的Device数量后，取值范围：[0, (可用的Device数量 - 1)]。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，错误码，返回0表示成功，返回[其它值](../datatypes/aclError.md)表示失败。 |

## 约束说明

如果多次调用[acl.rt.set\_device](../device/function-set_device.md)接口而不调用[acl.rt.reset\_device](../device/function-reset_device.md)接口释放本进程使用的Device资源，功能上不会有问题，因为在进程退出时也会释放本进程使用的Device资源。建议[acl.rt.set\_device](../device/function-set_device.md)接口和[acl.rt.reset\_device](../device/function-reset_device.md)接口配对使用，在不使用Device上资源时，通过调用[acl.rt.reset\_device](../device/function-reset_device.md)接口及时释放本进程使用的Device资源。

在不同进程或线程中支持调用[acl.rt.set\_device](../device/function-set_device.md)接口指定同一个Device用于运算。在同一个进程中的多个线程中，如果调用[acl.rt.set\_device](../device/function-set_device.md)接口指定同一个Device用于运算，这时隐式创建的默认Context是同一个。

## 资源参考

接口调用流程与示例，请参见《应用开发》Python部分的运行时资源申请与释放、同步等待章节。
