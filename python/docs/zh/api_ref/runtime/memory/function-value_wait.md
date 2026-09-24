# 函数：value\_wait

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
- Atlas 200I/500 A2推理产品：不支持
<!-- end id4 -->
<!-- npu="310p" id5 -->
- Atlas推理系列产品：不支持
<!-- end id5 -->
<!-- npu="910" id6 -->
- Atlas训练系列产品：不支持
<!-- end id6 -->

## 功能说明

等待指定内存中的数据满足一定条件后解除阻塞。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtValueWait(void* devAddr, uint64_t value, uint32_t flag, aclrtStream stream) 
    ```

- **python函数**

    ```python
    ret = acl.rt.value_wait(devAddr, value, flag, stream)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| devAddr | int，Device侧内存地址。<br>dev_addr的有效内存位宽为64bit。 |
| value | int，需与内存中的数据作比较的值。 |
| flag | int，比较的方式，等满足条件后解除阻塞。<br>取值如下：<br>0x0：ACL_STREAM_WAIT_VALUE_GEQ<br>0x1：ACL_STREAM_WAIT_VALUE_EQ<br>0x2：ACL_STREAM_WAIT_VALUE_AND<br>0x3：ACL_STREAM_WAIT_VALUE_NOR |
| stream | int，指定stream。此处支持传0，表示使用默认Stream。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，错误码，返回0表示成功，返回[其它值](../datatypes/aclError.md)表示失败。 |
