# acltdtAttachQueue<a name="ZH-CN_TOPIC_0000001265400254"></a>

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
<td class="cellrowborder" align="center" valign="top" width="42%" headers="mcps1.1.3.1.2 "><p id="p169731658499"><a name="p169731658499"></a><a name="p169731658499"></a>☓</p>
</td>
</tr>
<tr id="row173226882415"><td class="cellrowborder" valign="top" width="57.99999999999999%" headers="mcps1.1.3.1.1 "><p id="p14832120181815"><a name="p14832120181815"></a><a name="p14832120181815"></a><span id="ph1483216010188"><a name="ph1483216010188"></a><a name="ph1483216010188"></a><term id="zh-cn_topic_0000001312391781_term11962195213215"><a name="zh-cn_topic_0000001312391781_term11962195213215"></a><a name="zh-cn_topic_0000001312391781_term11962195213215"></a>Ascend 910B</term></span></p>
</td>
<td class="cellrowborder" align="center" valign="top" width="42%" headers="mcps1.1.3.1.2 "><p id="p19750534913"><a name="p19750534913"></a><a name="p19750534913"></a>☓</p>
</td>
</tr>
</tbody>
</table>

## 功能说明<a name="section93499471063"></a>

进程间需要共享队列信息时，在被授权的进程中调用本接口确认当前进程对队列有相应权限。

## 函数原型<a name="section14885205814615"></a>

```
aclError acltdtAttachQueue(uint32_t qid, int32_t timeout, uint32_t *permission)
```

## 参数说明<a name="section137351420523"></a>

<a name="table73733144524"></a>
<table><thead align="left"><tr id="row5373161412520"><th class="cellrowborder" valign="top" width="18%" id="mcps1.1.4.1.1"><p id="p3373314145210"><a name="p3373314145210"></a><a name="p3373314145210"></a>参数名</p>
</th>
<th class="cellrowborder" valign="top" width="14.000000000000002%" id="mcps1.1.4.1.2"><p id="p113731414155218"><a name="p113731414155218"></a><a name="p113731414155218"></a>输入/输出</p>
</th>
<th class="cellrowborder" valign="top" width="68%" id="mcps1.1.4.1.3"><p id="p137311455216"><a name="p137311455216"></a><a name="p137311455216"></a>说明</p>
</th>
</tr>
</thead>
<tbody><tr id="row637319145528"><td class="cellrowborder" valign="top" width="18%" headers="mcps1.1.4.1.1 "><p id="p1837331425218"><a name="p1837331425218"></a><a name="p1837331425218"></a>qid</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p1337319142521"><a name="p1337319142521"></a><a name="p1337319142521"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="68%" headers="mcps1.1.4.1.3 "><p id="p137311475210"><a name="p137311475210"></a><a name="p137311475210"></a>队列ID。</p>
</td>
</tr>
<tr id="row387184718526"><td class="cellrowborder" valign="top" width="18%" headers="mcps1.1.4.1.1 "><p id="p126915313521"><a name="p126915313521"></a><a name="p126915313521"></a>timeout</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p15709538523"><a name="p15709538523"></a><a name="p15709538523"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="68%" headers="mcps1.1.4.1.3 "><div class="p" id="p333813313531"><a name="p333813313531"></a><a name="p333813313531"></a>等待超时时间，取值范围如下：<a name="ul53389385314"></a><a name="ul53389385314"></a><ul id="ul53389385314"><li>-1：阻塞方式，一直等待直到数据成功加入队列。</li><li>0：非阻塞方式，立即返回。</li><li>&gt;0：配置具体的超时时间，单位为毫秒，等达到超时时间后返回报错。<p id="p1569614715517"><a name="p1569614715517"></a><a name="p1569614715517"></a>超时时间受操作系统影响，一般偏差在操作系统的一个时间片内，例如，操作系统的一个时间片为4ms，用户设置的超时时间为1ms，则实际的超时时间在1ms到5ms范围内。在CPU负载高场景下，超时时间仍可能存在波动。</p>
</li></ul>
</div>
</td>
</tr>
<tr id="row6241111674412"><td class="cellrowborder" valign="top" width="18%" headers="mcps1.1.4.1.1 "><p id="p16241216164414"><a name="p16241216164414"></a><a name="p16241216164414"></a>permission</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p16241151620444"><a name="p16241151620444"></a><a name="p16241151620444"></a>输出</p>
</td>
<td class="cellrowborder" valign="top" width="68%" headers="mcps1.1.4.1.3 "><p id="p20997132411415"><a name="p20997132411415"></a><a name="p20997132411415"></a>权限标识。</p>
<a name="ul15381743114116"></a><a name="ul15381743114116"></a><ul id="ul15381743114116"><li>根据输出参数值的最后一个bit位判断是否有管理权限，0就是没有，1就是有。</li><li>根据输出参数值的倒数第二个bit位判断是否有从队列中获取数据的权限，0就是没有，1就是有。</li><li>根据输出参数值的倒数第三个bit位判断是否有向队列中添加数据的权限，0就是没有，1就是有。</li></ul>
</td>
</tr>
</tbody>
</table>

## 返回值说明<a name="section17970231879"></a>

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

