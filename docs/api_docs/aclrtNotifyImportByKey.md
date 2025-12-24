# aclrtNotifyImportByKey<a name="ZH-CN_TOPIC_0000002365327649"></a>

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

在本进程中获取key的信息，并返回本进程可以使用的Notify指针。

本接口需与其它接口配合使用，以便实现多Device上不同进程间的任务同步，请参见[aclrtNotifyGetExportKey](aclrtNotifyGetExportKey.md)接口处的说明。

## 函数原型<a name="section13230182415108"></a>

```
aclError aclrtNotifyImportByKey(aclrtNotify *notify, const char *key, uint64_t flags)
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
<tbody><tr id="zh-cn_topic_0122830089_row2038874343514"><td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.1 "><p id="p1588612558270"><a name="p1588612558270"></a><a name="p1588612558270"></a>notify</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p1688525512278"><a name="p1688525512278"></a><a name="p1688525512278"></a>输出</p>
</td>
<td class="cellrowborder" valign="top" width="72%" headers="mcps1.1.4.1.3 "><p id="p7884145522717"><a name="p7884145522717"></a><a name="p7884145522717"></a>Notify指针。</p>
</td>
</tr>
<tr id="row1141161375"><td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.1 "><p id="p10884755182711"><a name="p10884755182711"></a><a name="p10884755182711"></a>key</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p188831655192715"><a name="p188831655192715"></a><a name="p188831655192715"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="72%" headers="mcps1.1.4.1.3 "><p id="p11883165517279"><a name="p11883165517279"></a><a name="p11883165517279"></a>Notify共享名称。</p>
<p id="p13820558115920"><a name="p13820558115920"></a><a name="p13820558115920"></a>必须先调用<a href="aclrtNotifyGetExportKey.md">aclrtNotifyGetExportKey</a>接口获取指定Notify的共享名称，再作为入参传入。</p>
</td>
</tr>
<tr id="row17312161210424"><td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.1 "><p id="p15882155510275"><a name="p15882155510275"></a><a name="p15882155510275"></a>flags</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p138822558270"><a name="p138822558270"></a><a name="p138822558270"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="72%" headers="mcps1.1.4.1.3 "><p id="p1349185435919"><a name="p1349185435919"></a><a name="p1349185435919"></a>是否开启两个Device之间的数据交互。</p>
<p id="p6169115715920"><a name="p6169115715920"></a><a name="p6169115715920"></a>取值为如下宏：</p>
<a name="ul33464527015"></a><a name="ul33464527015"></a><ul id="ul33464527015"><li>ACL_RT_NOTIFY_IMPORT_FLAG_DEFAULT：默认值，关闭两个Device之间的数据交互。<p id="p1370123117185"><a name="p1370123117185"></a><a name="p1370123117185"></a>配置为该值时，需单独调用<a href="aclrtDeviceEnablePeerAccess.md">aclrtDeviceEnablePeerAccess</a>接口开启两个Device之间的数据交互。</p>
</li><li>ACL_RT_NOTIFY_IMPORT_FLAG_ENABLE_PEER_ACCESS：开启两个Device之间的数据交互。<p id="p18973113891815"><a name="p18973113891815"></a><a name="p18973113891815"></a>配置为该值时，则无需调用<a href="aclrtDeviceEnablePeerAccess.md">aclrtDeviceEnablePeerAccess</a>接口。</p>
</li></ul>
<p id="p18200675010"><a name="p18200675010"></a><a name="p18200675010"></a>宏的定义如下：</p>
<pre class="screen" id="screen158584141105"><a name="screen158584141105"></a><a name="screen158584141105"></a>#define ACL_RT_NOTIFY_IMPORT_FLAG_DEFAULT            0x0UL
#define ACL_RT_NOTIFY_IMPORT_FLAG_ENABLE_PEER_ACCESS 0x02UL</pre>
</td>
</tr>
</tbody>
</table>

## 返回值说明<a name="section25791320141317"></a>

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

## 约束说明<a name="section177420203915"></a>

昇腾虚拟化实例场景不支持该操作。

