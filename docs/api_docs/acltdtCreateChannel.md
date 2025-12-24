# acltdtCreateChannel<a name="ZH-CN_TOPIC_0000001264921694"></a>

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
<td class="cellrowborder" align="center" valign="top" width="42%" headers="mcps1.1.3.1.2 "><p id="p138701525164618"><a name="p138701525164618"></a><a name="p138701525164618"></a>☓</p>
</td>
</tr>
<tr id="row173226882415"><td class="cellrowborder" valign="top" width="57.99999999999999%" headers="mcps1.1.3.1.1 "><p id="p14832120181815"><a name="p14832120181815"></a><a name="p14832120181815"></a><span id="ph1483216010188"><a name="ph1483216010188"></a><a name="ph1483216010188"></a><term id="zh-cn_topic_0000001312391781_term11962195213215"><a name="zh-cn_topic_0000001312391781_term11962195213215"></a><a name="zh-cn_topic_0000001312391781_term11962195213215"></a>Ascend 910B</term></span></p>
</td>
<td class="cellrowborder" align="center" valign="top" width="42%" headers="mcps1.1.3.1.2 "><p id="p1088315258466"><a name="p1088315258466"></a><a name="p1088315258466"></a>☓</p>
</td>
</tr>
</tbody>
</table>

## 功能说明<a name="section36583473819"></a>

创建acltdtChannelHandle类型的数据，表示可以用于向Device发送数据或是从Device接收数据的通道。通道使用完成后，需及时依次调用[acltdtStopChannel](acltdtStopChannel.md)、[acltdtDestroyChannel](acltdtDestroyChannel.md)接口释放通道资源。

## 函数原型<a name="section13230182415108"></a>

```
acltdtChannelHandle *acltdtCreateChannel(uint32_t deviceId, const char *name)
```

## 参数说明<a name="section75395119104"></a>

<a name="table1527919256810"></a>
<table><thead align="left"><tr id="row227932516813"><th class="cellrowborder" valign="top" width="18%" id="mcps1.1.4.1.1"><p id="p132793252810"><a name="p132793252810"></a><a name="p132793252810"></a>参数名</p>
</th>
<th class="cellrowborder" valign="top" width="14.000000000000002%" id="mcps1.1.4.1.2"><p id="p15279225883"><a name="p15279225883"></a><a name="p15279225883"></a>输入/输出</p>
</th>
<th class="cellrowborder" valign="top" width="68%" id="mcps1.1.4.1.3"><p id="p1627918251083"><a name="p1627918251083"></a><a name="p1627918251083"></a>说明</p>
</th>
</tr>
</thead>
<tbody><tr id="row627902516814"><td class="cellrowborder" valign="top" width="18%" headers="mcps1.1.4.1.1 "><p id="p62799251187"><a name="p62799251187"></a><a name="p62799251187"></a>deviceId</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p328019251384"><a name="p328019251384"></a><a name="p328019251384"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="68%" headers="mcps1.1.4.1.3 "><p id="p14379124153614"><a name="p14379124153614"></a><a name="p14379124153614"></a>Device ID。</p>
<p id="p10280202514819"><a name="p10280202514819"></a><a name="p10280202514819"></a>用户调用<a href="aclrtGetDeviceCount.md">aclrtGetDeviceCount</a>接口获取可用的Device数量后，这个Device ID的取值范围：[0, (可用的Device数量-1)]</p>
</td>
</tr>
<tr id="row1062442714405"><td class="cellrowborder" valign="top" width="18%" headers="mcps1.1.4.1.1 "><p id="p4625112764017"><a name="p4625112764017"></a><a name="p4625112764017"></a>name</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p10625827154013"><a name="p10625827154013"></a><a name="p10625827154013"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="68%" headers="mcps1.1.4.1.3 "><p id="p1762522710407"><a name="p1762522710407"></a><a name="p1762522710407"></a>队列通道名称的指针。</p>
</td>
</tr>
</tbody>
</table>

## 返回值说明<a name="section25791320141317"></a>

-   返回acltdtChannelHandle类型的指针，表示成功。
-   返回nullptr，表示失败。

