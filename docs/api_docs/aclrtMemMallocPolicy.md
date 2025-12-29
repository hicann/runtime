# aclrtMemMallocPolicy

```
typedef enum aclrtMemMallocPolicy {
    ACL_MEM_MALLOC_HUGE_FIRST,
    ACL_MEM_MALLOC_HUGE_ONLY,
    ACL_MEM_MALLOC_NORMAL_ONLY,
    ACL_MEM_MALLOC_HUGE_FIRST_P2P,
    ACL_MEM_MALLOC_HUGE_ONLY_P2P,
    ACL_MEM_MALLOC_NORMAL_ONLY_P2P,
    ACL_MEM_MALLOC_HUGE1G_ONLY, 
    ACL_MEM_MALLOC_HUGE1G_ONLY_P2P,
    ACL_MEM_TYPE_LOW_BAND_WIDTH   = 0x0100U,
    ACL_MEM_TYPE_HIGH_BAND_WIDTH  = 0x1000U,
    ACL_MEM_ACCESS_USER_SPACE_READONLY = 0x100000U,
} aclrtMemMallocPolicy;
```

**此处支持单个枚举项，也支持多个枚举项位或：**

-   **配置单个枚举项**：
    -   若配置ACL\_MEM\_TYPE\_LOW\_BAND\_WIDTH或ACL\_MEM\_TYPE\_HIGH\_BAND\_WIDTH，则系统内部会默认采取ACL\_MEM\_MALLOC\_HUGE\_FIRST，优先申请大页。
    -   若配置除ACL\_MEM\_TYPE\_LOW\_BAND\_WIDTH、ACL\_MEM\_TYPE\_HIGH\_BAND\_WIDTH之外的其它值，则系统内部会根据硬件支持情况选择从高带宽或低带宽物理内存申请内存。

-   **配置多个枚举项位或**：

    支持这三项（ACL\_MEM\_MALLOC\_HUGE\_FIRST、ACL\_MEM\_MALLOC\_HUGE\_ONLY、ACL\_MEM\_MALLOC\_NORMAL\_ONLY）与这两项（ACL\_MEM\_TYPE\_LOW\_BAND\_WIDTH、ACL\_MEM\_TYPE\_HIGH\_BAND\_WIDTH）组合，**例如**：ACL\_MEM\_MALLOC\_HUGE\_FIRST | ACL\_MEM\_TYPE\_HIGH\_BAND\_WIDTH

**表 1**  枚举项说明


| 枚举项 | 说明 |
| --- | --- |
| ACL_MEM_MALLOC_HUGE_FIRST | 申请大页内存，内存申请粒度为2M，不足2M的倍数，向上2M对齐。<br>当申请的内存小于等于1M时，即使使用该内存分配规则，也是申请普通页的内存。当申请的内存大于1M时，优先申请大页内存，如果大页内存不够，则使用普通页的内存。 |
| ACL_MEM_MALLOC_HUGE_ONLY | 申请大页内存，内存申请粒度为2M，不足2M的倍数，向上2M对齐。<br>配置该选项时，表示仅申请大页，如果大页内存不够，则返回错误。 |
| ACL_MEM_MALLOC_NORMAL_ONLY | 仅申请普通页，如果普通页内存不够，则返回错误。 |
| ACL_MEM_MALLOC_HUGE_FIRST_P2P | 两个Device之间内存复制场景下使用该选项申请大页内存，内存申请粒度为2M，不足2M的倍数，向上2M对齐。<br>配置该选项时，表示优先申请大页内存，如果大页内存不够，则使用普通页的内存。<br>Atlas A3 训练系列产品/Atlas A3 推理系列产品，支持该选项。<br>Atlas A2 训练系列产品/Atlas A2 推理系列产品，支持该选项。 |
| ACL_MEM_MALLOC_HUGE_ONLY_P2P | 两个Device之间内存复制场景下使用该选项申请大页内存，内存申请粒度为2M，不足2M的倍数，向上2M对齐。<br>配置该选项时，表示仅申请大页内存，如果大页内存不够，则返回错误。<br>Atlas A3 训练系列产品/Atlas A3 推理系列产品，支持该选项。<br>Atlas A2 训练系列产品/Atlas A2 推理系列产品，支持该选项。 |
| ACL_MEM_MALLOC_NORMAL_ONLY_P2P | 两个Device之间内存复制场景下使用该选项，表示仅申请普通页的内存。<br>Atlas A3 训练系列产品/Atlas A3 推理系列产品，支持该选项。<br>Atlas A2 训练系列产品/Atlas A2 推理系列产品，支持该选项。 |
| ACL_MEM_MALLOC_HUGE1G_ONLY | 申请大页内存，内存申请粒度为1G，不足1G的倍数，向上1G对齐。例如申请1.9G时，按向上对齐的原则，实际会申请2G。<br>配置为该选项时，表示仅申请大页，如果大页内存不够，则返回错误。<br>该选项与ACL_MEM_MALLOC_HUGE_ONLY选项相比，ACL_MEM_MALLOC_HUGE_ONLY的内存申请粒度为2M，如果要申请1G大小的大页内存，会占用1024/2=512个页表，但ACL_MEM_MALLOC_HUGE1G_ONLY的内存申请粒度为1G，1G大页内存只占用1个页表，能有效降低页表数量，有效扩大TLB（Translation Lookaside Buffer）缓存的地址范围，从而提升离散访问的性能。TLB是昇腾AI处理器中用于高速缓存的硬件模块，用于存储最近使用的虚拟地址到物理地址的映射。<br>Atlas A3 训练系列产品/Atlas A3 推理系列产品，支持该选项。<br>Atlas A2 训练系列产品/Atlas A2 推理系列产品，支持该选项。 |
| ACL_MEM_MALLOC_HUGE1G_ONLY_P2P | 两个Device之间内存复制场景下使用该选项申请大页内存，内存申请粒度为1G，不足1G的倍数，向上1G对齐。例如申请1.9G时，按向上对齐的原则，实际会申请2G。<br>配置为该选项时，表示仅申请大页，如果大页内存不够，则返回错误。<br>该选项与ACL_MEM_MALLOC_HUGE_ONLY_P2P选项相比，ACL_MEM_MALLOC_HUGE_ONLY_P2P的内存申请粒度为2M，如果要申请1G大小的大页内存，会占用1024/2=512个页表，但ACL_MEM_MALLOC_HUGE1G_ONLY_P2P的内存申请粒度为1G，1G大页内存只占用1个页表，能有效降低页表数量，有效扩大TLB（Translation Lookaside Buffer）缓存的地址范围，从而提升离散访问的性能。TLB是昇腾AI处理器中用于高速缓存的硬件模块，用于存储最近使用的虚拟地址到物理地址的映射。<br>Atlas A3 训练系列产品/Atlas A3 推理系列产品，支持该选项。<br>Atlas A2 训练系列产品/Atlas A2 推理系列产品，支持该选项。 |
| ACL_MEM_TYPE_LOW_BAND_WIDTH | 从带宽低的物理内存上申请内存。<br>设置该选项无效，系统默认会根据硬件支持的内存类型选择。 |
| ACL_MEM_TYPE_HIGH_BAND_WIDTH | 从带宽高的物理内存上申请内存。<br>设置该选项无效，系统默认会根据硬件支持的内存类型选择。 |
| ACL_MEM_ACCESS_USER_SPACE_READONLY | 用于控制申请的内存在用户态为只读，若在用户态修改此内存都会导致失败。 |

