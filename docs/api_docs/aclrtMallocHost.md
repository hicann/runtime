# aclrtMallocHost

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

申请Host内存（该内存是锁页内存），由系统保证内存首地址64字节对齐。

## 函数原型

```
aclError aclrtMallocHost(void **hostPtr, size_t size)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| hostPtr | 输出 | “已分配内存的指针”的指针。 |
| size | 输入 | 申请内存的大小，单位Byte。<br>size不能为0。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

## 约束说明

-   本接口分配的内存不会进行对内容进行初始化，建议在使用内存前先调用[aclrtMemset](aclrtMemset.md)接口先初始化内存，清除内存中的随机数。
-   本接口内部不会进行隐式的device同步或流同步。如果申请内存成功或申请内存失败会立刻返回结果。
-   使用aclrtMallocHost接口申请的内存，需要通过[aclrtFreeHost](aclrtFreeHost.md)接口释放内存。
-   使用aclrtMallocHost接口分配过多的锁页内存，将导致操作系统用于分页的物理内存变少，从而降低系统整体的性能。
-   频繁调用aclrtMallocHost接口申请内存、调用[aclrtFreeHost](aclrtFreeHost.md)接口释放内存，会损耗性能，建议用户提前做内存预先分配或二次管理，避免频繁申请/释放内存。
-   若用户使用本接口申请大块内存并自行划分、管理内存时，每段内存需同时满足以下需求，其中，len表示某段内存的大小，ALIGN\_UP\[len,k\]表示向上按k字节对齐：\(\(len-1\)/k+1\)\*k：
    -   内存大小向上对齐成32整数倍+32字节（m=ALIGN\_UP\[len,32\]+32字节）；
    -   内存起始地址需满足64字节对齐（ALIGN\_UP\[m,64\]）。

