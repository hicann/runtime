# 函数：malloc\_cached

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

申请Device上的内存，该接口在任何场景下申请的内存都是支持cache缓存。在Device上申请size大小的线性内存，通过**dev\_ptr**返回已分配内存的指针地址。

使用[acl.rt.malloc\_cached](function-malloc_cached.md)接口申请的内存与使用**acl.rt.malloc**接口申请的内存是等价的，都支持cache缓存，不需要用户处理cpu与npu之间的cache一致性。

调用媒体数据处理的接口前，若需要申请Device上的内存存放输入或输出数据，需调用**acl.media.dvpp\_malloc**申请内存。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtMallocCached(void **devPtr, size_t size, aclrtMemMallocPolicy policy)
    ```

- **python函数**

    ```python
    dev_ptr, ret = acl.rt.malloc_cached(size, policy)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| size | int，申请内存的大小，单位Byte。size不能为0。 |
| policy | int，内存分配规则。<br>若配置的内存分配规则超出[aclrtMemMallocPolicy](../datatypes/aclrtMemMallocPolicy.md)取值范围，size≥2M时，按大页申请内存，否则按普通页申请内存 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| dev_ptr | int，指向Device上已分配内存的指针地址。 |
| ret | int，错误码，返回0表示成功，返回[其它值](../datatypes/aclError.md)表示失败。 |

## 约束说明

其它约束与[acl.rt.malloc](../memory/function-malloc.md)接口相同。
