# aclrtReserveMemAddress<a name="ZH-CN_TOPIC_0000001651123184"></a>

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

预留虚拟内存。

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
aclError aclrtReserveMemAddress(void **virPtr, size_t size, size_t alignment, void *expectPtr, uint64_t flags)
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
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p357961612153"><a name="p357961612153"></a><a name="p357961612153"></a>输出</p>
</td>
<td class="cellrowborder" valign="top" width="72%" headers="mcps1.1.4.1.3 "><p id="p1186661412815"><a name="p1186661412815"></a><a name="p1186661412815"></a>“已分配的虚拟内存地址的指针”的指针。</p>
</td>
</tr>
<tr id="row1896314440227"><td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.1 "><p id="p39630442226"><a name="p39630442226"></a><a name="p39630442226"></a>size</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p296394432213"><a name="p296394432213"></a><a name="p296394432213"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="72%" headers="mcps1.1.4.1.3 "><p id="p396344419226"><a name="p396344419226"></a><a name="p396344419226"></a>虚拟内存大小，单位Byte。</p>
<p id="p1142214943212"><a name="p1142214943212"></a><a name="p1142214943212"></a>size不能为0。</p>
</td>
</tr>
<tr id="row19135032212"><td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.1 "><p id="p1993501221"><a name="p1993501221"></a><a name="p1993501221"></a>alignment</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p2092505220"><a name="p2092505220"></a><a name="p2092505220"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="72%" headers="mcps1.1.4.1.3 "><p id="p393504226"><a name="p393504226"></a><a name="p393504226"></a>虚拟地址对齐值，预留，当前只能设置为0。</p>
</td>
</tr>
<tr id="row8951184792211"><td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.1 "><p id="p159511547182212"><a name="p159511547182212"></a><a name="p159511547182212"></a>expectPtr</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p159511747172213"><a name="p159511747172213"></a><a name="p159511747172213"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="72%" headers="mcps1.1.4.1.3 "><p id="p960010539427"><a name="p960010539427"></a><a name="p960010539427"></a>取值说明如下：</p>
<a name="ul5666194114210"></a><a name="ul5666194114210"></a><ul id="ul5666194114210"><li>nullptr：系统自动分配符合对齐规则的虚拟地址。</li><li>非nullptr：指定地址，由用户指定起始地址，但expectPtr必须1GB对齐，否则返回错误码ACL_ERROR_RT_PARAM_INVALID。<p id="p28498544433"><a name="p28498544433"></a><a name="p28498544433"></a>如果指定的起始地址无效或被已被占用，会申请失败，返回错误码ACL_ERROR_RT_MEMORY_ALLOCATION。</p>
</li></ul>
</td>
</tr>
<tr id="row8963110182316"><td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.1 "><p id="p396380182317"><a name="p396380182317"></a><a name="p396380182317"></a>flags</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p179633016239"><a name="p179633016239"></a><a name="p179633016239"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="72%" headers="mcps1.1.4.1.3 "><p id="p13633104717144"><a name="p13633104717144"></a><a name="p13633104717144"></a>大页/普通页标志，此处的标志需与<a href="aclrtMallocPhysical.md">aclrtMallocPhysical</a>接口的内存类型保持一致。</p>
<p id="p1926423291019"><a name="p1926423291019"></a><a name="p1926423291019"></a>参数取值如下：</p>
<a name="ul19746193415102"></a><a name="ul19746193415102"></a><ul id="ul19746193415102"><li>0：普通页</li><li>1：大页</li></ul>
</td>
</tr>
</tbody>
</table>

## 返回值说明<a name="section25791320141317"></a>

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

## 约束说明<a name="section3162183620010"></a>

-   使用本接口预留的虚拟内存，单进程场景下只支持调用[aclrtMemcpyAsync](aclrtMemcpyAsync.md)接口实现两个Device之间的数据拷贝。

