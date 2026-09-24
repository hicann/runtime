# 函数：malloc\_align32

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

在Device上分配size大小的线性内存，并通过“dev\_ptr”返回已分配内存的指针。本接口分配的内存会进行字节对齐，会对用户申请的size向上对齐成32字节整数倍。使用本接口申请的内存，需要通过[acl.rt.free](../memory/function-free.md)接口释放内存。

<!-- npu="950" id7 -->
对于Ascend 950PR&950DT系列产品，本接口功能等同于aclrtMalloc接口。
<!-- end id7 -->

<!-- npu="A3,910b,910,310p,310b" id8 -->
对于以下产品型号，与aclrtMalloc接口相比，本接口只会对用户申请的size向上对齐成32字节整数倍，不会再多加32字节。

<!-- npu="A3" id9 -->
- Atlas A3系列产品
<!-- end id9 -->
<!-- npu="910b" id10 -->
- Atlas A2系列产品
<!-- end id10 -->
<!-- npu="310b" id11 -->
- Atlas 200I/500 A2推理产品
<!-- end id11 -->
<!-- npu="310p" id12 -->
- Atlas推理系列产品
<!-- end id12 -->
<!-- npu="910" id13 -->
- Atlas训练系列产品
<!-- end id13 -->

<!-- end id8 -->
## 函数原型

- **C函数原型**

    ```c
    aclError aclrtMallocAlign32(void **devPtr, size_t size, aclrtMemMallocPolicy policy)
    ```

- **python函数**

    ```python
    dev_ptr, ret = acl.rt.malloc_align32(size, policy)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| size | int，申请内存的大小，单位Byte。size不能为0。 |
| policy | int，内存分配规则。<br>若配置的内存分配规则超出[aclrtMemMallocPolicy](../datatypes/aclrtMemMallocPolicy.md)取值范围，size≥2M时，按大页申请内存，否则按普通页申请内存。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| dev_ptr | int，指向Device上已分配内存的指针地址。 |
| ret | int，错误码，返回0表示成功，返回[其它值](../datatypes/aclError.md)表示失败。 |

## 约束说明

- 若涉及媒体数据处理功能，由于媒体数据处理功能对存放输入、输出数据的内存有更高的要求（例如，内存首地址128字节对齐），因此需调用专用的内存申请接口，如下：
  - 调用[媒体数据处理V1]( https://www.hiascend.com/document/detail/zh/CANNCommunityEdition/latest/acce/dvpp/aclpythondevg_01_0220.html)版本的接口对图片进行抠图、缩放等操作时，调用[acl.media.dvpp\_malloc]( https://www.hiascend.com/document/detail/zh/CANNCommunityEdition/latest/acce/dvpp/aclpythondevg_01_0223.html)接口申请内存。
  - 调用[媒体数据处理V2]( https://www.hiascend.com/document/detail/zh/CANNCommunityEdition/latest/acce/dvpp/aclpythondevg_01_0411.html)版本的接口对图片进行抠图、缩放等操作时，调用[acl.himpi.dvpp\_malloc]( https://www.hiascend.com/document/detail/zh/CANNCommunityEdition/latest/acce/dvpp/aclpythondevg_01_0416.html)接口申请内存。

- 本接口分配的内存不会进行对内容进行初始化。

- 本接口内部不会进行隐式的Device同步或流同步。如果申请内存成功或申请内存失败会立刻返回结果。
- policy处仅支持配置单个枚举项，不支持配置多个枚举项位或。
- 针对ACL\_MEM\_MALLOC\_HUGE\_FIRST\_P2P、ACL\_MEM\_MALLOC\_HUGE\_ONLY\_P2P内存分配规则，建议使用[acl.rt.malloc\_with\_cfg](function-malloc_with_cfg.md)接口，否则可能存在性能问题或无法申请到内存。
- 使用acl.rt.malloc\_align32接口申请的内存，需要通过[acl.rt.free](../memory/function-free.md)接口释放内存。
- 频繁调用acl.rt.malloc\_align32接口申请内存、调用[acl.rt.free](../memory/function-free.md)接口释放内存，会损耗性能，建议用户提前做内存预先分配或二次管理，避免频繁申请/释放内存。
- 若用户使用本接口申请大块内存并自行划分、管理内存时，每段内存需同时满足以下需求：

  - 内存大小向上对齐成32整数倍+32字节（m=ALIGN\_UP\[len,32\]+32字节）；
  - 内存起始地址需满足64字节对齐（ALIGN\_UP\[m,64\]）。

    >[!说明]
    >len表示某段内存的大小，ALIGN\_UP\[len,k\]表示向上按k字节对齐：\(\(len-1\)/k+1\)\*k。
