# 函数：synchronize\_device\_with\_timeout

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

阻塞应用程序运行，直到正在运算中的Device完成运算。该接口是在[synchronize\_device](function-synchronize_device.md)接口基础上进行了增强，支持用户设置超时时间，当应用程序异常时可根据所设置的超时时间自行退出，超时退出时本接口返回ACL\_ERROR\_RT\_STREAM\_SYNC\_TIMEOUT。

多Device场景下，调用该接口等待的是当前Context对应的Device。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtSynchronizeDeviceWithTimeout(int32_t timeout)
    ```

- **python函数**

    ```python
    ret = acl.rt.synchronize_device_with_timeout(timeout)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| timeout | int，接口的超时时间。<br>取值说明如下：<br>-1：表示永久等待，和接口[synchronize_device](function-synchronize_device.md)功能一样；<br>&gt;0：配置具体的超时时间，单位是毫秒。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，错误码，返回0表示成功，返回[其它值](../datatypes/aclError.md)表示失败。 |
