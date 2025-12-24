# aclrtSetStreamAttribute<a name="ZH-CN_TOPIC_0000002271199408"></a>

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

设置Stream属性值。

## 函数原型<a name="section13230182415108"></a>

```
aclError aclrtSetStreamAttribute(aclrtStream stream, aclrtStreamAttr stmAttrType, aclrtStreamAttrValue *value)
```

## 参数说明<a name="section75395119104"></a>

<a name="zh-cn_topic_0122830089_table438764393513"></a>
<table><thead align="left"><tr id="zh-cn_topic_0122830089_row53871743113510"><th class="cellrowborder" valign="top" width="21.39%" id="mcps1.1.4.1.1"><p id="zh-cn_topic_0122830089_p1438834363520"><a name="zh-cn_topic_0122830089_p1438834363520"></a><a name="zh-cn_topic_0122830089_p1438834363520"></a>参数名</p>
</th>
<th class="cellrowborder" valign="top" width="18.7%" id="mcps1.1.4.1.2"><p id="p1769255516412"><a name="p1769255516412"></a><a name="p1769255516412"></a>输入/输出</p>
</th>
<th class="cellrowborder" valign="top" width="59.91%" id="mcps1.1.4.1.3"><p id="zh-cn_topic_0122830089_p173881843143514"><a name="zh-cn_topic_0122830089_p173881843143514"></a><a name="zh-cn_topic_0122830089_p173881843143514"></a>说明</p>
</th>
</tr>
</thead>
<tbody><tr id="row229712714517"><td class="cellrowborder" valign="top" width="21.39%" headers="mcps1.1.4.1.1 "><p id="p79081724131910"><a name="p79081724131910"></a><a name="p79081724131910"></a>stream</p>
</td>
<td class="cellrowborder" valign="top" width="18.7%" headers="mcps1.1.4.1.2 "><p id="p8908162411194"><a name="p8908162411194"></a><a name="p8908162411194"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="59.91%" headers="mcps1.1.4.1.3 "><p id="p2015516107499"><a name="p2015516107499"></a><a name="p2015516107499"></a>指定Stream。</p>
<p id="p879613933315"><a name="p879613933315"></a><a name="p879613933315"></a>不支持传NULL（表示默认Stream）。</p>
</td>
</tr>
<tr id="row155291213104918"><td class="cellrowborder" valign="top" width="21.39%" headers="mcps1.1.4.1.1 "><p id="p7529113204911"><a name="p7529113204911"></a><a name="p7529113204911"></a>stmAttrType</p>
</td>
<td class="cellrowborder" valign="top" width="18.7%" headers="mcps1.1.4.1.2 "><p id="p1352917131494"><a name="p1352917131494"></a><a name="p1352917131494"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="59.91%" headers="mcps1.1.4.1.3 "><p id="p5529191313491"><a name="p5529191313491"></a><a name="p5529191313491"></a><span>属性类型</span>。</p>
</td>
</tr>
<tr id="row14765201524915"><td class="cellrowborder" valign="top" width="21.39%" headers="mcps1.1.4.1.1 "><p id="p12765315184912"><a name="p12765315184912"></a><a name="p12765315184912"></a>value</p>
</td>
<td class="cellrowborder" valign="top" width="18.7%" headers="mcps1.1.4.1.2 "><p id="p77651415164910"><a name="p77651415164910"></a><a name="p77651415164910"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="59.91%" headers="mcps1.1.4.1.3 "><p id="p576501510499"><a name="p576501510499"></a><a name="p576501510499"></a>属性值。</p>
</td>
</tr>
</tbody>
</table>

## 返回值说明<a name="section25791320141317"></a>

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

## 约束说明<a name="section74241256205416"></a>

-   溢出检测属性：调用该接口打开或关闭溢出检测开关后，仅对后续新下的任务生效，已下发的任务仍维持原样。
-   Failure Mode：不支持对Context默认Stream设置Failure Mode。

