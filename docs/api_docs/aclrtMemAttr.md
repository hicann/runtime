# aclrtMemAttr<a name="ZH-CN_TOPIC_0000001699489897"></a>

```
typedef enum aclrtMemAttr {
    ACL_DDR_MEM,             // 大页内存+普通内存
    ACL_HBM_MEM,             // 大页内存+普通内存
    ACL_DDR_MEM_HUGE,        // 大页内存
    ACL_DDR_MEM_NORMAL,      // 普通内存
    ACL_HBM_MEM_HUGE,        // 大页内存，内存申请粒度为2M，不足2M的倍数，向上2M对齐
    ACL_HBM_MEM_NORMAL,      // 普通内存
    ACL_DDR_MEM_P2P_HUGE,    // 用于Device间数据复制的大页内存
    ACL_DDR_MEM_P2P_NORMAL,  // 用于Device间数据复制的普通内存
    ACL_HBM_MEM_P2P_HUGE,    // 用于Device间数据复制的大页内存，内存申请粒度为2M，不足2M的倍数，向上2M对齐
    ACL_HBM_MEM_P2P_NORMAL,  // 用于Device间数据复制的普通内存
    ACL_HBM_MEM_HUGE1G,      // 大页内存，内存申请粒度为1G，不足1G的倍数，向上1G对齐，当前版本不支持该选项
    ACL_HBM_MEM_P2P_HUGE1G   // 用于Device间数据复制的大页内存，内存申请粒度为1G，不足1G的倍数，向上1G对齐，当前版本不支持该选项
} aclrtMemAttr;
```

对于申请大页内存的场景，当内存申请粒度为2M时，如果要申请1G大小的大页内存，会占用1024/2=512个页表，当内存申请粒度为1G时，1G大页内存只占用1个页表，能有效降低页表数量，有效扩大TLB（Translation Lookaside Buffer）缓存的地址范围，从而提升离散访问的性能。TLB是昇腾AI处理器中用于高速缓存的硬件模块，用于存储最近使用的虚拟地址到物理地址的映射。

ACL\_HBM\_MEM\_HUGE1G和ACL\_HBM\_MEM\_P2P\_HUGE1G选项各产品型号的支持情况不同，如下：

-   Ascend 910C，支持该选项。
-   Ascend 910B，支持该选项。

