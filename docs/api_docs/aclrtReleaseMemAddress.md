# aclrtReleaseMemAddress

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

释放通过[aclrtReserveMemAddress](aclrtReserveMemAddress.md)接口申请的虚拟内存。

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
aclError aclrtReleaseMemAddress(void *virPtr)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| virPtr | 输入 | 待释放的虚拟内存地址指针。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

## 约束说明

-   若该虚拟内存与物理内存存在映射关系，则释放虚拟内存前，需调用[aclrtUnmapMem](aclrtUnmapMem.md)接口取消该虚拟内存与物理内存的映射。

