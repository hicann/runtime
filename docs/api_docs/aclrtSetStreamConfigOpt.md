# aclrtSetStreamConfigOpt<a name="ZH-CN_TOPIC_0000001622789973"></a>

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
<td class="cellrowborder" align="center" valign="top" width="42%" headers="mcps1.1.3.1.2 "><p id="p29627392493"><a name="p29627392493"></a><a name="p29627392493"></a>☓</p>
</td>
</tr>
<tr id="row173226882415"><td class="cellrowborder" valign="top" width="57.99999999999999%" headers="mcps1.1.3.1.1 "><p id="p14832120181815"><a name="p14832120181815"></a><a name="p14832120181815"></a><span id="ph1483216010188"><a name="ph1483216010188"></a><a name="ph1483216010188"></a><term id="zh-cn_topic_0000001312391781_term11962195213215"><a name="zh-cn_topic_0000001312391781_term11962195213215"></a><a name="zh-cn_topic_0000001312391781_term11962195213215"></a>Ascend 910B</term></span></p>
</td>
<td class="cellrowborder" align="center" valign="top" width="42%" headers="mcps1.1.3.1.2 "><p id="p139651539184910"><a name="p139651539184910"></a><a name="p139651539184910"></a>☓</p>
</td>
</tr>
</tbody>
</table>

## 功能说明<a name="section259105813316"></a>

设置Stream配置对象中的各属性的取值。

本接口需要配合其它接口一起使用，创建Stream，接口调用顺序如下：

1.  调用[aclrtCreateStreamConfigHandle](aclrtCreateStreamConfigHandle.md)接口创建Stream配置对象。
2.  多次调用aclrtSetStreamConfigOpt接口设置配置对象中每个属性的值。
3.  调用[aclrtCreateStreamV2](aclrtCreateStreamV2.md)接口创建Stream。
4.  Stream使用完成后，调用[aclrtDestroyStreamConfigHandle](aclrtDestroyStreamConfigHandle.md)接口销毁Stream配置对象，调用[aclrtDestroyStream](aclrtDestroyStream.md)接口销毁Stream。

## 函数原型<a name="section2067518173415"></a>

```
aclError aclrtSetStreamConfigOpt(aclrtStreamConfigHandle *handle, aclrtStreamConfigAttr attr, const void *attrValue, size_t valueSize)
```

## 参数说明<a name="section158061867342"></a>

<a name="zh-cn_topic_0122830089_table438764393513"></a>
<table><thead align="left"><tr id="zh-cn_topic_0122830089_row53871743113510"><th class="cellrowborder" valign="top" width="14.000000000000002%" id="mcps1.1.4.1.1"><p id="zh-cn_topic_0122830089_p1438834363520"><a name="zh-cn_topic_0122830089_p1438834363520"></a><a name="zh-cn_topic_0122830089_p1438834363520"></a>参数名</p>
</th>
<th class="cellrowborder" valign="top" width="14.000000000000002%" id="mcps1.1.4.1.2"><p id="p1769255516412"><a name="p1769255516412"></a><a name="p1769255516412"></a>输入/输出</p>
</th>
<th class="cellrowborder" valign="top" width="72%" id="mcps1.1.4.1.3"><p id="zh-cn_topic_0122830089_p173881843143514"><a name="zh-cn_topic_0122830089_p173881843143514"></a><a name="zh-cn_topic_0122830089_p173881843143514"></a>说明</p>
</th>
</tr>
</thead>
<tbody><tr id="row1919192774810"><td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.1 "><p id="p15161451803"><a name="p15161451803"></a><a name="p15161451803"></a>handle</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p115114513010"><a name="p115114513010"></a><a name="p115114513010"></a>输出</p>
</td>
<td class="cellrowborder" valign="top" width="72%" headers="mcps1.1.4.1.3 "><p id="p13605195465711"><a name="p13605195465711"></a><a name="p13605195465711"></a>Stream配置对象的指针。需提前调用<a href="aclrtCreateStreamConfigHandle.md">aclrtCreateStreamConfigHandle</a>接口创建该对象。</p>
</td>
</tr>
<tr id="row18987133142614"><td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.1 "><p id="p598883182618"><a name="p598883182618"></a><a name="p598883182618"></a>attr</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p14988938265"><a name="p14988938265"></a><a name="p14988938265"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="72%" headers="mcps1.1.4.1.3 "><p id="p159885382612"><a name="p159885382612"></a><a name="p159885382612"></a>指定需设置的属性。</p>
</td>
</tr>
<tr id="row617331362615"><td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.1 "><p id="p51732013102614"><a name="p51732013102614"></a><a name="p51732013102614"></a>attrValue</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p1217331362617"><a name="p1217331362617"></a><a name="p1217331362617"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="72%" headers="mcps1.1.4.1.3 "><p id="p41731213142610"><a name="p41731213142610"></a><a name="p41731213142610"></a>指向属性值的指针，attr对应的属性取值。</p>
<p id="p10451181712146"><a name="p10451181712146"></a><a name="p10451181712146"></a>如果属性值本身是指针，则传入该指针的地址。</p>
</td>
</tr>
<tr id="row18728717152617"><td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.1 "><p id="p37291917112616"><a name="p37291917112616"></a><a name="p37291917112616"></a>valueSize</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p10729217132618"><a name="p10729217132618"></a><a name="p10729217132618"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="72%" headers="mcps1.1.4.1.3 "><p id="p17729417122614"><a name="p17729417122614"></a><a name="p17729417122614"></a>attrValue部分的数据长度。</p>
<p id="p15101194111244"><a name="p15101194111244"></a><a name="p15101194111244"></a>用户可使用C/C++标准库的函数sizeof(*attrValue)查询数据长度。</p>
</td>
</tr>
</tbody>
</table>

## 返回值说明<a name="section15770391345"></a>

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

