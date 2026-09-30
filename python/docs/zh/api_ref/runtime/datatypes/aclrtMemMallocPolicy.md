# aclrtMemMallocPolicy

**此处支持单个枚举项，也支持多个枚举项位或：**

- **配置单个枚举项**：

    若配置除ACL\_MEM\_TYPE\_LOW\_BAND\_WIDTH、ACL\_MEM\_TYPE\_HIGH\_BAND\_WIDTH之外的其它值，系统内部会根据硬件支持情况选择从高带宽或低带宽物理内存申请内存：

  - ACL\_MEM\_MALLOC\_HUGE\_FIRST
  - ACL\_MEM\_MALLOC\_HUGE\_ONLY
  - ACL\_MEM\_MALLOC\_NORMAL\_ONLY
  - ACL\_MEM\_MALLOC\_HUGE\_FIRST\_P2P
  - ACL\_MEM\_MALLOC\_HUGE\_ONLY\_P2P
  - ACL\_MEM\_MALLOC\_NORMAL\_ONLY\_P2P
  - ACL\_MEM\_MALLOC\_HUGE1G\_ONLY
  - ACL\_MEM\_MALLOC\_HUGE1G\_ONLY\_P2P
  - ACL\_MEM\_TYPE\_LOW\_BAND\_WIDTH   = 0x0100
  - ACL\_MEM\_TYPE\_HIGH\_BAND\_WIDTH  = 0x1000
  - ACL\_MEM\_ACCESS\_USER\_SPACE\_READONLY = 0x100000

    若配置ACL\_MEM\_TYPE\_LOW\_BAND\_WIDTH或ACL\_MEM\_TYPE\_HIGH\_BAND\_WIDTH，则系统内部会默认采取ACL\_MEM\_MALLOC\_HUGE\_FIRST，优先申请大页。

- **配置多个枚举项位或**：

    支持以下两组各选一项组合配置（例如：ACL\_MEM\_MALLOC\_HUGE\_FIRST | ACL\_MEM\_TYPE\_HIGH\_BAND\_WIDTH）

  - ACL\_MEM\_MALLOC\_HUGE\_FIRST、ACL\_MEM\_MALLOC\_HUGE\_ONLY、ACL\_MEM\_MALLOC\_NORMAL\_ONLY
  - ACL\_MEM\_TYPE\_LOW\_BAND\_WIDTH、ACL\_MEM\_TYPE\_HIGH\_BAND\_WIDTH

**枚举项说明如下：**

- ACL\_MEM\_MALLOC\_HUGE\_FIRST = 0

    当申请的内存小于等于1M时，即使使用该内存分配规则，也是申请普通页的内存。当申请的内存大于1M时，优先申请大页内存，如果大页内存不够，则使用普通页的内存。

- ACL\_MEM\_MALLOC\_HUGE\_ONLY =1

    仅申请大页，如果大页内存不够，则返回错误。

- ACL\_MEM\_MALLOC\_NORMAL\_ONLY = 2

    仅申请普通页，如果普通页内存不够，则返回错误。

- ACL\_MEM\_MALLOC\_HUGE\_FIRST\_P2P = 3

    仅Device之间内存复制场景下申请内存时使用该选项，表示优先申请大页内存，如果大页内存不够，则使用普通页的内存。

    <!-- npu="310b" id1 -->
    Atlas 200I/500 A2推理产品，当前版本不支持该选项。
    <!-- end id1 -->

- ACL\_MEM\_MALLOC\_HUGE\_ONLY\_P2P = 4

    仅Device之间内存复制场景下申请内存时使用该选项，仅申请大页内存，如果大页内存不够，则返回错误。

    <!-- npu="310b" id2 -->
    Atlas 200I/500 A2推理产品，当前版本不支持该选项。
    <!-- end id2 -->

- ACL\_MEM\_MALLOC\_NORMAL\_ONLY\_P2P= 5

    仅Device之间内存复制场景下申请内存时使用该选项，仅申请普通页的内存。

    <!-- npu="310b" id3 -->
    Atlas 200I/500 A2推理产品，当前版本不支持该选项。
    <!-- end id3 -->

- ACL\_MEM\_TYPE\_LOW\_BAND\_WIDTH = 6

    从带宽高的物理内存上申请内存。

    <!-- npu="310b" id4 -->
    Atlas 200I/500 A2推理产品，设置该选项无效，系统默认会根据硬件支持的内存类型选择。
    <!-- end id4 -->

- ACL\_MEM\_TYPE\_HIGH\_BAND\_WIDTH = 7

    从带宽低的物理内存上申请内存。

    <!-- npu="310b" id5 -->
    Atlas 200I/500 A2推理产品，设置该选项无效，系统默认会根据硬件支持的内存类型选择。
    <!-- end id5 -->

- ACL\_MEM\_MALLOC\_HUGE1G\_ONLY = 8

    申请大页内存，内存申请粒度为1G，不足1G的倍数，向上1G对齐。例如申请1.9G时，按向上对齐的原则，实际会申请2G。

    配置为该选项时，表示仅申请1G大页，如果1G大页内存不够，则返回错误。由于1G大页资源有限，可尝试使用ACL\_MEM\_MALLOC\_HUGE\_FIRST选项申请大页内存。

    该选项与ACL\_MEM\_MALLOC\_HUGE\_ONLY选项相比，ACL\_MEM\_MALLOC\_HUGE\_ONLY的内存申请粒度为2M，如果要申请1G大小的大页内存，会占用1024/2=512个页表，但ACL\_MEM\_MALLOC\_HUGE1G\_ONLY的内存申请粒度为1G，1G大页内存只占用1个页表，能有效降低页表数量，有效扩大TLB（Translation Lookaside Buffer）缓存的地址范围，从而提升离散访问的性能。TLB是AI处理器中用于高速缓存的硬件模块，用于存储最近使用的虚拟地址到物理地址的映射。

    <!-- npu="910,310p,310b" id6 -->
    Atlas 200I/500 A2推理产品、Atlas推理系列产品、Atlas训练系列产品，不支持该选项。
    <!-- end id6 -->

- ACL\_MEM\_MALLOC\_HUGE1G\_ONLY\_P2P = 9

    仅两个Device之间内存复制场景下使用该选项申请大页内存，内存申请粒度为1G，不足1G的倍数，向上1G对齐。例如申请1.9G时，按向上对齐的原则，实际会申请2G。

    配置为该选项时，表示仅1G申请大页，如果1G大页内存不够，则返回错误。由于1G大页资源有限，可尝试使用ACL\_MEM\_MALLOC\_HUGE\_FIRST\_P2P选项申请大页内存。

    该选项与ACL\_MEM\_MALLOC\_HUGE\_ONLY\_P2P选项相比，ACL\_MEM\_MALLOC\_HUGE\_ONLY\_P2P的内存申请粒度为2M，如果要申请1G大小的大页内存，会占用1024/2=512个页表，但ACL\_MEM\_MALLOC\_HUGE1G\_ONLY\_P2P的内存申请粒度为1G，1G大页内存只占用1个页表，能有效降低页表数量，有效扩大TLB（Translation Lookaside Buffer）缓存的地址范围，从而提升离散访问的性能。TLB是AI处理器中用于高速缓存的硬件模块，用于存储最近使用的虚拟地址到物理地址的映射。

    <!-- npu="910,310p,310b" id7 -->
    Atlas 200I/500 A2推理产品、Atlas推理系列产品、Atlas训练系列产品，不支持该选项。
    <!-- end id7 -->

- ACL\_MEM\_ACCESS\_USER\_SPACE\_READONLY = 10

    用于控制申请的内存在用户态为只读，若在用户态修改此内存都会导致失败。
