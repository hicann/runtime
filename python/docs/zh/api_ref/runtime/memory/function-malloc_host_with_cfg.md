# 函数：malloc\_host\_with\_cfg

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

申请Host内存（该内存是锁页内存），由系统保证内存首地址64字节对齐。与[acl.rt.malloc\_host](function-malloc_host.md)接口相比，本接口在申请内存时，还可以指定内存相关的配置信息

<!-- npu="310p,310b" id7 -->
针对Ascend RC形态、Control CPU开放形态，Host与Device是合一的，所以申请Host内存也等同于申请Device内存。此外，申请内存时，按普通页申请。如果需要64字节对齐的首地址，用户需自行处理对齐问题。
<!-- end id7 -->

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtMallocHostWithCfg(void **ptr, uint64_t size, aclrtMallocConfig *cfg)
    ```

- **python函数**

    ```python
    host_ptr, ret = acl.rt.malloc_host_with_cfg(size, cfg)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| size | int，申请内存的大小，单位Byte。size不能为0。 |
| cfg | dict，内存配置信息。不指定配置时，此处可传空字典，具体请参见[aclrtMallocConfig](../datatypes/aclrtMallocConfig.md)。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| host_ptr | int，指向Host上已分配内存的指针地址。 |
| ret | int，错误码，返回0表示成功，返回[其它值](../datatypes/aclError.md)表示失败。 |
