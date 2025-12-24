# aclrtGetDeviceCapability<a name="ZH-CN_TOPIC_0000002305752333"></a>

## AI处理器支持情况<a name="section42891738171919"></a>

<a name="table38301303189"></a>
<table><thead align="left"><tr id="row20831180131817"><th class="cellrowborder" valign="top" width="57.99999999999999%" id="mcps1.1.3.1.1"><p id="p1883113061818"><a name="p1883113061818"></a><a name="p1883113061818"></a>产品</p>
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

查询支持的特性信息。

## 函数原型<a name="section13230182415108"></a>

```
aclError aclrtGetDeviceCapability(int32_t deviceId, aclrtDevFeatureType devFeatureType, int32_t *value)
```

## 参数说明<a name="section75395119104"></a>

<a name="zh-cn_topic_0122830089_table438764393513"></a>
<table><thead align="left"><tr id="zh-cn_topic_0122830089_row53871743113510"><th class="cellrowborder" valign="top" width="15%" id="mcps1.1.4.1.1"><p id="zh-cn_topic_0122830089_p1438834363520"><a name="zh-cn_topic_0122830089_p1438834363520"></a><a name="zh-cn_topic_0122830089_p1438834363520"></a>参数名</p>
</th>
<th class="cellrowborder" valign="top" width="15%" id="mcps1.1.4.1.2"><p id="p1769255516412"><a name="p1769255516412"></a><a name="p1769255516412"></a>输入/输出</p>
</th>
<th class="cellrowborder" valign="top" width="70%" id="mcps1.1.4.1.3"><p id="zh-cn_topic_0122830089_p173881843143514"><a name="zh-cn_topic_0122830089_p173881843143514"></a><a name="zh-cn_topic_0122830089_p173881843143514"></a>说明</p>
</th>
</tr>
</thead>
<tbody><tr id="row229712714517"><td class="cellrowborder" valign="top" width="15%" headers="mcps1.1.4.1.1 "><p id="p79081724131910"><a name="p79081724131910"></a><a name="p79081724131910"></a>deviceId</p>
</td>
<td class="cellrowborder" valign="top" width="15%" headers="mcps1.1.4.1.2 "><p id="p8908162411194"><a name="p8908162411194"></a><a name="p8908162411194"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="70%" headers="mcps1.1.4.1.3 "><p id="p103531551181012"><a name="p103531551181012"></a><a name="p103531551181012"></a>Device ID。</p>
<p id="p5103103751315"><a name="p5103103751315"></a><a name="p5103103751315"></a>用户调用<a href="aclrtGetDeviceCount.md">aclrtGetDeviceCount</a>接口获取可用的Device数量后，这个Device ID的取值范围：[0, (可用的Device数量-1)]。</p>
</td>
</tr>
<tr id="row944319391292"><td class="cellrowborder" valign="top" width="15%" headers="mcps1.1.4.1.1 "><p id="p844411391391"><a name="p844411391391"></a><a name="p844411391391"></a>devFeatureType</p>
</td>
<td class="cellrowborder" valign="top" width="15%" headers="mcps1.1.4.1.2 "><p id="p104445396917"><a name="p104445396917"></a><a name="p104445396917"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="70%" headers="mcps1.1.4.1.3 "><p id="p13359155216489"><a name="p13359155216489"></a><a name="p13359155216489"></a>特性类型。</p>
</td>
</tr>
<tr id="row151581712114917"><td class="cellrowborder" valign="top" width="15%" headers="mcps1.1.4.1.1 "><p id="p1159512164920"><a name="p1159512164920"></a><a name="p1159512164920"></a>value</p>
</td>
<td class="cellrowborder" valign="top" width="15%" headers="mcps1.1.4.1.2 "><p id="p915951213494"><a name="p915951213494"></a><a name="p915951213494"></a>输出</p>
</td>
<td class="cellrowborder" valign="top" width="70%" headers="mcps1.1.4.1.3 "><p id="p141591128499"><a name="p141591128499"></a><a name="p141591128499"></a>特性是否支持。</p>
<a name="ul4568816162314"></a><a name="ul4568816162314"></a><ul id="ul4568816162314"><li>ACL_DEV_FEATURE_NOT_SUPPORT(0)：不支持</li><li>ACL_DEV_FEATURE_SUPPORT(1)：支持</li></ul>
<p id="p139712369355"><a name="p139712369355"></a><a name="p139712369355"></a></p>
<p id="p12698122693511"><a name="p12698122693511"></a><a name="p12698122693511"></a>相关宏定义如下：</p>
<pre class="screen" id="screen169721737204919"><a name="screen169721737204919"></a><a name="screen169721737204919"></a>#define ACL_DEV_FEATURE_SUPPORT     0x00000001
#define ACL_DEV_FEATURE_NOT_SUPPORT 0x00000000</pre>
</td>
</tr>
</tbody>
</table>

## 返回值说明<a name="section25791320141317"></a>

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

