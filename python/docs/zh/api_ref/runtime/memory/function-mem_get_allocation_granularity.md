# 函数：mem\_get\_allocation\_granularity

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

查询内存申请粒度。系统内部计算给定分配规范的最小粒度或建议粒度，并以granularity参数返回粒度。此粒度可用作对齐、地址大小或地址映射的倍数。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtMemGetAllocationGranularity(aclrtPhysicalMemProp *prop, aclrtMemGranularityOptions option, size_t *granularity)
    ```

- **python函数**

    ```python
    granularity, ret = acl.rt.mem_get_allocation_granularity(prop, option)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| prop | dict，物理内存属性信息，具体请参见[aclrtPhysicalMemProp](../datatypes/aclrtPhysicalMemProp.md)。 |
| option | int，最小粒度或推荐粒度，具体请参见[aclrtMemGranularityOptions](../datatypes/aclrtMemGranularityOptions.md)。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| granularity | int，内存申请粒度，单位为Byte，当前只支持2M。 |
| ret | int，错误码，返回0表示成功，返回[其它值](../datatypes/aclError.md)表示失败。 |

<!-- npu="310b" id7 -->
## 约束说明

<!-- npu="310b" id8 -->
Atlas 200I/500 A2推理产品上，Ascend RC形态下，不支持调用本接口。
<!-- end id8 -->
<!-- end id7 -->
