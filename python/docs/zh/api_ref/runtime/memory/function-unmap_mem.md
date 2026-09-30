# 函数：unmap\_mem

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

取消虚拟内存与物理内存之间的映射关系。

**本接口需与以下其它接口配合使用**，以便申请地址连续的虚拟内存、最大化利用物理内存的目的：

1. 申请虚拟内存（[acl.rt.reserve\_mem\_address](function-reserve_mem_address.md)接口）。
2. 申请物理内存（[acl.rt.malloc\_physical](function-malloc_physical.md)接口）。
3. 将虚拟内存映射到物理内存（[acl.rt.map\_mem](function-map_mem.md)接口）。
4. 执行任务（调用具体的任务接口）。
5. 取消虚拟内存与物理内存的映射（[acl.rt.unmap\_mem](function-unmap_mem.md)接口）。
6. 释放物理内存（[acl.rt.free\_physical](function-free_physical.md)接口）。
7. 释放虚拟内存（[acl.rt.release\_mem\_address](function-release_mem_address.md)接口）。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtUnmapMem(void *virPtr)
    ```

- **python函数**

    ```python
    ret = acl.rt.unmap_mem(vir_ptr)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| vir_ptr | int，待取消映射的虚拟地址。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，错误码，返回0表示成功，返回[其它值](../datatypes/aclError.md)表示失败。 |

<!-- npu="310b" id7 -->
## 约束说明

<!-- npu="310b" id8 -->
Atlas 200I/500 A2推理产品上，Ascend RC形态下，不支持调用本接口。
<!-- end id8 -->
<!-- end id7 -->
