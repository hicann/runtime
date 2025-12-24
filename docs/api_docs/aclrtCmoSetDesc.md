# aclrtCmoSetDesc<a name="ZH-CN_TOPIC_0000002488664561"></a>

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
<td class="cellrowborder" align="center" valign="top" width="42%" headers="mcps1.1.3.1.2 "><p id="p1096794852012"><a name="p1096794852012"></a><a name="p1096794852012"></a>√</p>
</td>
</tr>
<tr id="row173226882415"><td class="cellrowborder" valign="top" width="57.99999999999999%" headers="mcps1.1.3.1.1 "><p id="p14832120181815"><a name="p14832120181815"></a><a name="p14832120181815"></a><span id="ph1483216010188"><a name="ph1483216010188"></a><a name="ph1483216010188"></a><term id="zh-cn_topic_0000001312391781_term11962195213215"><a name="zh-cn_topic_0000001312391781_term11962195213215"></a><a name="zh-cn_topic_0000001312391781_term11962195213215"></a>Ascend 910B</term></span></p>
</td>
<td class="cellrowborder" align="center" valign="top" width="42%" headers="mcps1.1.3.1.2 "><p id="p179681483200"><a name="p179681483200"></a><a name="p179681483200"></a>√</p>
</td>
</tr>
</tbody>
</table>

## 功能说明<a name="section36583473819"></a>

设置Cache内存描述符，此接口调用完成后，会将源内存地址、内存大小记录到Cache内存描述符中。

## 函数原型<a name="section13230182415108"></a>

```
aclError aclrtCmoSetDesc(void *cmoDesc, void *src, size_t size)
```

## 参数说明<a name="section75395119104"></a>

<a name="zh-cn_topic_0122830089_table438764393513"></a>
<table><thead align="left"><tr id="zh-cn_topic_0122830089_row53871743113510"><th class="cellrowborder" valign="top" width="13.96%" id="mcps1.1.4.1.1"><p id="zh-cn_topic_0122830089_p1438834363520"><a name="zh-cn_topic_0122830089_p1438834363520"></a><a name="zh-cn_topic_0122830089_p1438834363520"></a>参数名</p>
</th>
<th class="cellrowborder" valign="top" width="14.04%" id="mcps1.1.4.1.2"><p id="p1769255516412"><a name="p1769255516412"></a><a name="p1769255516412"></a>输入/输出</p>
</th>
<th class="cellrowborder" valign="top" width="72%" id="mcps1.1.4.1.3"><p id="zh-cn_topic_0122830089_p173881843143514"><a name="zh-cn_topic_0122830089_p173881843143514"></a><a name="zh-cn_topic_0122830089_p173881843143514"></a>说明</p>
</th>
</tr>
</thead>
<tbody><tr id="zh-cn_topic_0122830089_row2038874343514"><td class="cellrowborder" valign="top" width="13.96%" headers="mcps1.1.4.1.1 "><p id="p8140124955"><a name="p8140124955"></a><a name="p8140124955"></a>cmoDesc</p>
</td>
<td class="cellrowborder" valign="top" width="14.04%" headers="mcps1.1.4.1.2 "><p id="p2251164322515"><a name="p2251164322515"></a><a name="p2251164322515"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="72%" headers="mcps1.1.4.1.3 "><p id="p1836515611014"><a name="p1836515611014"></a><a name="p1836515611014"></a><span>Cache内存描述符地址指针。</span></p>
<p id="p78331641101"><a name="p78331641101"></a><a name="p78331641101"></a><span>需先调用aclrtCmoGetDescSize接口获取Cache内存描述符所需的内存大小，再申请Device内存后（例如aclrtMalloc接口），将Device内存地址作为入参传入此处</span>。</p>
</td>
</tr>
<tr id="row15532816205615"><td class="cellrowborder" valign="top" width="13.96%" headers="mcps1.1.4.1.1 "><p id="p191381124654"><a name="p191381124654"></a><a name="p191381124654"></a>src</p>
</td>
<td class="cellrowborder" valign="top" width="14.04%" headers="mcps1.1.4.1.2 "><p id="p4252104372511"><a name="p4252104372511"></a><a name="p4252104372511"></a>输出</p>
</td>
<td class="cellrowborder" valign="top" width="72%" headers="mcps1.1.4.1.3 "><p id="p138471318114713"><a name="p138471318114713"></a><a name="p138471318114713"></a>待操作的Device内存地址。</p>
<p id="p19992336143812"><a name="p19992336143812"></a><a name="p19992336143812"></a>只支持本Device上的Cache内存操作。</p>
</td>
</tr>
<tr id="row59899432314"><td class="cellrowborder" valign="top" width="13.96%" headers="mcps1.1.4.1.1 "><p id="p19989941234"><a name="p19989941234"></a><a name="p19989941234"></a>size</p>
</td>
<td class="cellrowborder" valign="top" width="14.04%" headers="mcps1.1.4.1.2 "><p id="p425264315257"><a name="p425264315257"></a><a name="p425264315257"></a>输出</p>
</td>
<td class="cellrowborder" valign="top" width="72%" headers="mcps1.1.4.1.3 "><p id="p1584719183476"><a name="p1584719183476"></a><a name="p1584719183476"></a>待操作的Device内存大小，单位Byte。</p>
</td>
</tr>
</tbody>
</table>

## 返回值说明<a name="section25791320141317"></a>

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

