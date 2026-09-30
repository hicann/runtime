# 函数：malloc\_with\_cfg

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

在Device上分配size大小的线性内存，并通过dev\_ptr返回已分配内存的指针。

与[acl.rt.malloc](../memory/function-malloc.md)接口相比，本接口在申请内存时，还可以指定内存相关的配置信息。

使用本接口申请的内存，需要通过[acl.rt.free](../memory/function-free.md)接口释放内存。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtMallocWithCfg(void **devPtr, size_t size, aclrtMemMallocPolicy policy, aclrtMallocConfig *cfg)
    ```

- **python函数**

    ```python
    dev_ptr, ret = acl.rt.malloc_with_cfg(size, policy, cfg)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| size | int，申请内存的大小，单位Byte。size不能为0。 |
| policy | int，内存分配规则。<br>若配置的内存分配规则超出[aclrtMemMallocPolicy](../datatypes/aclrtMemMallocPolicy.md)取值范围，size≥2M时，按大页申请内存，否则按普通页申请内存。 |
| cfg | dict，内存配置信息。不指定配置时，此处可传空字典，具体请参见[aclrtMallocConfig](../datatypes/aclrtMallocConfig.md)。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| devPtr | int，指向Device上已分配内存的指针地址。 |
| ret | int，错误码，返回0表示成功，返回[其它值](../datatypes/aclError.md)表示失败。 |

## 约束说明

policy处支持配置单个枚举项，也支持配置多个枚举项位或。位或时，支持以下3组中枚举项组合，例如ACL\_MEM\_TYPE\_HIGH\_BAND\_WIDTH | ACL\_MEM\_ACCESS\_USER\_SPACE\_READONLY | ACL\_MEM\_MALLOC\_HUGE\_FIRST：

- 用于区分高、低带宽：ACL\_MEM\_TYPE\_LOW\_BAND\_WIDTH、ACL\_MEM\_TYPE\_HIGH\_BAND\_WIDTH
- 用于控制申请的内存在用户态为只读：ACL\_MEM\_ACCESS\_USER\_SPACE\_READONLY
- 剩下其他基础内存分配规则：例如ACL\_MEM\_MALLOC\_HUGE\_FIRST、ACL\_MEM\_MALLOC\_HUGE\_ONLY、ACL\_MEM\_MALLOC\_NORMAL\_ONLY等
