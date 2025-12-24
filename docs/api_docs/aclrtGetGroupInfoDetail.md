# aclrtGetGroupInfoDetail<a name="ZH-CN_TOPIC_0000001312721617"></a>

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
<td class="cellrowborder" align="center" valign="top" width="42%" headers="mcps1.1.3.1.2 "><p id="p10228181371"><a name="p10228181371"></a><a name="p10228181371"></a>☓</p>
</td>
</tr>
<tr id="row173226882415"><td class="cellrowborder" valign="top" width="57.99999999999999%" headers="mcps1.1.3.1.1 "><p id="p14832120181815"><a name="p14832120181815"></a><a name="p14832120181815"></a><span id="ph1483216010188"><a name="ph1483216010188"></a><a name="ph1483216010188"></a><term id="zh-cn_topic_0000001312391781_term11962195213215"><a name="zh-cn_topic_0000001312391781_term11962195213215"></a><a name="zh-cn_topic_0000001312391781_term11962195213215"></a>Ascend 910B</term></span></p>
</td>
<td class="cellrowborder" align="center" valign="top" width="42%" headers="mcps1.1.3.1.2 "><p id="p5254181172"><a name="p5254181172"></a><a name="p5254181172"></a>☓</p>
</td>
</tr>
</tbody>
</table>

## 功能说明<a name="section36583473819"></a>

查询当前Context下指定Group的算力信息。

## 函数原型<a name="section13230182415108"></a>

```
aclError  aclrtGetGroupInfoDetail(const aclrtGroupInfo *groupInfo, int32_t groupIndex, aclrtGroupAttr attr, void *attrValue, size_t valueLen, size_t *paramRetSize)
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
<tbody><tr id="zh-cn_topic_0122830089_row2038874343514"><td class="cellrowborder" valign="top" width="18%" headers="mcps1.1.4.1.1 "><p id="p116115286175"><a name="p116115286175"></a><a name="p116115286175"></a>groupInfo</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p1760828181716"><a name="p1760828181716"></a><a name="p1760828181716"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="68%" headers="mcps1.1.4.1.3 "><p id="p1867515487295"><a name="p1867515487295"></a><a name="p1867515487295"></a>指定算力详细信息的首地址的指针。</p>
<p id="p1385819353440"><a name="p1385819353440"></a><a name="p1385819353440"></a>需提前调用<a href="aclrtGetAllGroupInfo.md">aclrtGetAllGroupInfo</a>接口获取所有Group的算力信息。</p>
</td>
</tr>
<tr id="row16644185921318"><td class="cellrowborder" valign="top" width="18%" headers="mcps1.1.4.1.1 "><p id="p133231302451"><a name="p133231302451"></a><a name="p133231302451"></a>groupIndex</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p18645165971310"><a name="p18645165971310"></a><a name="p18645165971310"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="68%" headers="mcps1.1.4.1.3 "><p id="p11568753162516"><a name="p11568753162516"></a><a name="p11568753162516"></a>访问groupInfo连续内存块的Group索引。</p>
<p id="p0568253102517"><a name="p0568253102517"></a><a name="p0568253102517"></a>Group索引的取值范围：[0, (Group数量-1)]，用户可调用<a href="aclrtGetGroupCount.md">aclrtGetGroupCount</a>接口获取Group数量。</p>
</td>
</tr>
<tr id="row10953195143113"><td class="cellrowborder" valign="top" width="18%" headers="mcps1.1.4.1.1 "><p id="p695418520315"><a name="p695418520315"></a><a name="p695418520315"></a>attr</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p78571442153120"><a name="p78571442153120"></a><a name="p78571442153120"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="68%" headers="mcps1.1.4.1.3 "><p id="p159541556313"><a name="p159541556313"></a><a name="p159541556313"></a>指定要获取其算力值的算力属性。</p>
</td>
</tr>
<tr id="row6451131718336"><td class="cellrowborder" valign="top" width="18%" headers="mcps1.1.4.1.1 "><p id="p144513172338"><a name="p144513172338"></a><a name="p144513172338"></a>attrValue</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p945181717331"><a name="p945181717331"></a><a name="p945181717331"></a>输出</p>
</td>
<td class="cellrowborder" valign="top" width="68%" headers="mcps1.1.4.1.3 "><p id="p645131773314"><a name="p645131773314"></a><a name="p645131773314"></a>获取指定算力属性所对应的算力值的指针。</p>
<p id="p1589862455114"><a name="p1589862455114"></a><a name="p1589862455114"></a>用户需根据每个属性的属性值数据类型申请对应大小的内存，用于存放属性值。</p>
</td>
</tr>
<tr id="row611711540"><td class="cellrowborder" valign="top" width="18%" headers="mcps1.1.4.1.1 "><p id="p1211811112419"><a name="p1211811112419"></a><a name="p1211811112419"></a>valueLen</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p19118191147"><a name="p19118191147"></a><a name="p19118191147"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="68%" headers="mcps1.1.4.1.3 "><p id="p511814113418"><a name="p511814113418"></a><a name="p511814113418"></a>表示attrValue的最大长度，单位为Byte。</p>
</td>
</tr>
<tr id="row0715203344311"><td class="cellrowborder" valign="top" width="18%" headers="mcps1.1.4.1.1 "><p id="p071514333432"><a name="p071514333432"></a><a name="p071514333432"></a>paramRetSize</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p471673310431"><a name="p471673310431"></a><a name="p471673310431"></a>输出</p>
</td>
<td class="cellrowborder" valign="top" width="68%" headers="mcps1.1.4.1.3 "><p id="p7716113314432"><a name="p7716113314432"></a><a name="p7716113314432"></a>实际返回的attrValue大小的指针，单位为Byte。</p>
</td>
</tr>
</tbody>
</table>

## 返回值说明<a name="section25791320141317"></a>

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

