# aclrtRegDeviceStateCallback<a name="ZH-CN_TOPIC_0000002440623236"></a>

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

注册Device状态回调函数，不支持重复注册。

当Device状态发生变化时（例如调用[aclrtSetDevice](aclrtSetDevice.md)、[aclrtResetDevice](aclrtResetDevice.md)等接口），Runtime模块会触发该回调函数的调用。

## 函数原型<a name="section13230182415108"></a>

```
aclError aclrtRegDeviceStateCallback(const char *regName, aclrtDeviceStateCallback callback, void *args)
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
<tbody><tr id="zh-cn_topic_0122830089_row2038874343514"><td class="cellrowborder" valign="top" width="13.96%" headers="mcps1.1.4.1.1 "><p id="p76784121566"><a name="p76784121566"></a><a name="p76784121566"></a>regName</p>
</td>
<td class="cellrowborder" valign="top" width="14.04%" headers="mcps1.1.4.1.2 "><p id="p8676171217561"><a name="p8676171217561"></a><a name="p8676171217561"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="72%" headers="mcps1.1.4.1.3 "><p id="p867311205619"><a name="p867311205619"></a><a name="p867311205619"></a>注册名称，保持唯一，不能为空，输入保证字符串以\0结尾。</p>
</td>
</tr>
<tr id="row15532816205615"><td class="cellrowborder" valign="top" width="13.96%" headers="mcps1.1.4.1.1 "><p id="p7532181615562"><a name="p7532181615562"></a><a name="p7532181615562"></a>callback</p>
</td>
<td class="cellrowborder" valign="top" width="14.04%" headers="mcps1.1.4.1.2 "><p id="p125321916135615"><a name="p125321916135615"></a><a name="p125321916135615"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="72%" headers="mcps1.1.4.1.3 "><p id="p124112717251"><a name="p124112717251"></a><a name="p124112717251"></a>回调函数。若callback不为NULL，则表示注册回调函数；若为NULL，则表示取消注册回调函数。</p>
<p id="p141921240134313"><a name="p141921240134313"></a><a name="p141921240134313"></a>回调函数的函数原型为：</p>
<pre class="screen" id="screen16986183315203"><a name="screen16986183315203"></a><a name="screen16986183315203"></a>typedef enum {
    ACL_RT_DEVICE_STATE_SET_PRE = 0, // 调用set接口之前（例如aclrtSetDevice）之后
    ACL_RT_DEVICE_STATE_SET_POST,    // 调用set接口之后（例如aclrtSetDevice）之后
    ACL_RT_DEVICE_STATE_RESET_PRE,   // 调用reset接口之前（例如aclrtResetDevice）之前
    ACL_RT_DEVICE_STATE_RESET_POST, // 调用reset接口之后（例如aclrtResetDevice）之前
} aclrtDeviceState;
typedef void (*aclrtDeviceStateCallback)(uint32_t devId, aclrtDeviceState state, void *args);</pre>
</td>
</tr>
<tr id="row797422214564"><td class="cellrowborder" valign="top" width="13.96%" headers="mcps1.1.4.1.1 "><p id="p16974322165611"><a name="p16974322165611"></a><a name="p16974322165611"></a>args</p>
</td>
<td class="cellrowborder" valign="top" width="14.04%" headers="mcps1.1.4.1.2 "><p id="p1597518222568"><a name="p1597518222568"></a><a name="p1597518222568"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="72%" headers="mcps1.1.4.1.3 "><p id="p164136586148"><a name="p164136586148"></a><a name="p164136586148"></a>待传递给回调函数的用户数据的指针。</p>
</td>
</tr>
</tbody>
</table>

## 返回值说明<a name="section25791320141317"></a>

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

