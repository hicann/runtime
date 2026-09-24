# 函数：value\_write

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

向指定内存中写数据。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtValueWrite(void* devAddr, uint64_t value, uint32_t flag, aclrtStream stream)
    ```

- **python函数**

    ```python
    ret = acl.rt.value_write(dev_addr, value, flag, stream)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| dev_addr | int，Device侧内存地址。<br>此处需用户提前申请Device内存（例如调用acl.rt.malloc接口），dev_addr要求8字节对齐，有效内存位宽为64bit。 |
| value | int，需向内存中写入的数据。 |
| flag | int，预留参数，当前固定设置为0。 |
| stream | int，指定stream。此处支持传0，表示使用默认Stream。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，错误码，返回0表示成功，返回[其它值](../datatypes/aclError.md)表示失败。 |
