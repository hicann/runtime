# aclprofModelUnSubscribe<a name="ZH-CN_TOPIC_0000001312481529"></a>

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

网络场景下，取消订阅算子的基本信息，包括算子名称、算子类型、算子执行耗时等。

## 函数原型<a name="section632914018717"></a>

```
aclError aclprofModelUnSubscribe(uint32_t modelId)
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
<tbody><tr id="row10379818172019"><td class="cellrowborder" valign="top" width="18%" headers="mcps1.1.4.1.1 "><p id="p11380141621213"><a name="p11380141621213"></a><a name="p11380141621213"></a>modelId</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p18378716131210"><a name="p18378716131210"></a><a name="p18378716131210"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="68%" headers="mcps1.1.4.1.3 "><p id="p232968195819"><a name="p232968195819"></a><a name="p232968195819"></a>已订阅的模型的ID。</p>
</td>
</tr>
</tbody>
</table>

## 返回值说明<a name="section41841371675"></a>

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

## 约束说明<a name="section41121242192017"></a>

与[aclprofModelSubscribe](aclprofModelSubscribe.md)接口配对使用。

