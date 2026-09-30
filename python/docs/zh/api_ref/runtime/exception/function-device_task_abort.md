# 函数：device\_task\_abort

## 产品支持情况

<!-- npu="A3" id2 -->
- Atlas A3系列产品：支持
<!-- end id2 -->
<!-- npu="910b" id3 -->
- Atlas A2系列产品：支持
<!-- end id3 -->
<!-- npu="310b" id4 -->
- Atlas 200I/500 A2推理产品：不支持
<!-- end id4 -->
<!-- npu="310p" id5 -->
- Atlas推理系列产品：不支持
<!-- end id5 -->
<!-- npu="910" id6 -->
- Atlas训练系列产品：不支持
<!-- end id6 -->

## 功能说明

停止指定Device上的正在执行的任务，同时丢弃指定Device上已下发的任务。该接口支持用户设置永久等待、或配置具体的超时时间，若配置具体的超时时间，则调用本接口超出超时时间，则接口返回报错。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtDeviceTaskAbort(int32_t deviceId, uint32_t timeout);
    ```

- **python函数**

    ```python
    ret = acl.rt.device_task_abort(device_id, timeout)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| deviceId | int，Device ID。与[set_device](../device/function-set_device.md)接口中Device ID保持一致。 |
| timeout | int，超时时间。<br>取值说明如下：<br>0：表示永久等待；<br>&gt;0：配置具体的超时时间，单位是毫秒。最大超时时间36分钟。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，错误码，返回0表示成功，返回[其它值](../datatypes/aclError.md)表示失败。 |

## 约束说明

本接口为预留接口，暂不支持。
