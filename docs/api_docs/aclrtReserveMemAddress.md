# aclrtReserveMemAddress

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

预留虚拟内存。

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
aclError aclrtReserveMemAddress(void **virPtr, size_t size, size_t alignment, void *expectPtr, uint64_t flags)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| virPtr | 输出 | “已分配的虚拟内存地址的指针”的指针。 |
| size | 输入 | 虚拟内存大小，单位Byte。<br>size不能为0。 |
| alignment | 输入 | 虚拟地址对齐值，预留，当前只能设置为0。 |
| expectPtr | 输入 | 指定期望返回的虚拟内存起始地址。<br>取值说明如下：<br><br>  - nullptr：系统自动分配符合对齐规则的虚拟地址。<br>  - 非nullptr：指定地址，由用户指定起始地址，但expectPtr必须1GB对齐，否则返回错误码ACL_ERROR_RT_PARAM_INVALID。如果指定的起始地址无效或被已被占用，会申请失败，返回错误码ACL_ERROR_RT_MEMORY_ALLOCATION。 |
| flags | 输入 | 大页/普通页标志，此处的标志需与[aclrtMallocPhysical](aclrtMallocPhysical.md)接口的内存类型保持一致。<br>参数取值如下：<br><br>  - 0：普通页<br>  - 1：大页 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

## 约束说明

-   使用本接口预留的虚拟内存，单进程场景下只支持调用[aclrtMemcpyAsync](aclrtMemcpyAsync.md)接口实现两个Device之间的数据拷贝。

