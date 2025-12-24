# aclrtCmoAsyncWithDesc<a name="ZH-CN_TOPIC_0000002455505236"></a>

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
<td class="cellrowborder" align="center" valign="top" width="42%" headers="mcps1.1.3.1.2 "><p id="p89392044183214"><a name="p89392044183214"></a><a name="p89392044183214"></a>√</p>
</td>
</tr>
<tr id="row173226882415"><td class="cellrowborder" valign="top" width="57.99999999999999%" headers="mcps1.1.3.1.1 "><p id="p14832120181815"><a name="p14832120181815"></a><a name="p14832120181815"></a><span id="ph1483216010188"><a name="ph1483216010188"></a><a name="ph1483216010188"></a><term id="zh-cn_topic_0000001312391781_term11962195213215"><a name="zh-cn_topic_0000001312391781_term11962195213215"></a><a name="zh-cn_topic_0000001312391781_term11962195213215"></a>Ascend 910B</term></span></p>
</td>
<td class="cellrowborder" align="center" valign="top" width="42%" headers="mcps1.1.3.1.2 "><p id="p16939114493213"><a name="p16939114493213"></a><a name="p16939114493213"></a>√</p>
</td>
</tr>
</tbody>
</table>

## 功能说明<a name="section36583473819"></a>

使用内存描述符（二级指针方式）操作Device上的Cache内存。异步接口。

## 函数原型<a name="section13230182415108"></a>

```
aclError aclrtCmoAsyncWithDesc(void *cmoDesc, aclrtCmoType cmoType, aclrtStream stream, const void *reserve)
```

## 参数说明<a name="section75395119104"></a>

<a name="zh-cn_topic_0122830089_table438764393513"></a>
<table><thead align="left"><tr id="zh-cn_topic_0122830089_row53871743113510"><th class="cellrowborder" valign="top" width="13.96%" id="mcps1.1.4.1.1"><p id="zh-cn_topic_0122830089_p1438834363520"><a name="zh-cn_topic_0122830089_p1438834363520"></a><a name="zh-cn_topic_0122830089_p1438834363520"></a>参数名</p>
</th>
<th class="cellrowborder" valign="top" width="14.02%" id="mcps1.1.4.1.2"><p id="p1769255516412"><a name="p1769255516412"></a><a name="p1769255516412"></a>输入/输出</p>
</th>
<th class="cellrowborder" valign="top" width="72.02%" id="mcps1.1.4.1.3"><p id="zh-cn_topic_0122830089_p173881843143514"><a name="zh-cn_topic_0122830089_p173881843143514"></a><a name="zh-cn_topic_0122830089_p173881843143514"></a>说明</p>
</th>
</tr>
</thead>
<tbody><tr id="zh-cn_topic_0122830089_row2038874343514"><td class="cellrowborder" valign="top" width="13.96%" headers="mcps1.1.4.1.1 "><p id="p8140124955"><a name="p8140124955"></a><a name="p8140124955"></a>cmoDesc</p>
</td>
<td class="cellrowborder" valign="top" width="14.02%" headers="mcps1.1.4.1.2 "><p id="p2241655123913"><a name="p2241655123913"></a><a name="p2241655123913"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="72.02%" headers="mcps1.1.4.1.3 "><p id="p183993383385"><a name="p183993383385"></a><a name="p183993383385"></a>Cache内存描述符地址指针，Device侧内存地址。</p>
<p id="p155001427378"><a name="p155001427378"></a><a name="p155001427378"></a>此处需先调用aclrtCmoSetDesc接口设置内存描述符，再将内存描述符地址指针作为入参传入本接口。</p>
</td>
</tr>
<tr id="row55295222395"><td class="cellrowborder" valign="top" width="13.96%" headers="mcps1.1.4.1.1 "><p id="p11529192273916"><a name="p11529192273916"></a><a name="p11529192273916"></a>stream</p>
</td>
<td class="cellrowborder" valign="top" width="14.02%" headers="mcps1.1.4.1.2 "><p id="p122411155103917"><a name="p122411155103917"></a><a name="p122411155103917"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="72.02%" headers="mcps1.1.4.1.3 "><p id="p684731811473"><a name="p684731811473"></a><a name="p684731811473"></a>执行内存操作任务的Stream。</p>
</td>
</tr>
<tr id="row16421194917392"><td class="cellrowborder" valign="top" width="13.96%" headers="mcps1.1.4.1.1 "><p id="p542134918399"><a name="p542134918399"></a><a name="p542134918399"></a>cmoType</p>
</td>
<td class="cellrowborder" valign="top" width="14.02%" headers="mcps1.1.4.1.2 "><p id="p224115510394"><a name="p224115510394"></a><a name="p224115510394"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="72.02%" headers="mcps1.1.4.1.3 "><p id="p15847718114716"><a name="p15847718114716"></a><a name="p15847718114716"></a>Cache内存操作类型。</p>
<p id="p5677356204712"><a name="p5677356204712"></a><a name="p5677356204712"></a>当前仅支持ACL_RT_CMO_TYPE_PREFETCH（内存预取）。</p>
</td>
</tr>
<tr id="row15532816205615"><td class="cellrowborder" valign="top" width="13.96%" headers="mcps1.1.4.1.1 "><p id="p191381124654"><a name="p191381124654"></a><a name="p191381124654"></a>reserve</p>
</td>
<td class="cellrowborder" valign="top" width="14.02%" headers="mcps1.1.4.1.2 "><p id="p624255583911"><a name="p624255583911"></a><a name="p624255583911"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="72.02%" headers="mcps1.1.4.1.3 "><p id="p11886152364016"><a name="p11886152364016"></a><a name="p11886152364016"></a>预留参数。当前固定传NULL。</p>
</td>
</tr>
</tbody>
</table>

## 返回值说明<a name="section25791320141317"></a>

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

