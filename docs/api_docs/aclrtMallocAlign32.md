# aclrtMallocAlign32

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

在Device上分配size大小的线性内存，并通过\*devPtr返回已分配内存的指针。本接口分配的内存会进行字节对齐，会对用户申请的size向上对齐成32字节整数倍。

与aclrtMalloc接口相比，本接口只会对用户申请的size向上对齐成32字节整数倍，不会再多加32字节。

## 函数原型

```
aclError aclrtMallocAlign32(void **devPtr, size_t size, aclrtMemMallocPolicy policy)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| devPtr | 输出 | “Device上已分配内存的指针”的指针。 |
| size | 输入 | 申请内存的大小，单位Byte。<br>size不能为0。 |
| policy | 输入 | 内存分配规则。<br>若配置的内存分配规则超出[aclrtMemMallocPolicy](aclrtMemMallocPolicy.md)取值范围，size≥2M时，按大页申请内存，否则按普通页申请内存。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

## 约束说明

-   本接口分配的内存不会进行对内容进行初始化。

-   本接口内部不会进行隐式的Device同步或流同步。如果申请内存成功或申请内存失败会立刻返回结果。
-   使用aclrtMallocAlign32接口申请的内存，需要通过[aclrtFree](aclrtFree.md)接口释放内存。
-   频繁调用aclrtMallocAlign32接口申请内存、调用[aclrtFree](aclrtFree.md)接口释放内存，会损耗性能，建议用户提前做内存预先分配或二次管理，避免频繁申请/释放内存。
-   若用户使用本接口申请大块内存并自行划分、管理内存时，每段内存需同时满足以下需求，其中，len表示某段内存的大小，ALIGN\_UP\[len,k\]表示向上按k字节对齐：\(\(len-1\)/k+1\)\*k：
    -   内存大小向上对齐成32整数倍+32字节（m=ALIGN\_UP\[len,32\]+32字节）；
    -   内存起始地址需满足64字节对齐（ALIGN\_UP\[m,64\]）。

