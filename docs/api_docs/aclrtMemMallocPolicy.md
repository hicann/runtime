# aclrtMemMallocPolicy<a name="ZH-CN_TOPIC_0000001571914024"></a>

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

<a name="table154428882117"></a>
<table><thead align="left"><tr id="row15442178172115"><th class="cellrowborder" valign="top" width="37.169999999999995%" id="mcps1.2.3.1.1"><p id="p10442188112114"><a name="p10442188112114"></a><a name="p10442188112114"></a>枚举项</p>
</th>
<th class="cellrowborder" valign="top" width="62.83%" id="mcps1.2.3.1.2"><p id="p84426814219"><a name="p84426814219"></a><a name="p84426814219"></a>说明</p>
</th>
</tr>
</thead>
<tbody><tr id="row134425813216"><td class="cellrowborder" valign="top" width="37.169999999999995%" headers="mcps1.2.3.1.1 "><p id="p5215143820613"><a name="p5215143820613"></a><a name="p5215143820613"></a>ACL_MEM_MALLOC_HUGE_FIRST</p>
</td>
<td class="cellrowborder" valign="top" width="62.83%" headers="mcps1.2.3.1.2 "><p id="p1655182531410"><a name="p1655182531410"></a><a name="p1655182531410"></a>申请大页内存，内存申请粒度为2M，不足2M的倍数，向上2M对齐。</p>
<p id="p127390121487"><a name="p127390121487"></a><a name="p127390121487"></a>当申请的内存小于等于1M时，即使使用该内存分配规则，也是申请普通页的内存。当申请的内存大于1M时，优先申请大页内存，如果大页内存不够，则使用普通页的内存。</p>
<p id="p143332043765"><a name="p143332043765"></a><a name="p143332043765"></a></p>
</td>
</tr>
<tr id="row444313892114"><td class="cellrowborder" valign="top" width="37.169999999999995%" headers="mcps1.2.3.1.1 "><p id="p102065381266"><a name="p102065381266"></a><a name="p102065381266"></a>ACL_MEM_MALLOC_HUGE_ONLY</p>
</td>
<td class="cellrowborder" valign="top" width="62.83%" headers="mcps1.2.3.1.2 "><p id="p11460184512189"><a name="p11460184512189"></a><a name="p11460184512189"></a>申请大页内存，内存申请粒度为2M，不足2M的倍数，向上2M对齐。</p>
<p id="p29595528817"><a name="p29595528817"></a><a name="p29595528817"></a>配置该选项时，表示仅申请大页，如果大页内存不够，则返回错误。</p>
<p id="p62059383615"><a name="p62059383615"></a><a name="p62059383615"></a></p>
</td>
</tr>
<tr id="row1144315862113"><td class="cellrowborder" valign="top" width="37.169999999999995%" headers="mcps1.2.3.1.1 "><p id="p1920410389614"><a name="p1920410389614"></a><a name="p1920410389614"></a>ACL_MEM_MALLOC_NORMAL_ONLY</p>
</td>
<td class="cellrowborder" valign="top" width="62.83%" headers="mcps1.2.3.1.2 "><p id="p1420223814612"><a name="p1420223814612"></a><a name="p1420223814612"></a>仅申请普通页，如果普通页内存不够，则返回错误。</p>
</td>
</tr>
<tr id="row6443168192118"><td class="cellrowborder" valign="top" width="37.169999999999995%" headers="mcps1.2.3.1.1 "><p id="p35625331563"><a name="p35625331563"></a><a name="p35625331563"></a>ACL_MEM_MALLOC_HUGE_FIRST_P2P</p>
</td>
<td class="cellrowborder" valign="top" width="62.83%" headers="mcps1.2.3.1.2 "><p id="p794117421915"><a name="p794117421915"></a><a name="p794117421915"></a>两个Device之间内存复制场景下使用该选项申请大页内存，内存申请粒度为2M，不足2M的倍数，向上2M对齐。</p>
<p id="p45010332911"><a name="p45010332911"></a><a name="p45010332911"></a>配置该选项时，表示优先申请大页内存，如果大页内存不够，则使用普通页的内存。</p>
<p id="p181751227105518"><a name="p181751227105518"></a><a name="p181751227105518"></a><span id="ph117562720556"><a name="ph117562720556"></a><a name="ph117562720556"></a><term id="zh-cn_topic_0000001312391781_term1253731311225"><a name="zh-cn_topic_0000001312391781_term1253731311225"></a><a name="zh-cn_topic_0000001312391781_term1253731311225"></a>Ascend 910C</term></span>，支持该选项。</p>
<p id="p8175132705512"><a name="p8175132705512"></a><a name="p8175132705512"></a><span id="ph11175122717551"><a name="ph11175122717551"></a><a name="ph11175122717551"></a><term id="zh-cn_topic_0000001312391781_term11962195213215"><a name="zh-cn_topic_0000001312391781_term11962195213215"></a><a name="zh-cn_topic_0000001312391781_term11962195213215"></a>Ascend 910B</term></span>，支持该选项。</p>
<p id="p5320637391"><a name="p5320637391"></a><a name="p5320637391"></a></p>
</td>
</tr>
<tr id="row74431810213"><td class="cellrowborder" valign="top" width="37.169999999999995%" headers="mcps1.2.3.1.1 "><p id="p956014337618"><a name="p956014337618"></a><a name="p956014337618"></a>ACL_MEM_MALLOC_HUGE_ONLY_P2P</p>
</td>
<td class="cellrowborder" valign="top" width="62.83%" headers="mcps1.2.3.1.2 "><p id="p1360492514190"><a name="p1360492514190"></a><a name="p1360492514190"></a>两个Device之间内存复制场景下使用该选项申请大页内存，内存申请粒度为2M，不足2M的倍数，向上2M对齐。</p>
<p id="p443073101013"><a name="p443073101013"></a><a name="p443073101013"></a>配置该选项时，表示仅申请大页内存，如果大页内存不够，则返回错误。</p>
<p id="p339261372919"><a name="p339261372919"></a><a name="p339261372919"></a><span id="ph203921813142914"><a name="ph203921813142914"></a><a name="ph203921813142914"></a><term id="zh-cn_topic_0000001312391781_term1253731311225_1"><a name="zh-cn_topic_0000001312391781_term1253731311225_1"></a><a name="zh-cn_topic_0000001312391781_term1253731311225_1"></a>Ascend 910C</term></span>，支持该选项。</p>
<p id="p6392191311297"><a name="p6392191311297"></a><a name="p6392191311297"></a><span id="ph9392191362913"><a name="ph9392191362913"></a><a name="ph9392191362913"></a><term id="zh-cn_topic_0000001312391781_term11962195213215_1"><a name="zh-cn_topic_0000001312391781_term11962195213215_1"></a><a name="zh-cn_topic_0000001312391781_term11962195213215_1"></a>Ascend 910B</term></span>，支持该选项。</p>
<p id="p123933134294"><a name="p123933134294"></a><a name="p123933134294"></a></p>
</td>
</tr>
<tr id="row84434816215"><td class="cellrowborder" valign="top" width="37.169999999999995%" headers="mcps1.2.3.1.1 "><p id="p15559193317611"><a name="p15559193317611"></a><a name="p15559193317611"></a>ACL_MEM_MALLOC_NORMAL_ONLY_P2P</p>
</td>
<td class="cellrowborder" valign="top" width="62.83%" headers="mcps1.2.3.1.2 "><p id="p19151102361018"><a name="p19151102361018"></a><a name="p19151102361018"></a>两个Device之间内存复制场景下使用该选项，表示仅申请普通页的内存。</p>
<p id="p146011522132920"><a name="p146011522132920"></a><a name="p146011522132920"></a><span id="ph10601192252913"><a name="ph10601192252913"></a><a name="ph10601192252913"></a><term id="zh-cn_topic_0000001312391781_term1253731311225_2"><a name="zh-cn_topic_0000001312391781_term1253731311225_2"></a><a name="zh-cn_topic_0000001312391781_term1253731311225_2"></a>Ascend 910C</term></span>，支持该选项。</p>
<p id="p14601122192913"><a name="p14601122192913"></a><a name="p14601122192913"></a><span id="ph8601422102911"><a name="ph8601422102911"></a><a name="ph8601422102911"></a><term id="zh-cn_topic_0000001312391781_term11962195213215_2"><a name="zh-cn_topic_0000001312391781_term11962195213215_2"></a><a name="zh-cn_topic_0000001312391781_term11962195213215_2"></a>Ascend 910B</term></span>，支持该选项。</p>
<p id="p1560142292918"><a name="p1560142292918"></a><a name="p1560142292918"></a></p>
</td>
</tr>
<tr id="row2851143023616"><td class="cellrowborder" valign="top" width="37.169999999999995%" headers="mcps1.2.3.1.1 "><p id="p1460091716551"><a name="p1460091716551"></a><a name="p1460091716551"></a>ACL_MEM_MALLOC_HUGE1G_ONLY</p>
</td>
<td class="cellrowborder" valign="top" width="62.83%" headers="mcps1.2.3.1.2 "><p id="p19191119424"><a name="p19191119424"></a><a name="p19191119424"></a>申请大页内存，内存申请粒度为1G，不足1G的倍数，向上1G对齐。例如申请1.9G时，按向上对齐的原则，实际会申请2G。</p>
<p id="p15164718206"><a name="p15164718206"></a><a name="p15164718206"></a>配置为该选项时，表示仅申请大页，如果大页内存不够，则返回错误。</p>
<p id="p14424264205"><a name="p14424264205"></a><a name="p14424264205"></a>该选项与ACL_MEM_MALLOC_HUGE_ONLY选项相比，ACL_MEM_MALLOC_HUGE_ONLY的内存申请粒度为2M，如果要申请1G大小的大页内存，会占用1024/2=512个页表，但ACL_MEM_MALLOC_HUGE1G_ONLY的内存申请粒度为1G，1G大页内存只占用1个页表，能有效降低页表数量，有效扩大TLB（Translation Lookaside Buffer）缓存的地址范围，从而提升离散访问的性能。TLB是<span id="ph1555712386204"><a name="ph1555712386204"></a><a name="ph1555712386204"></a>昇腾AI处理器</span>中用于高速缓存的硬件模块，用于存储最近使用的虚拟地址到物理地址的映射。</p>
<p id="p47471033115215"><a name="p47471033115215"></a><a name="p47471033115215"></a><span id="ph583230201815"><a name="ph583230201815"></a><a name="ph583230201815"></a><term id="zh-cn_topic_0000001312391781_term1253731311225_3"><a name="zh-cn_topic_0000001312391781_term1253731311225_3"></a><a name="zh-cn_topic_0000001312391781_term1253731311225_3"></a>Ascend 910C</term></span>，支持该选项。</p>
<p id="p13961415135217"><a name="p13961415135217"></a><a name="p13961415135217"></a><span id="ph1483216010188"><a name="ph1483216010188"></a><a name="ph1483216010188"></a><term id="zh-cn_topic_0000001312391781_term11962195213215_3"><a name="zh-cn_topic_0000001312391781_term11962195213215_3"></a><a name="zh-cn_topic_0000001312391781_term11962195213215_3"></a>Ascend 910B</term></span>，支持该选项。</p>
<p id="p874416222518"><a name="p874416222518"></a><a name="p874416222518"></a></p>
</td>
</tr>
<tr id="row77323329368"><td class="cellrowborder" valign="top" width="37.169999999999995%" headers="mcps1.2.3.1.1 "><p id="p4555132185513"><a name="p4555132185513"></a><a name="p4555132185513"></a>ACL_MEM_MALLOC_HUGE1G_ONLY_P2P</p>
</td>
<td class="cellrowborder" valign="top" width="62.83%" headers="mcps1.2.3.1.2 "><p id="p0176122920428"><a name="p0176122920428"></a><a name="p0176122920428"></a>两个Device之间内存复制场景下使用该选项申请大页内存，内存申请粒度为1G，不足1G的倍数，向上1G对齐。例如申请1.9G时，按向上对齐的原则，实际会申请2G。</p>
<p id="p49641647173214"><a name="p49641647173214"></a><a name="p49641647173214"></a>配置为该选项时，表示仅申请大页，如果大页内存不够，则返回错误。</p>
<p id="p841854219188"><a name="p841854219188"></a><a name="p841854219188"></a>该选项与ACL_MEM_MALLOC_HUGE_ONLY_P2P选项相比，ACL_MEM_MALLOC_HUGE_ONLY_P2P的内存申请粒度为2M，如果要申请1G大小的大页内存，会占用1024/2=512个页表，但ACL_MEM_MALLOC_HUGE1G_ONLY_P2P的内存申请粒度为1G，1G大页内存只占用1个页表，能有效降低页表数量，有效扩大TLB（Translation Lookaside Buffer）缓存的地址范围，从而提升离散访问的性能。TLB是<span id="ph0620105442119"><a name="ph0620105442119"></a><a name="ph0620105442119"></a>昇腾AI处理器</span>中用于高速缓存的硬件模块，用于存储最近使用的虚拟地址到物理地址的映射。</p>
<p id="p195551747183020"><a name="p195551747183020"></a><a name="p195551747183020"></a><span id="ph195554476303"><a name="ph195554476303"></a><a name="ph195554476303"></a><term id="zh-cn_topic_0000001312391781_term1253731311225_4"><a name="zh-cn_topic_0000001312391781_term1253731311225_4"></a><a name="zh-cn_topic_0000001312391781_term1253731311225_4"></a>Ascend 910C</term></span>，支持该选项。</p>
<p id="p11555144723014"><a name="p11555144723014"></a><a name="p11555144723014"></a><span id="ph185551247113010"><a name="ph185551247113010"></a><a name="ph185551247113010"></a><term id="zh-cn_topic_0000001312391781_term11962195213215_4"><a name="zh-cn_topic_0000001312391781_term11962195213215_4"></a><a name="zh-cn_topic_0000001312391781_term11962195213215_4"></a>Ascend 910B</term></span>，支持该选项。</p>
<p id="p135562479303"><a name="p135562479303"></a><a name="p135562479303"></a></p>
</td>
</tr>
<tr id="row18255111316223"><td class="cellrowborder" valign="top" width="37.169999999999995%" headers="mcps1.2.3.1.1 "><p id="p25578332065"><a name="p25578332065"></a><a name="p25578332065"></a>ACL_MEM_TYPE_LOW_BAND_WIDTH</p>
</td>
<td class="cellrowborder" valign="top" width="62.83%" headers="mcps1.2.3.1.2 "><p id="p205551433262"><a name="p205551433262"></a><a name="p205551433262"></a>从带宽低的物理内存上申请内存。</p>
<p id="p13246152881314"><a name="p13246152881314"></a><a name="p13246152881314"></a>设置该选项无效，系统默认会根据硬件支持的内存类型选择。</p>
</td>
</tr>
<tr id="row17511517112220"><td class="cellrowborder" valign="top" width="37.169999999999995%" headers="mcps1.2.3.1.1 "><p id="p78343160616"><a name="p78343160616"></a><a name="p78343160616"></a>ACL_MEM_TYPE_HIGH_BAND_WIDTH</p>
</td>
<td class="cellrowborder" valign="top" width="62.83%" headers="mcps1.2.3.1.2 "><p id="p1683311166619"><a name="p1683311166619"></a><a name="p1683311166619"></a>从带宽高的物理内存上申请内存。</p>
<p id="p32263326382"><a name="p32263326382"></a><a name="p32263326382"></a>设置该选项无效，系统默认会根据硬件支持的内存类型选择。</p>
</td>
</tr>
<tr id="row19556143318579"><td class="cellrowborder" valign="top" width="37.169999999999995%" headers="mcps1.2.3.1.1 "><p id="p6556633165715"><a name="p6556633165715"></a><a name="p6556633165715"></a>ACL_MEM_ACCESS_USER_SPACE_READONLY</p>
</td>
<td class="cellrowborder" valign="top" width="62.83%" headers="mcps1.2.3.1.2 "><p id="p1799110451107"><a name="p1799110451107"></a><a name="p1799110451107"></a>用于控制申请的内存在用户态为只读，若在用户态修改此内存都会导致失败。</p>
</td>
</tr>
</tbody>
</table>

