# 函数：malloc\_host

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

应用程序在Host上运行时，调用该接口申请的是Host内存（该内存是锁页内存），由系统保证内存首地址64字节对齐。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtMallocHost(void **hostPtr, size_t size)
    ```

- **python函数**

    ```python
    host_ptr, ret = acl.rt.malloc_host(size)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| size | int，申请内存的大小，单位Byte。size不能为0。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| host_ptr | int，指向Host上已分配内存的指针地址。 |
| ret | int，错误码，返回0表示成功，返回[其它值](../datatypes/aclError.md)表示失败。 |

## 约束说明

- 本接口分配的内存不会对内容进行初始化，建议在使用内存前先调用[acl.rt.memset](function-memset.md)接口先初始化内存，清除内存中的随机数。
- 本接口内部不会进行隐式的Device同步或流同步。如果申请内存成功或申请内存失败会立刻返回结果。
- 使用acl.rt.malloc\_host接口申请的内存，需要通过[acl.rt.free\_host](function-free_host.md)接口释放内存。
- 使用acl.rt.malloc\_host接口分配过多的锁页内存，将导致操作系统用于分页的物理内存变少，从而降低系统整体的性能。
- 频繁调用acl.rt.malloc\_host接口申请内存、调用[acl.rt.free\_host](function-free_host.md)接口释放内存，会损耗性能，建议用户提前做内存预先分配或二次管理，避免频繁申请/释放内存。
<!-- npu="310p" id7 -->
- 针对Ascend RC形态、Control CPU开放形态，Host与Device是合一的，所以申请Host内存也等同于申请Device内存。此外，申请内存时，按普通页申请。如果需要64字节对齐的首地址，用户需自行处理对齐问题。
<!-- end id7 -->
<!-- npu="310p" id8 -->
- 针对Ascend RC形态和Control CPU开放形态，若用户使用本接口申请大块内存并自行划分、管理内存时，每段内存需同时满足以下需求，其中，len表示某段内存的大小，ALIGN\_UP\[len,k\]表示向上按k字节对齐：\(\(len-1\)/k+1\)\*k：
  - 内存大小向上对齐成32整数倍加32字节（m = ALIGN\_UP\[len, 32\] + 32字节）。
  - 内存起始地址需满足64字节对齐（ALIGN\_UP\[m, 64\]）。
<!-- end id8 -->
