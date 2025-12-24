# aclrtKernelArgsParaUpdate<a name="ZH-CN_TOPIC_0000002238362005"></a>

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
<td class="cellrowborder" align="center" valign="top" width="42%" headers="mcps1.1.3.1.2 "><p id="p116858459716"><a name="p116858459716"></a><a name="p116858459716"></a>√</p>
</td>
</tr>
<tr id="row173226882415"><td class="cellrowborder" valign="top" width="57.99999999999999%" headers="mcps1.1.3.1.1 "><p id="p14832120181815"><a name="p14832120181815"></a><a name="p14832120181815"></a><span id="ph1483216010188"><a name="ph1483216010188"></a><a name="ph1483216010188"></a><term id="zh-cn_topic_0000001312391781_term11962195213215"><a name="zh-cn_topic_0000001312391781_term11962195213215"></a><a name="zh-cn_topic_0000001312391781_term11962195213215"></a>Ascend 910B</term></span></p>
</td>
<td class="cellrowborder" align="center" valign="top" width="42%" headers="mcps1.1.3.1.2 "><p id="p1568544511713"><a name="p1568544511713"></a><a name="p1568544511713"></a>√</p>
</td>
</tr>
</tbody>
</table>

## 功能说明<a name="section73552454261"></a>

通过aclrtKernelArgsAppend接口追加的参数，可调用本接口更新参数值。

## 函数原型<a name="section195491952142612"></a>

```
aclError aclrtKernelArgsParaUpdate(aclrtArgsHandle argsHandle, aclrtParamHandle paramHandle, void *param, size_t paramSize)
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
<tbody><tr id="zh-cn_topic_0122830089_row2038874343514"><td class="cellrowborder" valign="top" width="18%" headers="mcps1.1.4.1.1 "><p id="p7651011104012"><a name="p7651011104012"></a><a name="p7651011104012"></a>argsHandle</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p16651191194015"><a name="p16651191194015"></a><a name="p16651191194015"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="68%" headers="mcps1.1.4.1.3 "><p id="p20647101194014"><a name="p20647101194014"></a><a name="p20647101194014"></a>参数列表句柄。</p>
</td>
</tr>
<tr id="row13422143092910"><td class="cellrowborder" valign="top" width="18%" headers="mcps1.1.4.1.1 "><p id="p3422630172914"><a name="p3422630172914"></a><a name="p3422630172914"></a>paramHandle</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p1942216307294"><a name="p1942216307294"></a><a name="p1942216307294"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="68%" headers="mcps1.1.4.1.3 "><p id="p3422123082914"><a name="p3422123082914"></a><a name="p3422123082914"></a>参数句柄。</p>
</td>
</tr>
<tr id="row1262175715514"><td class="cellrowborder" valign="top" width="18%" headers="mcps1.1.4.1.1 "><p id="p46315571753"><a name="p46315571753"></a><a name="p46315571753"></a>param</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p196320571156"><a name="p196320571156"></a><a name="p196320571156"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="68%" headers="mcps1.1.4.1.3 "><p id="p136305720515"><a name="p136305720515"></a><a name="p136305720515"></a>待更新参数值的内存地址。</p>
<p id="p35691517513"><a name="p35691517513"></a><a name="p35691517513"></a>此处为Host内存地址。</p>
</td>
</tr>
<tr id="row16890171220611"><td class="cellrowborder" valign="top" width="18%" headers="mcps1.1.4.1.1 "><p id="p168913121862"><a name="p168913121862"></a><a name="p168913121862"></a>paramSize</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p089115126614"><a name="p089115126614"></a><a name="p089115126614"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="68%" headers="mcps1.1.4.1.3 "><p id="p18913121611"><a name="p18913121611"></a><a name="p18913121611"></a>内存大小，单位Byte。</p>
</td>
</tr>
</tbody>
</table>

## 返回值说明<a name="section1435713587268"></a>

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

