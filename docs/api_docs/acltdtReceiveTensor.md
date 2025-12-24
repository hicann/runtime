# acltdtReceiveTensor<a name="ZH-CN_TOPIC_0000001312641585"></a>

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

## 功能说明<a name="section5408205113614"></a>

在Host接收Device发过来的数据。

## 函数原型<a name="section632914018717"></a>

```
aclError acltdtReceiveTensor(const acltdtChannelHandle *handle, acltdtDataset *dataset, int32_t timeout)
```

## 参数说明<a name="section9911636710"></a>

<a name="table149756486454"></a>
<table><thead align="left"><tr id="row8975194864514"><th class="cellrowborder" valign="top" width="18%" id="mcps1.1.4.1.1"><p id="p1597512483455"><a name="p1597512483455"></a><a name="p1597512483455"></a>参数名</p>
</th>
<th class="cellrowborder" valign="top" width="14.000000000000002%" id="mcps1.1.4.1.2"><p id="p79751448134517"><a name="p79751448134517"></a><a name="p79751448134517"></a>输入/输出</p>
</th>
<th class="cellrowborder" valign="top" width="68%" id="mcps1.1.4.1.3"><p id="p1997534834512"><a name="p1997534834512"></a><a name="p1997534834512"></a>说明</p>
</th>
</tr>
</thead>
<tbody><tr id="row797544874513"><td class="cellrowborder" valign="top" width="18%" headers="mcps1.1.4.1.1 "><p id="p9975104814520"><a name="p9975104814520"></a><a name="p9975104814520"></a>handle</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p497514481453"><a name="p497514481453"></a><a name="p497514481453"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="68%" headers="mcps1.1.4.1.3 "><p id="p20918172612469"><a name="p20918172612469"></a><a name="p20918172612469"></a>指定通道。</p>
<p id="p12495195802811"><a name="p12495195802811"></a><a name="p12495195802811"></a>需提前调用<a href="acltdtCreateChannel.md">acltdtCreateChannel</a>接口或<a href="acltdtCreateChannelWithCapacity.md">acltdtCreateChannelWithCapacity</a>接口创建acltdtChannelHandle类型的数据。</p>
</td>
</tr>
<tr id="row1447012774515"><td class="cellrowborder" valign="top" width="18%" headers="mcps1.1.4.1.1 "><p id="p84701379451"><a name="p84701379451"></a><a name="p84701379451"></a>dataset</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p947017134517"><a name="p947017134517"></a><a name="p947017134517"></a>输出</p>
</td>
<td class="cellrowborder" valign="top" width="68%" headers="mcps1.1.4.1.3 "><p id="p15950151135019"><a name="p15950151135019"></a><a name="p15950151135019"></a>接收到的Device数据的指针。</p>
</td>
</tr>
<tr id="row8125911104518"><td class="cellrowborder" valign="top" width="18%" headers="mcps1.1.4.1.1 "><p id="p9125141164517"><a name="p9125141164517"></a><a name="p9125141164517"></a>timeout</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p19125131124519"><a name="p19125131124519"></a><a name="p19125131124519"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="68%" headers="mcps1.1.4.1.3 "><p id="p1063785917577"><a name="p1063785917577"></a><a name="p1063785917577"></a>等待超时时间。</p>
<div class="p" id="p19168192614220"><a name="p19168192614220"></a><a name="p19168192614220"></a>该参数取值范围如下：<a name="ul106543915231"></a><a name="ul106543915231"></a><ul id="ul106543915231"><li>-1：阻塞方式，一直等待直到数据接收完成。</li><li>0：非阻塞方式，当通道空时，直接返回通道空这个错误，这时由用户自行设定重试间隔。</li><li>&gt;0：配置具体的超时时间，单位为毫秒。通道空时，等待达到超时时间后返回报错。<p id="p19963185919481"><a name="p19963185919481"></a><a name="p19963185919481"></a>超时时间受操作系统影响，一般偏差在操作系统的一个时间片内，例如，操作系统的一个时间片为4ms，用户设置的超时时间为1ms，则实际的超时时间在1ms到5ms范围内。在CPU负载高场景下，超时时间仍可能存在波动。</p>
</li></ul>
</div>
</td>
</tr>
</tbody>
</table>

## 返回值说明<a name="section41841371675"></a>

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

