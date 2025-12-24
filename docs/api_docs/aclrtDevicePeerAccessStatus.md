# aclrtDevicePeerAccessStatus<a name="ZH-CN_TOPIC_0000002440463348"></a>

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
<td class="cellrowborder" align="center" valign="top" width="42%" headers="mcps1.1.3.1.2 "><p id="p3908123025613"><a name="p3908123025613"></a><a name="p3908123025613"></a>√</p>
</td>
</tr>
<tr id="row173226882415"><td class="cellrowborder" valign="top" width="57.99999999999999%" headers="mcps1.1.3.1.1 "><p id="p14832120181815"><a name="p14832120181815"></a><a name="p14832120181815"></a><span id="ph1483216010188"><a name="ph1483216010188"></a><a name="ph1483216010188"></a><term id="zh-cn_topic_0000001312391781_term11962195213215"><a name="zh-cn_topic_0000001312391781_term11962195213215"></a><a name="zh-cn_topic_0000001312391781_term11962195213215"></a>Ascend 910B</term></span></p>
</td>
<td class="cellrowborder" align="center" valign="top" width="42%" headers="mcps1.1.3.1.2 "><p id="p14907730155616"><a name="p14907730155616"></a><a name="p14907730155616"></a>√</p>
</td>
</tr>
</tbody>
</table>

## 功能说明<a name="section36583473819"></a>

查询两个Device之间的数据交互状态。

## 函数原型<a name="section13230182415108"></a>

```
aclError aclrtDevicePeerAccessStatus(int32_t deviceId, int32_t peerDeviceId, int32_t *status)
```

## 参数说明<a name="section75395119104"></a>

<a name="zh-cn_topic_0122830089_table438764393513"></a>
<table><thead align="left"><tr id="zh-cn_topic_0122830089_row53871743113510"><th class="cellrowborder" valign="top" width="14.000000000000002%" id="mcps1.1.4.1.1"><p id="zh-cn_topic_0122830089_p1438834363520"><a name="zh-cn_topic_0122830089_p1438834363520"></a><a name="zh-cn_topic_0122830089_p1438834363520"></a>参数名</p>
</th>
<th class="cellrowborder" valign="top" width="13.98%" id="mcps1.1.4.1.2"><p id="p1769255516412"><a name="p1769255516412"></a><a name="p1769255516412"></a>输入/输出</p>
</th>
<th class="cellrowborder" valign="top" width="72.02%" id="mcps1.1.4.1.3"><p id="zh-cn_topic_0122830089_p173881843143514"><a name="zh-cn_topic_0122830089_p173881843143514"></a><a name="zh-cn_topic_0122830089_p173881843143514"></a>说明</p>
</th>
</tr>
</thead>
<tbody><tr id="zh-cn_topic_0122830089_row2038874343514"><td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.1 "><p id="p76784121566"><a name="p76784121566"></a><a name="p76784121566"></a>deviceId</p>
</td>
<td class="cellrowborder" valign="top" width="13.98%" headers="mcps1.1.4.1.2 "><p id="p8676171217561"><a name="p8676171217561"></a><a name="p8676171217561"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="72.02%" headers="mcps1.1.4.1.3 "><p id="p99450379174"><a name="p99450379174"></a><a name="p99450379174"></a>指定Device的ID。</p>
<p id="p5103103751315"><a name="p5103103751315"></a><a name="p5103103751315"></a>用户调用<a href="aclrtGetDeviceCount.md">aclrtGetDeviceCount</a>接口获取可用的Device数量后，这个Device ID的取值范围：[0, (可用的Device数量-1)]</p>
</td>
</tr>
<tr id="row15532816205615"><td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.1 "><p id="p7532181615562"><a name="p7532181615562"></a><a name="p7532181615562"></a>peerDeviceId</p>
</td>
<td class="cellrowborder" valign="top" width="13.98%" headers="mcps1.1.4.1.2 "><p id="p125321916135615"><a name="p125321916135615"></a><a name="p125321916135615"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="72.02%" headers="mcps1.1.4.1.3 "><p id="p31135071714"><a name="p31135071714"></a><a name="p31135071714"></a>指定Device的ID。</p>
<p id="p38531631113012"><a name="p38531631113012"></a><a name="p38531631113012"></a>用户调用<a href="aclrtGetDeviceCount.md">aclrtGetDeviceCount</a>接口获取可用的Device数量后，这个Device ID的取值范围：[0, (可用的Device数量-1)]</p>
</td>
</tr>
<tr id="row797422214564"><td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.1 "><p id="p16974322165611"><a name="p16974322165611"></a><a name="p16974322165611"></a>status</p>
</td>
<td class="cellrowborder" valign="top" width="13.98%" headers="mcps1.1.4.1.2 "><p id="p1597518222568"><a name="p1597518222568"></a><a name="p1597518222568"></a>输出</p>
</td>
<td class="cellrowborder" valign="top" width="72.02%" headers="mcps1.1.4.1.3 "><p id="p1975122115617"><a name="p1975122115617"></a><a name="p1975122115617"></a>设备状态。0表示未开启数据交互；1表示已开启数据交互。</p>
</td>
</tr>
</tbody>
</table>

## 返回值说明<a name="section25791320141317"></a>

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

