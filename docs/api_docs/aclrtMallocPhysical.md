# aclrtMallocPhysical<a name="ZH-CN_TOPIC_0000001699363469"></a>

## AI处理器支持情况<a name="section8178181118225"></a>

<a name="table38301303189"></a>
<table><thead align="left"><tr id="row20831180131817"><th class="cellrowborder" valign="top" width="57.99999999999999%" id="mcps1.1.3.1.1"><p id="p1883113061818"><a name="p1883113061818"></a><a name="p1883113061818"></a><span id="ph20833205312295"><a name="ph20833205312295"></a><a name="ph20833205312295"></a>AI处理器类型</span></p>
</th>
<th class="cellrowborder" align="center" valign="top" width="42%" id="mcps1.1.3.1.2"><p id="p783113012187"><a name="p783113012187"></a><a name="p783113012187"></a>是否支持</p>
</th>
</tr>
</thead>
<tbody><tr id="row220181016240"><td class="cellrowborder" valign="top" width="57.99999999999999%" headers="mcps1.1.3.1.1 "><p id="p48327011813"><a name="p48327011813"></a><a name="p48327011813"></a><span id="ph583230201815"><a name="ph583230201815"></a><a name="ph583230201815"></a><term id="zh-cn_topic_0000001312391781_term1253731311225"><a name="zh-cn_topic_0000001312391781_term1253731311225"></a><a name="zh-cn_topic_0000001312391781_term1253731311225"></a>Ascend 910C</term></span></p>
</td>
<td class="cellrowborder" align="center" valign="top" width="42%" headers="mcps1.1.3.1.2 "><p id="p7948163910184"><a name="p7948163910184"></a><a name="p7948163910184"></a>√</p>
</td>
</tr>
<tr id="row173226882415"><td class="cellrowborder" valign="top" width="57.99999999999999%" headers="mcps1.1.3.1.1 "><p id="p14832120181815"><a name="p14832120181815"></a><a name="p14832120181815"></a><span id="ph1483216010188"><a name="ph1483216010188"></a><a name="ph1483216010188"></a><term id="zh-cn_topic_0000001312391781_term11962195213215"><a name="zh-cn_topic_0000001312391781_term11962195213215"></a><a name="zh-cn_topic_0000001312391781_term11962195213215"></a>Ascend 910B</term></span></p>
</td>
<td class="cellrowborder" align="center" valign="top" width="42%" headers="mcps1.1.3.1.2 "><p id="p19948143911820"><a name="p19948143911820"></a><a name="p19948143911820"></a>√</p>
</td>
</tr>
</tbody>
</table>

## 功能说明<a name="section36583473819"></a>

申请Host或Device物理内存，并返回一个物理内存handle。

本接口可配合[aclrtReserveMemAddress](aclrtReserveMemAddress.md)接口（申请虚拟内存）、[aclrtMapMem](aclrtMapMem.md)接口（建立虚拟内存与物理内存之间的映射）使用，以便申请地址连续的虚拟内存、最大化利用物理内存。

本接口可配合[aclrtMemExportToShareableHandle](aclrtMemExportToShareableHandle.md)接口（导出物理内存handle）、[aclrtMemImportFromShareableHandle](aclrtMemImportFromShareableHandle.md)（导入共享handle）使用，用于实现多进程之间的物理内存共享。同时，也支持在共享物理内存时，使用虚拟内存，请参见[aclrtMemExportToShareableHandle](aclrtMemExportToShareableHandle.md)接口处的说明。

## 函数原型<a name="section13230182415108"></a>

```
aclError aclrtMallocPhysical(aclrtDrvMemHandle *handle, size_t size, const aclrtPhysicalMemProp *prop, uint64_t flags)
```

## 参数说明<a name="section75395119104"></a>

<a name="zh-cn_topic_0122830089_table438764393513"></a>
<table><thead align="left"><tr id="zh-cn_topic_0122830089_row53871743113510"><th class="cellrowborder" valign="top" width="14.000000000000002%" id="mcps1.1.4.1.1"><p id="zh-cn_topic_0122830089_p1438834363520"><a name="zh-cn_topic_0122830089_p1438834363520"></a><a name="zh-cn_topic_0122830089_p1438834363520"></a>参数名</p>
</th>
<th class="cellrowborder" valign="top" width="13.98%" id="mcps1.1.4.1.2"><p id="p1769255516412"><a name="p1769255516412"></a><a name="p1769255516412"></a>输入/输出</p>
</th>
<th class="cellrowborder" valign="top" width="72.02%" id="mcps1.1.4.1.3"><p id="zh-cn_topic_0122830089_p173881843143514"><a name="zh-cn_topic_0122830089_p173881843143514"></a><a name="zh-cn_topic_0122830089_p173881843143514"></a>说明</p>
</th>
</tr>
</thead>
<tbody><tr id="zh-cn_topic_0122830089_row2038874343514"><td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.1 "><p id="p4579181641514"><a name="p4579181641514"></a><a name="p4579181641514"></a>handle</p>
</td>
<td class="cellrowborder" valign="top" width="13.98%" headers="mcps1.1.4.1.2 "><p id="p357961612153"><a name="p357961612153"></a><a name="p357961612153"></a>输出</p>
</td>
<td class="cellrowborder" valign="top" width="72.02%" headers="mcps1.1.4.1.3 "><p id="p1457817167157"><a name="p1457817167157"></a><a name="p1457817167157"></a>存放物理内存信息的handle。</p>
</td>
</tr>
<tr id="row12323185072416"><td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.1 "><p id="p73232050132419"><a name="p73232050132419"></a><a name="p73232050132419"></a>size</p>
</td>
<td class="cellrowborder" valign="top" width="13.98%" headers="mcps1.1.4.1.2 "><p id="p183238501244"><a name="p183238501244"></a><a name="p183238501244"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="72.02%" headers="mcps1.1.4.1.3 "><p id="p2032313506246"><a name="p2032313506246"></a><a name="p2032313506246"></a>物理内存大小，单位Byte。</p>
<p id="p1471241421720"><a name="p1471241421720"></a><a name="p1471241421720"></a>先调用<a href="aclrtMemGetAllocationGranularity.md">aclrtMemGetAllocationGranularity</a>接口获取内存申请粒度，然后再调用本接口申请物理内存时size按获取到的内存申请粒度对齐，以便节约内存。</p>
</td>
</tr>
<tr id="row59071752202415"><td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.1 "><p id="p490775232416"><a name="p490775232416"></a><a name="p490775232416"></a>prop</p>
</td>
<td class="cellrowborder" valign="top" width="13.98%" headers="mcps1.1.4.1.2 "><p id="p9907452102416"><a name="p9907452102416"></a><a name="p9907452102416"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="72.02%" headers="mcps1.1.4.1.3 "><p id="p15907352132412"><a name="p15907352132412"></a><a name="p15907352132412"></a>物理内存属性信息。</p>
</td>
</tr>
<tr id="row94831199252"><td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.1 "><p id="p17483169102512"><a name="p17483169102512"></a><a name="p17483169102512"></a>flags</p>
</td>
<td class="cellrowborder" valign="top" width="13.98%" headers="mcps1.1.4.1.2 "><p id="p44837917250"><a name="p44837917250"></a><a name="p44837917250"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="72.02%" headers="mcps1.1.4.1.3 "><p id="p104845915259"><a name="p104845915259"></a><a name="p104845915259"></a>预留，当前只能设置为0。</p>
</td>
</tr>
</tbody>
</table>

## 返回值说明<a name="section25791320141317"></a>

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

## 约束说明<a name="section3162183620010"></a>

-   当前版本仅支持申请ACL\_HBM\_MEM\_HUGE（2M粒度对齐的大页内存）、ACL\_HBM\_MEM\_HUGE1G（1G粒度对齐的大页内存）、ACL\_HBM\_MEM\_NORMAL（普通页内存）类型的内存。即使传入ACL\_HBM\_MEM\_NORMAL类型，系统内部也会按照ACL\_HBM\_MEM\_HUGE类型申请大页内存。

    各产品型号对ACL\_HBM\_MEM\_HUGE1G选项的支持情况不同，如下：

    -   Ascend 910C，支持该选项。
    -   Ascend 910B，支持该选项。

