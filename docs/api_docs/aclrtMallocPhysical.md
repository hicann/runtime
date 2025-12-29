# aclrtMallocPhysical

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

申请Host或Device物理内存，并返回一个物理内存handle。

本接口可配合[aclrtReserveMemAddress](aclrtReserveMemAddress.md)接口（申请虚拟内存）、[aclrtMapMem](aclrtMapMem.md)接口（建立虚拟内存与物理内存之间的映射）使用，以便申请地址连续的虚拟内存、最大化利用物理内存。

本接口可配合[aclrtMemExportToShareableHandle](aclrtMemExportToShareableHandle.md)接口（导出物理内存handle）、[aclrtMemImportFromShareableHandle](aclrtMemImportFromShareableHandle.md)（导入共享handle）使用，用于实现多进程之间的物理内存共享。同时，也支持在共享物理内存时，使用虚拟内存，请参见[aclrtMemExportToShareableHandle](aclrtMemExportToShareableHandle.md)接口处的说明。

## 函数原型

```
aclError aclrtMallocPhysical(aclrtDrvMemHandle *handle, size_t size, const aclrtPhysicalMemProp *prop, uint64_t flags)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| handle | 输出 | 存放物理内存信息的handle。 |
| size | 输入 | 物理内存大小，单位Byte。<br>先调用[aclrtMemGetAllocationGranularity](aclrtMemGetAllocationGranularity.md)接口获取内存申请粒度，然后再调用本接口申请物理内存时size按获取到的内存申请粒度对齐，以便节约内存。 |
| prop | 输入 | 物理内存属性信息。 |
| flags | 输入 | 预留，当前只能设置为0。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

## 约束说明

-   当前版本仅支持申请ACL\_HBM\_MEM\_HUGE（2M粒度对齐的大页内存）、ACL\_HBM\_MEM\_HUGE1G（1G粒度对齐的大页内存）、ACL\_HBM\_MEM\_NORMAL（普通页内存）类型的内存。即使传入ACL\_HBM\_MEM\_NORMAL类型，系统内部也会按照ACL\_HBM\_MEM\_HUGE类型申请大页内存。

    各产品型号对ACL\_HBM\_MEM\_HUGE1G选项的支持情况不同，如下：

    -   Atlas A3 训练系列产品/Atlas A3 推理系列产品，支持该选项。
    -   Atlas A2 训练系列产品/Atlas A2 推理系列产品，支持该选项。

