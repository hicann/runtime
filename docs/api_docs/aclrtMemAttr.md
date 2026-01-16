# aclrtMemAttr

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
    ACL_HBM_MEM_P2P_HUGE1G,  // 用于Device间数据复制的大页内存，内存申请粒度为1G，不足1G的倍数，向上1G对齐，当前版本不支持该选项
    /* 以上选项兼容旧版本，需由用户根据硬件内存（DDR、HBM）选择相应的内存属性选项 */
    /* 以下选项由接口内部根据底层硬件内存自动选择DDR或HBM，用户无需关注硬件细节，建议使用以下选项 */
    ACL_MEM_NORMAL,          // 普通内存
    ACL_MEM_HUGE,            // 大页内存，内存申请粒度为2M，不足2M的倍数，向上2M对齐
    ACL_MEM_HUGE1G,          // 大页内存，内存申请粒度为1G，不足1G的倍数，向上1G对齐
    ACL_MEM_P2P_NORMAL,      // 用于Device间数据复制的普通内存
    ACL_MEM_P2P_HUGE,        // 用于Device间数据复制的大页内存，内存申请粒度为2M，不足2M的倍数，向上2M对齐
    ACL_MEM_P2P_HUGE1G,      // 用于Device间数据复制的大页内存，内存申请粒度为1G，不足1G的倍数，向上1G对齐
} aclrtMemAttr;
```

对于申请大页内存的场景，当内存申请粒度为2M时，如果要申请1G大小的大页内存，会占用1024/2=512个页表，当内存申请粒度为1G时，1G大页内存只占用1个页表，能有效降低页表数量，有效扩大TLB（Translation Lookaside Buffer）缓存的地址范围，从而提升离散访问的性能。TLB是AI处理器中用于高速缓存的硬件模块，用于存储最近使用的虚拟地址到物理地址的映射。

HUGE1G相关选项仅支持：Atlas A3 训练系列产品/Atlas A3 推理系列产品，Atlas A2 训练系列产品/Atlas A2 推理系列产品。
