# aclrtSetMemcpyDesc<a name="ZH-CN_TOPIC_0000002235745173"></a>

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
<td class="cellrowborder" align="center" valign="top" width="42%" headers="mcps1.1.3.1.2 "><p id="p15865172803914"><a name="p15865172803914"></a><a name="p15865172803914"></a>√</p>
</td>
</tr>
<tr id="row173226882415"><td class="cellrowborder" valign="top" width="57.99999999999999%" headers="mcps1.1.3.1.1 "><p id="p14832120181815"><a name="p14832120181815"></a><a name="p14832120181815"></a><span id="ph1483216010188"><a name="ph1483216010188"></a><a name="ph1483216010188"></a><term id="zh-cn_topic_0000001312391781_term11962195213215"><a name="zh-cn_topic_0000001312391781_term11962195213215"></a><a name="zh-cn_topic_0000001312391781_term11962195213215"></a>Ascend 910B</term></span></p>
</td>
<td class="cellrowborder" align="center" valign="top" width="42%" headers="mcps1.1.3.1.2 "><p id="p1486542815394"><a name="p1486542815394"></a><a name="p1486542815394"></a>√</p>
</td>
</tr>
</tbody>
</table>

## 功能说明<a name="section73552454261"></a>

设置内存复制描述符，此接口调用完成后，会将源地址，目的地址、内存复制长度记录到内存复制描述符中。

本接口需与其它关键接口配合使用，以便实现内存复制，详细描述请参见[aclrtMemcpyAsyncWithDesc](aclrtMemcpyAsyncWithDesc.md)。

## 函数原型<a name="section195491952142612"></a>

```
aclError aclrtSetMemcpyDesc(void *desc, aclrtMemcpyKind kind, void *srcAddr, void *dstAddr, size_t count, void *config)
```

## 参数说明<a name="section155499553266"></a>

<a name="zh-cn_topic_0122830089_table438764393513"></a>
<table><thead align="left"><tr id="zh-cn_topic_0122830089_row53871743113510"><th class="cellrowborder" valign="top" width="18%" id="mcps1.1.4.1.1"><p id="zh-cn_topic_0122830089_p1438834363520"><a name="zh-cn_topic_0122830089_p1438834363520"></a><a name="zh-cn_topic_0122830089_p1438834363520"></a>参数名</p>
</th>
<th class="cellrowborder" valign="top" width="14.000000000000002%" id="mcps1.1.4.1.2"><p id="p1769255516412"><a name="p1769255516412"></a><a name="p1769255516412"></a>输入/输出</p>
</th>
<th class="cellrowborder" valign="top" width="68%" id="mcps1.1.4.1.3"><p id="zh-cn_topic_0122830089_p173881843143514"><a name="zh-cn_topic_0122830089_p173881843143514"></a><a name="zh-cn_topic_0122830089_p173881843143514"></a>说明</p>
</th>
</tr>
</thead>
<tbody><tr id="zh-cn_topic_0122830089_row2038874343514"><td class="cellrowborder" valign="top" width="18%" headers="mcps1.1.4.1.1 "><p id="p9400638153818"><a name="p9400638153818"></a><a name="p9400638153818"></a>desc</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p18400738133818"><a name="p18400738133818"></a><a name="p18400738133818"></a>输出</p>
</td>
<td class="cellrowborder" valign="top" width="68%" headers="mcps1.1.4.1.3 "><p id="p1836515611014"><a name="p1836515611014"></a><a name="p1836515611014"></a><span>内存复制描述符地址指针。</span></p>
<p id="p78331641101"><a name="p78331641101"></a><a name="p78331641101"></a><span>需先调用</span><a href="aclrtGetMemcpyDescSize.md">aclrtGetMemcpyDescSize</a><span>接口获取内存描述符所需的内存大小，再申请Device内存后（例如aclrtMalloc接口），将Device内存地址作为入参传入此处</span>。</p>
</td>
</tr>
<tr id="row9239337182413"><td class="cellrowborder" valign="top" width="18%" headers="mcps1.1.4.1.1 "><p id="p172395378245"><a name="p172395378245"></a><a name="p172395378245"></a>kind</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p1224093712413"><a name="p1224093712413"></a><a name="p1224093712413"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="68%" headers="mcps1.1.4.1.3 "><p id="p324015379249"><a name="p324015379249"></a><a name="p324015379249"></a>内存复制的类型。</p>
<p id="p19722101614219"><a name="p19722101614219"></a><a name="p19722101614219"></a>当前仅支持ACL_MEMCPY_INNER_DEVICE_TO_DEVICE，表示Device内的内存复制。</p>
</td>
</tr>
<tr id="row15173165217315"><td class="cellrowborder" valign="top" width="18%" headers="mcps1.1.4.1.1 "><p id="p1539983873819"><a name="p1539983873819"></a><a name="p1539983873819"></a>srcAddr</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p19399838123812"><a name="p19399838123812"></a><a name="p19399838123812"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="68%" headers="mcps1.1.4.1.3 "><p id="p272014248316"><a name="p272014248316"></a><a name="p272014248316"></a>源内存地址指针。</p>
<p id="p1224236404"><a name="p1224236404"></a><a name="p1224236404"></a>由用户申请内存并管理内存。</p>
</td>
</tr>
<tr id="row7909131293411"><td class="cellrowborder" valign="top" width="18%" headers="mcps1.1.4.1.1 "><p id="p1839810385386"><a name="p1839810385386"></a><a name="p1839810385386"></a>dstAddr</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p1739733819387"><a name="p1739733819387"></a><a name="p1739733819387"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="68%" headers="mcps1.1.4.1.3 "><p id="p4388859358"><a name="p4388859358"></a><a name="p4388859358"></a>目的内存地址指针。</p>
<p id="p1894145518407"><a name="p1894145518407"></a><a name="p1894145518407"></a>由用户申请内存并管理内存。</p>
</td>
</tr>
<tr id="row10572723113916"><td class="cellrowborder" valign="top" width="18%" headers="mcps1.1.4.1.1 "><p id="p6572102316399"><a name="p6572102316399"></a><a name="p6572102316399"></a>count</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p1357213231396"><a name="p1357213231396"></a><a name="p1357213231396"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="68%" headers="mcps1.1.4.1.3 "><p id="p10624131419429"><a name="p10624131419429"></a><a name="p10624131419429"></a>内存复制的长度，单位Byte。</p>
</td>
</tr>
<tr id="row3706186171720"><td class="cellrowborder" valign="top" width="18%" headers="mcps1.1.4.1.1 "><p id="p970696131720"><a name="p970696131720"></a><a name="p970696131720"></a>config</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p57064617171"><a name="p57064617171"></a><a name="p57064617171"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="68%" headers="mcps1.1.4.1.3 "><p id="p67061468174"><a name="p67061468174"></a><a name="p67061468174"></a>预留参数，当前固定传NULL。</p>
</td>
</tr>
</tbody>
</table>

## 返回值说明<a name="section1435713587268"></a>

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

