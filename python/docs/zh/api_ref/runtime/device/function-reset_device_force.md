# 函数：reset\_device\_force

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

[acl.rt.reset\_device\_force](function-reset_device_force.md)接口可与[acl.rt.set\_device](../device/function-set_device.md)接口配对使用，也可不与aclrtSetDevice接口配对使用，若不配对使用，一个进程中，针对同一个Device，调用一次或多次[acl.rt.set\_device](../device/function-set_device.md)接口后，仅需调用一次本接口可释放Device上的资源。

```python
# 与acl.rt.set_device接口配对使用：
acl.rt.set_device(1) -> acl.rt.reset_device_force(1) -> acl.rt.set_device(1) -> acl.rt.reset_device_force(1)
 
# 与acl.rt.set_device接口不配对使用：
acl.rt.set_device(1) -> acl.rt.set_device(1) -> acl.rt.reset_device_force(1)
```

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtResetDeviceForce(int32_t deviceId)
    ```

- **python函数**

    ```python
    ret = acl.rt.reset_device_force(device_id)
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

- 多线程场景下，针对同一个Device，如果每个线程中都调用[acl.rt.set\_device](../device/function-set_device.md)接口、acl.rt.reset\_device\_force接口，如下所示，线程2中的acl.rt.reset\_device\_force接口会返回报错，因为线程1中acl.rt.reset\_device\_force接口已经释放了Device 1的资源：

    ```python
    时间线 ------------------------------------------------------------------------------>
    线程1：acl.rt.set_device(1)  acl.rt.reset_device_force(1)
    线程2：acl.rt.set_device(1)                                acl.rt.reset_device_force(1)
    ```

    多线程场景下，正确方式是应在线程执行的最后，调用一次acl.rt.reset\_device\_force释放Device资源，如下所示：

    ```python
    时间线 ------------------------------------------------------------------------------>
    线程1：acl.rt.set_device(1)  
    线程2：acl.rt.set_device(1)                                acl.rt.reset_device_force(1)
    ```

- [acl.rt.reset\_device](../device/function-reset_device.md)接口与acl.rt.reset\_device\_force接口可以混用，但混用时，若两个Reset接口的调用次数、调用顺序不对，接口会返回报错。

    ```python
    # 混用时的正确方式：
    # 两个Reset接口都分别与Set接口配对使用，且acl.rt.reset_device_force接口在acl.rt.reset_device接口之后
    acl.rt.set_device(1) -> acl.rt.reset_device(1) -> acl.rt.set_device(1) -> acl.rt.reset_device_force(1)
    acl.rt.set_device(1) -> acl.rt.set_device(1) -> acl.rt.reset_device(1) -> acl.rt.reset_device_force(1)
    
    # 混用时的错误方式：
    # acl.rt.reset_device接口内部涉及引用计数的实现，当acl.rt.reset_device接口每被调用一次，则该引用计数减1，
    # 当引用计数减到0时，会真正释放Device上的资源，此时再调用acl.rt.reset_device或acl.rt.reset_device_force接口都会报错
    acl.rt.set_device(1) -> acl.rt.set_device(1) -> acl.rt.reset_device(1) -> acl.rt.reset_device(1) -> acl.rt.reset_device_force(1)
    acl.rt.set_device(1) -> acl.rt.set_device(1) -> acl.rt.reset_device(1) -> acl.rt.reset_device_force(1) -> acl.rt.reset_device_force(1)
    # acl.rt.reset_device_force接口在acl.rt.reset_device接口之后，否则接口返回报错
    acl.rt.set_device(1) -> acl.rt.set_device(1) -> acl.rt.reset_device_force(1) -> acl.rt.reset_device(1)
    ```
