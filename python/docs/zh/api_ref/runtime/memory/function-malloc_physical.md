# 函数：malloc\_physical

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

申请Host或Device物理内存并返回一个物理内存handle。

本接口可配合[acl.rt.reserve\_mem\_address](function-reserve_mem_address.md)接口（申请虚拟内存）、[acl.rt.map\_mem](function-map_mem.md)接口（建立虚拟内存与物理内存之间的映射）使用，以便申请地址连续的虚拟内存、最大化利用物理内存地址的目的。

本接口可配合[acl.rt.mem\_export\_to\_shareable\_handle](function-mem_export_to_shareable_handle.md)接口（导出物理内存handle）、[acl.rt.mem\_import\_from\_shareable\_handle](function-mem_import_from_shareable_handle.md)（导入共享handle）使用，用于实现多进程之间的物理内存共享。同时，也支持在共享物理内存时，使用虚拟内存，请参见[acl.rt.mem\_export\_to\_shareable\_handle](function-mem_export_to_shareable_handle.md)接口处的说明。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtMallocPhysical(aclrtDrvMemHandle *handle, size_t size, const aclrtPhysicalMemProp *prop, uint64_t flags)
    ```

- **python函数**

    ```python
    handle, ret = acl.rt.malloc_physical(size, prop, flags)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| size | int，物理地址空间大小，单位Byte。<br>先调用[acl.rt.mem_get_allocation_granularity](function-mem_get_allocation_granularity.md)接口获取内存申请粒度，然后再调用本接口申请物理内存时size按获取到的内存申请粒度对齐，以便节约内存。 |
| prop | dict，物理内存属性信息，具体请参见[aclrtPhysicalMemProp](../datatypes/aclrtPhysicalMemProp.md)。 |
| flags | int，预留，当前仅支持设置为0。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| handle | int，存放物理内存信息的handle。 |
| ret | int，错误码，返回0表示成功，返回[其它值](../datatypes/aclError.md)表示失败。 |

## 约束说明

<!-- npu="310b" id7 -->
- Atlas 200I/500 A2推理产品上，Ascend RC形态不支持调用本接口。
<!-- end id7 -->

<!-- npu="A3" id8 -->
- 针对Atlas A3系列产品中的超节点产品，当内存所在位置prop\["location"\]\["type"\] = ACL\_MEM\_LOCATION\_TYPE\_HOST\_NUMA，且内存属性类型prop\["memAttr"\]为P2P选项（例如ACL\_MEM\_P2P\_HUGE）时，可申请到的最大内存大小根据服务器型号、Bios版本会有所不同。建议通过acl.rt.malloc\_physical接口按内存规划尝试申请，以确认内存是否足够。
<!-- end id8 -->
- 内存属性类型prop\["memAttr"\]当前仅支持如下选项：
  - ACL\_MEM\_NORMAL：普通内存。
  - ACL\_MEM\_HUGE：2M粒度对齐的大页内存。
  - ACL\_MEM\_HUGE1G：1G粒度对齐的大页内存，仅支持Device。

    <!-- npu="A3,910b" id9 -->
    仅Atlas A3系列产品、Atlas A2系列产品支持该类型。
    <!-- end id9 -->

    其它型号当前不支持该类型。

  - ACL\_MEM\_P2P\_NORMAL：用于Device间数据复制的普通内存。
  - ACL\_MEM\_P2P\_HUGE：用于Device间数据复制的大页内存，内存申请粒度为2M。
  - ACL\_MEM\_P2P\_HUGE1G：用于Device间数据复制的大页内存，内存申请粒度为1G，仅支持Device。

    <!-- npu="A3" id10 -->
    仅Atlas A3系列产品中的部分互联形态支持该类型，以接口实际返回情况为准。
    <!-- end id10 -->

    其它型号当前不支持该类型。

  - ACL\_HBM\_MEM\_HUGE：2M粒度对齐的大页内存。
  - ACL\_HBM\_MEM\_HUGE1G：1G粒度对齐的大页内存，仅支持Device。

    <!-- npu="950,A3,910b" id11 -->
    Ascend 950PR&950DT系列产品、Atlas A3系列产品、Atlas A2系列产品支持该类型。
    <!-- end id11 -->

    其它型号当前不支持该类型。

  - ACL\_HBM\_MEM\_NORMAL：普通内存，接口内部会按照ACL\_HBM\_MEM\_HUGE类型申请大页内存。
  - ACL\_DDR\_MEM\_HUGE：大页内存，仅支持Host内存。
  - ACL\_DDR\_MEM\_NORMAL：普通内存，仅支持Host内存。
  - ACL\_DDR\_MEM\_P2P\_HUGE：用于Device间数据复制的大页内存，仅支持Host内存。
  - ACL\_DDR\_MEM\_P2P\_NORMAL：用于Device间数据复制的普通内存，仅支持Host内存。
