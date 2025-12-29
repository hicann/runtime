# aclrtMapMem

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

将虚拟内存映射到物理内存。

**本接口需与以下其它接口配合使用**，以便申请地址连续的虚拟内存、最大化利用物理内存：

1.  申请虚拟内存（[aclrtReserveMemAddress](aclrtReserveMemAddress.md)接口）；
2.  申请物理内存（[aclrtMallocPhysical](aclrtMallocPhysical.md)接口）；
3.  将虚拟内存映射到物理内存（[aclrtMapMem](aclrtMapMem.md)接口）；
4.  执行任务（调用具体的任务接口）；
5.  取消虚拟内存与物理内存的映射（[aclrtUnmapMem](aclrtUnmapMem.md)接口）；
6.  释放物理内存（[aclrtFreePhysical](aclrtFreePhysical.md)接口）；
7.  释放虚拟内存（[aclrtReleaseMemAddress](aclrtReleaseMemAddress.md)接口）。

## 函数原型

```
aclError aclrtMapMem(void *virPtr, size_t size, size_t offset, aclrtDrvMemHandle handle, uint64_t flags)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| virPtr | 输入 | 待映射的虚拟内存地址指针。<br>这个地址不一定是起始地址，用户也可以根据起始地址自行偏移后，再映射。 |
| size | 输入 | 待映射的内存大小，单位Byte。<br>此处的size必须与[aclrtMallocPhysical](aclrtMallocPhysical.md)接口的size参数值相同，size必须与[aclrtMemGetAllocationGranularity](aclrtMemGetAllocationGranularity.md)接口获取的ACL_RT_MEM_ALLOC_GRANULARITY_MINIMUM对齐。 |
| offset | 输入 | 物理内存偏移值，当前只能设置为0。 |
| handle | 输入 | 物理内存信息handle。<br>通过[aclrtReserveMemAddress](aclrtReserveMemAddress.md)接口预留出来的一整段虚拟地址，由用户自行管理、划分时，不能同时与两个Device上申请的物理地址绑定。<br>通过[aclrtReserveMemAddress](aclrtReserveMemAddress.md)接口预留出来的一整段虚拟地址，由用户自行管理、划分时，不能同时与[aclrtMallocPhysical](aclrtMallocPhysical.md)、[aclrtMemImportFromShareableHandle](aclrtMemImportFromShareableHandle.md)接口输出的handle绑定。 |
| flags | 输入 | 预留，当前只能设置为0。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

