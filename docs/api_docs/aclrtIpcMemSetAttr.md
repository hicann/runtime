# aclrtIpcMemSetAttr

## AI处理器支持情况

<table><thead align="left"><tr id="row20831180131817"><th class="cellrowborder" valign="top" width="57.99999999999999%" id="mcps1.1.3.1.1"><p id="p1883113061818"><a name="p1883113061818"></a><a name="p1883113061818"></a><span id="ph20833205312295"><a name="ph20833205312295"></a><a name="ph20833205312295"></a>AI处理器类型</span></p>
</th>
<th class="cellrowborder" align="center" valign="top" width="42%" id="mcps1.1.3.1.2"><p id="p783113012187"><a name="p783113012187"></a><a name="p783113012187"></a>是否支持</p>
</th>
</tr>
</thead>
<tbody><tr id="row220181016240"><td class="cellrowborder" valign="top" width="57.99999999999999%" headers="mcps1.1.3.1.1 "><p id="p48327011813"><a name="p48327011813"></a><a name="p48327011813"></a><span id="ph583230201815"><a name="ph583230201815"></a><a name="ph583230201815"></a><term id="zh-cn_topic_0000001312391781_term1253731311225"><a name="zh-cn_topic_0000001312391781_term1253731311225"></a><a name="zh-cn_topic_0000001312391781_term1253731311225"></a>Ascend 910C</term></span></p>
</td>
<td class="cellrowborder" align="center" valign="top" width="42%" headers="mcps1.1.3.1.2 "><p id="p7670132452015"><a name="p7670132452015"></a><a name="p7670132452015"></a>√</p>
</td>
</tr>
<tr id="row173226882415"><td class="cellrowborder" valign="top" width="57.99999999999999%" headers="mcps1.1.3.1.1 "><p id="p14832120181815"><a name="p14832120181815"></a><a name="p14832120181815"></a><span id="ph1483216010188"><a name="ph1483216010188"></a><a name="ph1483216010188"></a><term id="zh-cn_topic_0000001312391781_term11962195213215"><a name="zh-cn_topic_0000001312391781_term11962195213215"></a><a name="zh-cn_topic_0000001312391781_term11962195213215"></a>Ascend 910B</term></span></p>
</td>
<td class="cellrowborder" align="center" valign="top" width="42%" headers="mcps1.1.3.1.2 "><p id="p767012419202"><a name="p767012419202"></a><a name="p767012419202"></a>x</p>
</td>
</tr>
</tbody>
</table>

## 功能说明

设置IPC共享内存的属性信息。

## 函数原型

```
aclError aclrtIpcMemSetAttr(const char *key, aclrtIpcMemAttrType type, uint64_t attr)
```

## 参数说明

<table><thead align="left"><tr id="zh-cn_topic_0122830089_row53871743113510"><th class="cellrowborder" valign="top" width="18%" id="mcps1.1.4.1.1"><p id="zh-cn_topic_0122830089_p1438834363520"><a name="zh-cn_topic_0122830089_p1438834363520"></a><a name="zh-cn_topic_0122830089_p1438834363520"></a>参数名</p>
</th>
<th class="cellrowborder" valign="top" width="13.98%" id="mcps1.1.4.1.2"><p id="p1769255516412"><a name="p1769255516412"></a><a name="p1769255516412"></a>输入/输出</p>
</th>
<th class="cellrowborder" valign="top" width="68.02%" id="mcps1.1.4.1.3"><p id="zh-cn_topic_0122830089_p173881843143514"><a name="zh-cn_topic_0122830089_p173881843143514"></a><a name="zh-cn_topic_0122830089_p173881843143514"></a>说明</p>
</th>
</tr>
</thead>
<tbody><tr id="zh-cn_topic_0122830089_row2038874343514"><td class="cellrowborder" valign="top" width="18%" headers="mcps1.1.4.1.1 "><p id="p1655619401428"><a name="p1655619401428"></a><a name="p1655619401428"></a>key</p>
</td>
<td class="cellrowborder" valign="top" width="13.98%" headers="mcps1.1.4.1.2 "><p id="p16555144064210"><a name="p16555144064210"></a><a name="p16555144064210"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="68.02%" headers="mcps1.1.4.1.3 "><p id="p3987271202"><a name="p3987271202"></a><a name="p3987271202"></a>共享内存key，字符串长度小于64，以\0结尾。</p>
</td>
</tr>
<tr id="row198943121925"><td class="cellrowborder" valign="top" width="18%" headers="mcps1.1.4.1.1 "><p id="p1355324015422"><a name="p1355324015422"></a><a name="p1355324015422"></a>type</p>
</td>
<td class="cellrowborder" valign="top" width="13.98%" headers="mcps1.1.4.1.2 "><p id="p4553164019429"><a name="p4553164019429"></a><a name="p4553164019429"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="68.02%" headers="mcps1.1.4.1.3 "><p id="p39871715019"><a name="p39871715019"></a><a name="p39871715019"></a>内存映射类型，当前支持配置为ACL_RT_IPC_MEM_ATTR_ACCESS_LINK，用于在跨片访问时，指定双die之间是SIO（serial input/output）通道、还是HCCS（Huawei Cache Coherence System）通道。</p>
</td>
</tr>
<tr id="row15177165810296"><td class="cellrowborder" valign="top" width="18%" headers="mcps1.1.4.1.1 "><p id="p71781358192918"><a name="p71781358192918"></a><a name="p71781358192918"></a>attr</p>
</td>
<td class="cellrowborder" valign="top" width="13.98%" headers="mcps1.1.4.1.2 "><p id="p11178558142911"><a name="p11178558142911"></a><a name="p11178558142911"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="68.02%" headers="mcps1.1.4.1.3 "><p id="p3987177202"><a name="p3987177202"></a><a name="p3987177202"></a>属性。</p>
<p id="p10202194443813"><a name="p10202194443813"></a><a name="p10202194443813"></a>当前支持设置为如下宏：</p>
<a name="ul9516171415380"></a><a name="ul9516171415380"></a><ul id="ul9516171415380"><li>ACL_RT_IPC_MEM_ATTR_ACCESS_LINK_SIO：SIO通道，默认该选项<pre class="screen" id="screen1187991419396"><a name="screen1187991419396"></a><a name="screen1187991419396"></a>#define ACL_RT_IPC_MEM_ATTR_ACCESS_LINK_SIO 0</pre>
</li><li>ACL_RT_IPC_MEM_ATTR_ACCESS_LINK_HCCS：HCCS通道<pre class="screen" id="screen1489184053910"><a name="screen1489184053910"></a><a name="screen1489184053910"></a>#define ACL_RT_IPC_MEM_ATTR_ACCESS_LINK_HCCS 1</pre>
</li></ul>
</td>
</tr>
</tbody>
</table>

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

