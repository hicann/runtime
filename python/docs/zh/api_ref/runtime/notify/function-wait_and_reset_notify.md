# 函数：wait\_and\_reset\_notify

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

阻塞指定Stream的运行，直到指定的Notify完成，再复位Notify。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtWaitAndResetNotify(aclrtNotify notify, aclrtStream stream, uint32_t timeout)
    ```

- **python函数**

    ```python
    ret = acl.rt.wait_and_reset_notify(notify, stream, timeout)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| notify | int，需等待的Notify指针地址。 |
| stream | int，指定Stream指针地址。例如，Stream2等Stream1的场景，此处配置为Stream2。<br>如果使用默认Stream，此处设置为0。 |
| timeout | int，等待的超时时间。<br>取值说明如下：<br>0：表示永久等待。<br>&gt;0:配置具体的超时时间，单位是毫秒。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，返回0表示成功，返回其他值表示失败。 |
