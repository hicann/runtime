# aclprofMarkEx<a name="ZH-CN_TOPIC_0000001867346776"></a>

## AI处理器支持情况<a name="section8178181118225"></a>

<a name="zh-cn_topic_0000001265241414_table38301303189"></a>
<table><thead align="left"><tr id="zh-cn_topic_0000001265241414_row20831180131817"><th class="cellrowborder" valign="top" width="57.99999999999999%" id="mcps1.1.3.1.1"><p id="zh-cn_topic_0000001265241414_p1883113061818"><a name="zh-cn_topic_0000001265241414_p1883113061818"></a><a name="zh-cn_topic_0000001265241414_p1883113061818"></a><span id="zh-cn_topic_0000001265241414_ph20833205312295"><a name="zh-cn_topic_0000001265241414_ph20833205312295"></a><a name="zh-cn_topic_0000001265241414_ph20833205312295"></a>AI处理器类型</span></p>
</th>
<th class="cellrowborder" align="center" valign="top" width="42%" id="mcps1.1.3.1.2"><p id="zh-cn_topic_0000001265241414_p783113012187"><a name="zh-cn_topic_0000001265241414_p783113012187"></a><a name="zh-cn_topic_0000001265241414_p783113012187"></a>是否支持</p>
</th>
</tr>
</thead>
<tbody><tr id="zh-cn_topic_0000001265241414_row220181016240"><td class="cellrowborder" valign="top" width="57.99999999999999%" headers="mcps1.1.3.1.1 "><p id="zh-cn_topic_0000001265241414_p48327011813"><a name="zh-cn_topic_0000001265241414_p48327011813"></a><a name="zh-cn_topic_0000001265241414_p48327011813"></a><span id="zh-cn_topic_0000001265241414_ph583230201815"><a name="zh-cn_topic_0000001265241414_ph583230201815"></a><a name="zh-cn_topic_0000001265241414_ph583230201815"></a><term id="zh-cn_topic_0000001265241414_zh-cn_topic_0000001312391781_term1253731311225"><a name="zh-cn_topic_0000001265241414_zh-cn_topic_0000001312391781_term1253731311225"></a><a name="zh-cn_topic_0000001265241414_zh-cn_topic_0000001312391781_term1253731311225"></a>Ascend 910C</term></span></p>
</td>
<td class="cellrowborder" align="center" valign="top" width="42%" headers="mcps1.1.3.1.2 "><p id="zh-cn_topic_0000001265241414_p7948163910184"><a name="zh-cn_topic_0000001265241414_p7948163910184"></a><a name="zh-cn_topic_0000001265241414_p7948163910184"></a>√</p>
</td>
</tr>
<tr id="zh-cn_topic_0000001265241414_row173226882415"><td class="cellrowborder" valign="top" width="57.99999999999999%" headers="mcps1.1.3.1.1 "><p id="zh-cn_topic_0000001265241414_p14832120181815"><a name="zh-cn_topic_0000001265241414_p14832120181815"></a><a name="zh-cn_topic_0000001265241414_p14832120181815"></a><span id="zh-cn_topic_0000001265241414_ph1483216010188"><a name="zh-cn_topic_0000001265241414_ph1483216010188"></a><a name="zh-cn_topic_0000001265241414_ph1483216010188"></a><term id="zh-cn_topic_0000001265241414_zh-cn_topic_0000001312391781_term11962195213215"><a name="zh-cn_topic_0000001265241414_zh-cn_topic_0000001312391781_term11962195213215"></a><a name="zh-cn_topic_0000001265241414_zh-cn_topic_0000001312391781_term11962195213215"></a>Ascend 910B</term></span></p>
</td>
<td class="cellrowborder" align="center" valign="top" width="42%" headers="mcps1.1.3.1.2 "><p id="zh-cn_topic_0000001265241414_p19948143911820"><a name="zh-cn_topic_0000001265241414_p19948143911820"></a><a name="zh-cn_topic_0000001265241414_p19948143911820"></a>√</p>
</td>
</tr>
</tbody>
</table>

## 功能说明<a name="section5408205113614"></a>

aclprofMarkEx打点接口。

调用此接口向配置的Stream流上下发打点任务，用于标识Host侧打点与Device侧打点任务的关系。

## 函数原型<a name="section632914018717"></a>

```
aclError aclprofMarkEx(const char *msg, size_t msgLen, aclrtStream stream)
```

## 参数说明<a name="section9911636710"></a>

<a name="zh-cn_topic_0122830089_table438764393513"></a>
<table><thead align="left"><tr id="zh-cn_topic_0122830089_row53871743113510"><th class="cellrowborder" valign="top" width="18%" id="mcps1.1.4.1.1"><p id="zh-cn_topic_0122830089_p1438834363520"><a name="zh-cn_topic_0122830089_p1438834363520"></a><a name="zh-cn_topic_0122830089_p1438834363520"></a>参数名</p>
</th>
<th class="cellrowborder" valign="top" width="14.000000000000002%" id="mcps1.1.4.1.2"><p id="p1769255516412"><a name="p1769255516412"></a><a name="p1769255516412"></a>输入/输出</p>
</th>
<th class="cellrowborder" valign="top" width="68%" id="mcps1.1.4.1.3"><p id="zh-cn_topic_0122830089_p173881843143514"><a name="zh-cn_topic_0122830089_p173881843143514"></a><a name="zh-cn_topic_0122830089_p173881843143514"></a>说明</p>
</th>
</tr>
</thead>
<tbody><tr id="row196302710266"><td class="cellrowborder" valign="top" width="18%" headers="mcps1.1.4.1.1 "><p id="p16379133393014"><a name="p16379133393014"></a><a name="p16379133393014"></a>msg</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p65435198594"><a name="p65435198594"></a><a name="p65435198594"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="68%" headers="mcps1.1.4.1.3 "><p id="p73792332307"><a name="p73792332307"></a><a name="p73792332307"></a>打点信息字符串指针。</p>
</td>
</tr>
<tr id="row11639321408"><td class="cellrowborder" valign="top" width="18%" headers="mcps1.1.4.1.1 "><p id="p7685175451911"><a name="p7685175451911"></a><a name="p7685175451911"></a>msgLen</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p2539151913594"><a name="p2539151913594"></a><a name="p2539151913594"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="68%" headers="mcps1.1.4.1.3 "><p id="p4685195471917"><a name="p4685195471917"></a><a name="p4685195471917"></a>字符串长度。最大支持127字符。</p>
</td>
</tr>
<tr id="row8365115264018"><td class="cellrowborder" valign="top" width="18%" headers="mcps1.1.4.1.1 "><p id="p837611641510"><a name="p837611641510"></a><a name="p837611641510"></a>stream</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p1737671691512"><a name="p1737671691512"></a><a name="p1737671691512"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="68%" headers="mcps1.1.4.1.3 "><p id="p8376121631513"><a name="p8376121631513"></a><a name="p8376121631513"></a>指定Stream。</p>
</td>
</tr>
</tbody>
</table>

## 返回值说明<a name="section41841371675"></a>

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

