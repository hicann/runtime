# aclrtMemAttr

- ACL\_DDR\_MEM = 0

    DDR内存，DDR上所有大页内存 + 普通内存。

- ACL\_HBM\_MEM = 1

    片上内存，片上内存上所有大页内存 + 普通内存。

- ACL\_DDR\_MEM\_HUGE = 2

    DDR大页内存。

- ACL\_DDR\_MEM\_NORMAL = 3

    DDR普通内存。

- ACL\_HBM\_MEM\_HUGE = 4

    片上内存大页内存。

- ACL\_HBM\_MEM\_NORMAL = 5

    片上内存普通内存。

- ACL\_DDR\_MEM\_P2P\_HUGE = 6

    用于Device间数据复制的大页内存。

- ACL\_DDR\_MEM\_P2P\_NORMAL = 7

    用于Device间数据复制的普通内存。

- ACL\_HBM\_MEM\_P2P\_HUGE = 8

    用于Device间数据复制的大页内存。

- ACL\_HBM\_MEM\_P2P\_NORMAL = 9

    用于Device间数据复制的普通内存。

- ACL\_HBM\_MEM\_HUGE1G = 10

    大页内存，内存申请粒度为1G，不足1G的倍数，向上1G对齐。

- ACL\_HBM\_MEM\_P2P\_HUGE1G = 11

    用于Device间数据复制的大页内存，内存申请粒度为1G，不足1G的倍数，向上1G对齐。

以上选项兼容旧版本，需由用户根据硬件内存（DDR、HBM）选择相应的内存属性选项

以下选项由接口内部根据底层硬件内存自动选择DDR或HBM，用户无需关注硬件细节，建议使用以下选项

- ACL\_MEM\_NORMAL = 12

    普通内存。

- ACL\_MEM\_HUGE = 13

    大页内存，内存申请粒度为2M，不足2M的倍数，向上2M对齐。

- ACL\_MEM\_HUGE1G = 14

    大页内存，内存申请粒度为1G，不足1G的倍数，向上1G对齐。

- ACL\_MEM\_P2P\_NORMAL = 15

    用于Device间数据复制的普通内存。

- ACL\_MEM\_P2P\_HUGE = 16

    用于Device间数据复制的大页内存，内存申请粒度为2M，不足2M的倍数，向上2M对齐。

- ACL\_MEM\_P2P\_HUGE1G = 17

    用于Device间数据复制的大页内存，内存申请粒度为1G，不足1G的倍数，向上1G对齐。

对于申请大页内存的场景，当内存申请粒度为2M时，如果要申请1G大小的大页内存，会占用1024/2=512个页表，当内存申请粒度为1G时，1G大页内存只占用1个页表，能有效降低页表数量，有效扩大TLB（Translation Lookaside Buffer）缓存的地址范围，从而提升离散访问的性能。TLB是AI处理器中用于高速缓存的硬件模块，用于存储最近使用的虚拟地址到物理地址的映射。

<!-- npu="A3,910b" id1 -->
HUGE1G相关选项仅Atlas A3系列产品、Atlas A2系列产品支持。
<!-- end id1 -->
