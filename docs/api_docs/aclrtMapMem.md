# aclrtMapMem<a name="ZH-CN_TOPIC_0000001651123192"></a>

## AI处理器支持情况<a name="section15254644421"></a>

<a name="zh-cn_topic_0000002219420921_table14931115524110"></a>
<table><thead align="left"><tr id="zh-cn_topic_0000002219420921_row1993118556414"><th class="cellrowborder" valign="top" width="57.99999999999999%" id="mcps1.1.3.1.1"><p id="zh-cn_topic_0000002219420921_p29315553419"><a name="zh-cn_topic_0000002219420921_p29315553419"></a><a name="zh-cn_topic_0000002219420921_p29315553419"></a><span id="zh-cn_topic_0000002219420921_ph59311455164119"><a name="zh-cn_topic_0000002219420921_ph59311455164119"></a><a name="zh-cn_topic_0000002219420921_ph59311455164119"></a>AI处理器类型</span></p>
</th>
<th class="cellrowborder" align="center" valign="top" width="42%" id="mcps1.1.3.1.2"><p id="zh-cn_topic_0000002219420921_p59313557417"><a name="zh-cn_topic_0000002219420921_p59313557417"></a><a name="zh-cn_topic_0000002219420921_p59313557417"></a>是否支持</p>
</th>
</tr>
</thead>
<tbody><tr id="zh-cn_topic_0000002219420921_row1693117553411"><td class="cellrowborder" valign="top" width="57.99999999999999%" headers="mcps1.1.3.1.1 "><p id="zh-cn_topic_0000002219420921_p1493195513412"><a name="zh-cn_topic_0000002219420921_p1493195513412"></a><a name="zh-cn_topic_0000002219420921_p1493195513412"></a><span id="zh-cn_topic_0000002219420921_ph1093110555418"><a name="zh-cn_topic_0000002219420921_ph1093110555418"></a><a name="zh-cn_topic_0000002219420921_ph1093110555418"></a><term id="zh-cn_topic_0000002219420921_zh-cn_topic_0000001312391781_term1253731311225"><a name="zh-cn_topic_0000002219420921_zh-cn_topic_0000001312391781_term1253731311225"></a><a name="zh-cn_topic_0000002219420921_zh-cn_topic_0000001312391781_term1253731311225"></a>Ascend 910C</term></span></p>
</td>
<td class="cellrowborder" align="center" valign="top" width="42%" headers="mcps1.1.3.1.2 "><p id="zh-cn_topic_0000002219420921_p20931175524111"><a name="zh-cn_topic_0000002219420921_p20931175524111"></a><a name="zh-cn_topic_0000002219420921_p20931175524111"></a>√</p>
</td>
</tr>
<tr id="zh-cn_topic_0000002219420921_row199312559416"><td class="cellrowborder" valign="top" width="57.99999999999999%" headers="mcps1.1.3.1.1 "><p id="zh-cn_topic_0000002219420921_p0931555144119"><a name="zh-cn_topic_0000002219420921_p0931555144119"></a><a name="zh-cn_topic_0000002219420921_p0931555144119"></a><span id="zh-cn_topic_0000002219420921_ph1693115559411"><a name="zh-cn_topic_0000002219420921_ph1693115559411"></a><a name="zh-cn_topic_0000002219420921_ph1693115559411"></a><term id="zh-cn_topic_0000002219420921_zh-cn_topic_0000001312391781_term11962195213215"><a name="zh-cn_topic_0000002219420921_zh-cn_topic_0000001312391781_term11962195213215"></a><a name="zh-cn_topic_0000002219420921_zh-cn_topic_0000001312391781_term11962195213215"></a>Ascend 910B</term></span></p>
</td>
<td class="cellrowborder" align="center" valign="top" width="42%" headers="mcps1.1.3.1.2 "><p id="zh-cn_topic_0000002219420921_p129321955154117"><a name="zh-cn_topic_0000002219420921_p129321955154117"></a><a name="zh-cn_topic_0000002219420921_p129321955154117"></a>√</p>
</td>
</tr>
</tbody>
</table>

## 功能说明<a name="section36583473819"></a>

将虚拟内存映射到物理内存。

**本接口需与以下其它接口配合使用**，以便申请地址连续的虚拟内存、最大化利用物理内存：

1.  申请虚拟内存（[aclrtReserveMemAddress](aclrtReserveMemAddress.md)接口）；
2.  申请物理内存（[aclrtMallocPhysical](aclrtMallocPhysical.md)接口）；
3.  将虚拟内存映射到物理内存（[aclrtMapMem](aclrtMapMem.md)接口）；
4.  执行任务（调用具体的任务接口）；
5.  取消虚拟内存与物理内存的映射（[aclrtUnmapMem](aclrtUnmapMem.md)接口）；
6.  释放物理内存（[aclrtFreePhysical](aclrtFreePhysical.md)接口）；
7.  释放虚拟内存（[aclrtReleaseMemAddress](aclrtReleaseMemAddress.md)接口）。

## 函数原型<a name="section13230182415108"></a>

```
aclError aclrtMapMem(void *virPtr, size_t size, size_t offset, aclrtDrvMemHandle handle, uint64_t flags)
```

## 参数说明<a name="section75395119104"></a>

<a name="zh-cn_topic_0122830089_table438764393513"></a>
<table><thead align="left"><tr id="zh-cn_topic_0122830089_row53871743113510"><th class="cellrowborder" valign="top" width="14.000000000000002%" id="mcps1.1.4.1.1"><p id="zh-cn_topic_0122830089_p1438834363520"><a name="zh-cn_topic_0122830089_p1438834363520"></a><a name="zh-cn_topic_0122830089_p1438834363520"></a>参数名</p>
</th>
<th class="cellrowborder" valign="top" width="14.000000000000002%" id="mcps1.1.4.1.2"><p id="p1769255516412"><a name="p1769255516412"></a><a name="p1769255516412"></a>输入/输出</p>
</th>
<th class="cellrowborder" valign="top" width="72%" id="mcps1.1.4.1.3"><p id="zh-cn_topic_0122830089_p173881843143514"><a name="zh-cn_topic_0122830089_p173881843143514"></a><a name="zh-cn_topic_0122830089_p173881843143514"></a>说明</p>
</th>
</tr>
</thead>
<tbody><tr id="zh-cn_topic_0122830089_row2038874343514"><td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.1 "><p id="p4579181641514"><a name="p4579181641514"></a><a name="p4579181641514"></a>virPtr</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p783015417719"><a name="p783015417719"></a><a name="p783015417719"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="72%" headers="mcps1.1.4.1.3 "><p id="p1457817167157"><a name="p1457817167157"></a><a name="p1457817167157"></a>待映射的虚拟内存地址指针。</p>
<p id="p01914334367"><a name="p01914334367"></a><a name="p01914334367"></a>这个地址不一定是起始地址，用户也可以根据起始地址自行偏移后，再映射。</p>
</td>
</tr>
<tr id="row1660814462512"><td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.1 "><p id="p19609124617516"><a name="p19609124617516"></a><a name="p19609124617516"></a>size</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p160915469510"><a name="p160915469510"></a><a name="p160915469510"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="72%" headers="mcps1.1.4.1.3 "><p id="p96091846851"><a name="p96091846851"></a><a name="p96091846851"></a>待映射的内存大小，单位Byte。</p>
<p id="p4583183114120"><a name="p4583183114120"></a><a name="p4583183114120"></a>此处的size必须与<a href="aclrtMallocPhysical.md">aclrtMallocPhysical</a>接口的size参数值相同，size必须与<a href="aclrtMemGetAllocationGranularity.md">aclrtMemGetAllocationGranularity</a>接口获取的ACL_RT_MEM_ALLOC_GRANULARITY_MINIMUM对齐。</p>
</td>
</tr>
<tr id="row187221499516"><td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.1 "><p id="p67237494519"><a name="p67237494519"></a><a name="p67237494519"></a>offset</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p97231849555"><a name="p97231849555"></a><a name="p97231849555"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="72%" headers="mcps1.1.4.1.3 "><p id="p167231949557"><a name="p167231949557"></a><a name="p167231949557"></a>物理内存偏移值，当前只能设置为0。</p>
</td>
</tr>
<tr id="row7307528520"><td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.1 "><p id="p5312052954"><a name="p5312052954"></a><a name="p5312052954"></a>handle</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p143135211517"><a name="p143135211517"></a><a name="p143135211517"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="72%" headers="mcps1.1.4.1.3 "><p id="p931145210518"><a name="p931145210518"></a><a name="p931145210518"></a>物理内存信息handle。</p>
<p id="p14764229192912"><a name="p14764229192912"></a><a name="p14764229192912"></a>通过<a href="aclrtReserveMemAddress.md">aclrtReserveMemAddress</a>接口预留出来的一整段虚拟地址，由用户自行管理、划分时，不能同时与两个Device上申请的物理地址绑定。</p>
<p id="p136821520133119"><a name="p136821520133119"></a><a name="p136821520133119"></a>通过<a href="aclrtReserveMemAddress.md">aclrtReserveMemAddress</a>接口预留出来的一整段虚拟地址，由用户自行管理、划分时，不能同时与<a href="aclrtMallocPhysical.md">aclrtMallocPhysical</a>、<a href="aclrtMemImportFromShareableHandle.md">aclrtMemImportFromShareableHandle</a>接口输出的handle绑定。</p>
</td>
</tr>
<tr id="row1987612531356"><td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.1 "><p id="p118761053454"><a name="p118761053454"></a><a name="p118761053454"></a>flags</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p1887675317518"><a name="p1887675317518"></a><a name="p1887675317518"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="72%" headers="mcps1.1.4.1.3 "><p id="p987615533511"><a name="p987615533511"></a><a name="p987615533511"></a>预留，当前只能设置为0。</p>
</td>
</tr>
</tbody>
</table>

## 返回值说明<a name="section25791320141317"></a>

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

