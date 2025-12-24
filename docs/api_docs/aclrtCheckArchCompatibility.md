# aclrtCheckArchCompatibility

## AI处理器支持情况

<table><thead align="left"><tr id="row20831180131817"><th class="cellrowborder" valign="top" width="57.99999999999999%" id="mcps1.1.3.1.1"><p id="p1883113061818"><a name="p1883113061818"></a><a name="p1883113061818"></a><span id="ph20833205312295"><a name="ph20833205312295"></a><a name="ph20833205312295"></a>AI处理器类型</span></p>
</th>
<th class="cellrowborder" align="center" valign="top" width="42%" id="mcps1.1.3.1.2"><p id="p783113012187"><a name="p783113012187"></a><a name="p783113012187"></a>是否支持</p>
</th>
</tr>
</thead>
<tbody><tr id="row220181016240"><td class="cellrowborder" valign="top" width="57.99999999999999%" headers="mcps1.1.3.1.1 "><p id="p48327011813"><a name="p48327011813"></a><a name="p48327011813"></a><span id="ph583230201815"><a name="ph583230201815"></a><a name="ph583230201815"></a><term id="zh-cn_topic_0000001312391781_term1253731311225"><a name="zh-cn_topic_0000001312391781_term1253731311225"></a><a name="zh-cn_topic_0000001312391781_term1253731311225"></a>Ascend 910C</term></span></p>
</td>
<td class="cellrowborder" align="center" valign="top" width="42%" headers="mcps1.1.3.1.2 "><p id="p2384635105717"><a name="p2384635105717"></a><a name="p2384635105717"></a>√</p>
</td>
</tr>
<tr id="row173226882415"><td class="cellrowborder" valign="top" width="57.99999999999999%" headers="mcps1.1.3.1.1 "><p id="p14832120181815"><a name="p14832120181815"></a><a name="p14832120181815"></a><span id="ph1483216010188"><a name="ph1483216010188"></a><a name="ph1483216010188"></a><term id="zh-cn_topic_0000001312391781_term11962195213215"><a name="zh-cn_topic_0000001312391781_term11962195213215"></a><a name="zh-cn_topic_0000001312391781_term11962195213215"></a>Ascend 910B</term></span></p>
</td>
<td class="cellrowborder" align="center" valign="top" width="42%" headers="mcps1.1.3.1.2 "><p id="p11384935115714"><a name="p11384935115714"></a><a name="p11384935115714"></a>√</p>
</td>
</tr>
</tbody>
</table>

## 功能说明

根据昇腾AI处理器版本判断算子指令是否兼容。

## 函数原型

```
aclError aclrtCheckArchCompatibility(const char *socVersion, int32_t *canCompatible)
```

## 参数说明

<table><thead align="left"><tr id="zh-cn_topic_0122830089_row53871743113510"><th class="cellrowborder" valign="top" width="13.96%" id="mcps1.1.4.1.1"><p id="zh-cn_topic_0122830089_p1438834363520"><a name="zh-cn_topic_0122830089_p1438834363520"></a><a name="zh-cn_topic_0122830089_p1438834363520"></a>参数名</p>
</th>
<th class="cellrowborder" valign="top" width="14.04%" id="mcps1.1.4.1.2"><p id="p1769255516412"><a name="p1769255516412"></a><a name="p1769255516412"></a>输入/输出</p>
</th>
<th class="cellrowborder" valign="top" width="72%" id="mcps1.1.4.1.3"><p id="zh-cn_topic_0122830089_p173881843143514"><a name="zh-cn_topic_0122830089_p173881843143514"></a><a name="zh-cn_topic_0122830089_p173881843143514"></a>说明</p>
</th>
</tr>
</thead>
<tbody><tr id="zh-cn_topic_0122830089_row2038874343514"><td class="cellrowborder" valign="top" width="13.96%" headers="mcps1.1.4.1.1 "><p id="p76784121566"><a name="p76784121566"></a><a name="p76784121566"></a>socVersion</p>
</td>
<td class="cellrowborder" valign="top" width="14.04%" headers="mcps1.1.4.1.2 "><p id="p53880439216"><a name="p53880439216"></a><a name="p53880439216"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="72%" headers="mcps1.1.4.1.3 "><p id="p54140542184"><a name="p54140542184"></a><a name="p54140542184"></a><span id="ph769925491819"><a name="ph769925491819"></a><a name="ph769925491819"></a>昇腾AI处理器</span>版本。</p>
</td>
</tr>
<tr id="row15532816205615"><td class="cellrowborder" valign="top" width="13.96%" headers="mcps1.1.4.1.1 "><p id="p7532181615562"><a name="p7532181615562"></a><a name="p7532181615562"></a>canCompatible</p>
</td>
<td class="cellrowborder" valign="top" width="14.04%" headers="mcps1.1.4.1.2 "><p id="p1938918431822"><a name="p1938918431822"></a><a name="p1938918431822"></a>输出</p>
</td>
<td class="cellrowborder" valign="top" width="72%" headers="mcps1.1.4.1.3 "><p id="p33892431213"><a name="p33892431213"></a><a name="p33892431213"></a>是否兼容，1表示兼容，0表示不兼容。</p>
</td>
</tr>
</tbody>
</table>

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

