# aclrtGetOpTimeoutInterval<a name="ZH-CN_TOPIC_0000002470838736"></a>

<a name="table14548193915617"></a>
<table><thead align="left"><tr id="row17548123915562"><th class="cellrowborder" valign="top" width="57.99999999999999%" id="mcps1.1.3.1.1"><p id="p17548739115610"><a name="p17548739115610"></a><a name="p17548739115610"></a><span id="ph254803916568"><a name="ph254803916568"></a><a name="ph254803916568"></a>AI处理器类型</span></p>
</th>
<th class="cellrowborder" align="center" valign="top" width="42%" id="mcps1.1.3.1.2"><p id="p454883985619"><a name="p454883985619"></a><a name="p454883985619"></a>是否支持</p>
</th>
</tr>
</thead>
<tbody><tr id="row3548113945611"><td class="cellrowborder" valign="top" width="57.99999999999999%" headers="mcps1.1.3.1.1 "><p id="p254873965612"><a name="p254873965612"></a><a name="p254873965612"></a><span id="ph95489398568"><a name="ph95489398568"></a><a name="ph95489398568"></a><term id="zh-cn_topic_0000001312391781_term1253731311225"><a name="zh-cn_topic_0000001312391781_term1253731311225"></a><a name="zh-cn_topic_0000001312391781_term1253731311225"></a>Ascend 910C</term></span></p>
</td>
<td class="cellrowborder" align="center" valign="top" width="42%" headers="mcps1.1.3.1.2 "><p id="p1954833965616"><a name="p1954833965616"></a><a name="p1954833965616"></a>√</p>
</td>
</tr>
<tr id="row254863965616"><td class="cellrowborder" valign="top" width="57.99999999999999%" headers="mcps1.1.3.1.1 "><p id="p1654893915562"><a name="p1654893915562"></a><a name="p1654893915562"></a><span id="ph4548163912562"><a name="ph4548163912562"></a><a name="ph4548163912562"></a><term id="zh-cn_topic_0000001312391781_term11962195213215"><a name="zh-cn_topic_0000001312391781_term11962195213215"></a><a name="zh-cn_topic_0000001312391781_term11962195213215"></a>Ascend 910B</term></span></p>
</td>
<td class="cellrowborder" align="center" valign="top" width="42%" headers="mcps1.1.3.1.2 "><p id="p754853916568"><a name="p754853916568"></a><a name="p754853916568"></a>√</p>
</td>
</tr>
</tbody>
</table>

## 功能说明<a name="section36583473819"></a>

获取硬件支持的算子超时配置的最短时间间隔interval，单位为微秒。

## 函数原型<a name="section13230182415108"></a>

```
aclError aclrtGetOpTimeoutInterval(uint64_t *interval)
```

## 参数说明<a name="section75395119104"></a>

<a name="zh-cn_topic_0122830089_table438764393513"></a>
<table><thead align="left"><tr id="zh-cn_topic_0122830089_row53871743113510"><th class="cellrowborder" valign="top" width="18%" id="mcps1.1.4.1.1"><p id="zh-cn_topic_0122830089_p1438834363520"><a name="zh-cn_topic_0122830089_p1438834363520"></a><a name="zh-cn_topic_0122830089_p1438834363520"></a>参数名</p>
</th>
<th class="cellrowborder" valign="top" width="14.000000000000002%" id="mcps1.1.4.1.2"><p id="p1769255516412"><a name="p1769255516412"></a><a name="p1769255516412"></a>输入/输出</p>
</th>
<th class="cellrowborder" valign="top" width="68%" id="mcps1.1.4.1.3"><p id="zh-cn_topic_0122830089_p173881843143514"><a name="zh-cn_topic_0122830089_p173881843143514"></a><a name="zh-cn_topic_0122830089_p173881843143514"></a>说明</p>
</th>
</tr>
</thead>
<tbody><tr id="zh-cn_topic_0122830089_row2038874343514"><td class="cellrowborder" valign="top" width="18%" headers="mcps1.1.4.1.1 "><p id="p0124125211120"><a name="p0124125211120"></a><a name="p0124125211120"></a>interval</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p1412319523115"><a name="p1412319523115"></a><a name="p1412319523115"></a>输出</p>
</td>
<td class="cellrowborder" valign="top" width="68%" headers="mcps1.1.4.1.3 "><p id="p186481916124811"><a name="p186481916124811"></a><a name="p186481916124811"></a>最短时间间隔，单位为微秒。</p>
<p id="p1993417445135"><a name="p1993417445135"></a><a name="p1993417445135"></a>用户可配置且生效的超时时间是interval * N，N的取值为[1, 254]的整数，如果用户配置的超时时间不等于interval * N，则向上对齐到interval * N，假设interval = 100微秒，用户设置的超时时间为50微秒，则实际生效的超时时间为100 *1 = 100微秒；用户设置的超时时间为30000微秒，则实际生效的超时时间为100 *254 =25400微秒。</p>
</td>
</tr>
</tbody>
</table>

## 返回值说明<a name="section25791320141317"></a>

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

