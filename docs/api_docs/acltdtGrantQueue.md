# acltdtGrantQueue<a name="ZH-CN_TOPIC_0000001264921834"></a>

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
<td class="cellrowborder" align="center" valign="top" width="42%" headers="mcps1.1.3.1.2 "><p id="p164311551487"><a name="p164311551487"></a><a name="p164311551487"></a>☓</p>
</td>
</tr>
<tr id="row173226882415"><td class="cellrowborder" valign="top" width="57.99999999999999%" headers="mcps1.1.3.1.1 "><p id="p14832120181815"><a name="p14832120181815"></a><a name="p14832120181815"></a><span id="ph1483216010188"><a name="ph1483216010188"></a><a name="ph1483216010188"></a><term id="zh-cn_topic_0000001312391781_term11962195213215"><a name="zh-cn_topic_0000001312391781_term11962195213215"></a><a name="zh-cn_topic_0000001312391781_term11962195213215"></a>Ascend 910B</term></span></p>
</td>
<td class="cellrowborder" align="center" valign="top" width="42%" headers="mcps1.1.3.1.2 "><p id="p4432125515485"><a name="p4432125515485"></a><a name="p4432125515485"></a>☓</p>
</td>
</tr>
</tbody>
</table>

## 功能说明<a name="section93499471063"></a>

进程间需要共享队列信息时，可以调用本接口给其它进程授予队列相关的权限，例如Enqueue（指向队列中添加数据）权限、Dequeue（指从队列中获取数据）权限等。

进程间传递队列相关信息时，安全性由用户保证。

## 函数原型<a name="section14885205814615"></a>

```
aclError acltdtGrantQueue(uint32_t qid, int32_t pid, uint32_t permission, int32_t timeout)
```

## 参数说明<a name="section31916522610"></a>

<a name="t7578495d685c4a90bce9c97d867977d6"></a>
<table><thead align="left"><tr id="r2d1a1bf4a62d4919b78beceb6f54a2b5"><th class="cellrowborder" valign="top" width="18%" id="mcps1.1.4.1.1"><p id="a0ef8a1f61ce94163847db2d50aadf417"><a name="a0ef8a1f61ce94163847db2d50aadf417"></a><a name="a0ef8a1f61ce94163847db2d50aadf417"></a>参数名</p>
</th>
<th class="cellrowborder" valign="top" width="14.000000000000002%" id="mcps1.1.4.1.2"><p id="p1769255516412"><a name="p1769255516412"></a><a name="p1769255516412"></a>输入/输出</p>
</th>
<th class="cellrowborder" valign="top" width="68%" id="mcps1.1.4.1.3"><p id="aa32c26db853f48c09906042f64b95091"><a name="aa32c26db853f48c09906042f64b95091"></a><a name="aa32c26db853f48c09906042f64b95091"></a>说明</p>
</th>
</tr>
</thead>
<tbody><tr id="rac0b28977c28486084cd6002e34558ca"><td class="cellrowborder" valign="top" width="18%" headers="mcps1.1.4.1.1 "><p id="p472843475119"><a name="p472843475119"></a><a name="p472843475119"></a>qid</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p13727193415110"><a name="p13727193415110"></a><a name="p13727193415110"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="68%" headers="mcps1.1.4.1.3 "><p id="p1172563414511"><a name="p1172563414511"></a><a name="p1172563414511"></a>队列ID。</p>
</td>
</tr>
<tr id="row1332097114411"><td class="cellrowborder" valign="top" width="18%" headers="mcps1.1.4.1.1 "><p id="p1320147124415"><a name="p1320147124415"></a><a name="p1320147124415"></a>pid</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p3320157154416"><a name="p3320157154416"></a><a name="p3320157154416"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="68%" headers="mcps1.1.4.1.3 "><p id="p173201764419"><a name="p173201764419"></a><a name="p173201764419"></a>被授权进程的ID。</p>
</td>
</tr>
<tr id="row6241111674412"><td class="cellrowborder" valign="top" width="18%" headers="mcps1.1.4.1.1 "><p id="p16241216164414"><a name="p16241216164414"></a><a name="p16241216164414"></a>permission</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p16241151620444"><a name="p16241151620444"></a><a name="p16241151620444"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="68%" headers="mcps1.1.4.1.3 "><p id="p824171634415"><a name="p824171634415"></a><a name="p824171634415"></a>权限标识（队列生产者/消费者）。</p>
<p id="p123351050102719"><a name="p123351050102719"></a><a name="p123351050102719"></a>用户选择如下多个宏进行逻辑或（例如：ACL_TDT_QUEUE_PERMISSION_DEQUEUE | ACL_TDT_QUEUE_PERMISSION_ENQUEUE），作为permission参数值。每个宏表示某一权限，详细说明如下：</p>
<a name="ul648820489306"></a><a name="ul648820489306"></a><ul id="ul648820489306"><li>ACL_TDT_QUEUE_PERMISSION_MANAGE：表示队列的管理权限。</li><li>ACL_TDT_QUEUE_PERMISSION_DEQUEUE：表示Dequeue权限。</li><li>ACL_TDT_QUEUE_PERMISSION_ENQUEUE：表示Enqueue权限。</li></ul>
</td>
</tr>
<tr id="row199691218154411"><td class="cellrowborder" valign="top" width="18%" headers="mcps1.1.4.1.1 "><p id="p1496951844419"><a name="p1496951844419"></a><a name="p1496951844419"></a>timeout</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p7969181894420"><a name="p7969181894420"></a><a name="p7969181894420"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="68%" headers="mcps1.1.4.1.3 "><div class="p" id="p19168192614220"><a name="p19168192614220"></a><a name="p19168192614220"></a>等待超时时间，取值范围如下：<a name="ul106543915231"></a><a name="ul106543915231"></a><ul id="ul106543915231"><li>-1：阻塞方式，一直等待直到数据成功加入队列。</li><li>0：非阻塞方式，立即返回。</li><li>&gt;0：配置具体的超时时间，单位为毫秒，等达到超时时间后返回报错。<p id="p63734315114"><a name="p63734315114"></a><a name="p63734315114"></a>超时时间受操作系统影响，一般偏差在操作系统的一个时间片内，例如，操作系统的一个时间片为4ms，用户设置的超时时间为1ms，则实际的超时时间在1ms到5ms范围内。在CPU负载高场景下，超时时间仍可能存在波动。</p>
</li></ul>
</div>
</td>
</tr>
</tbody>
</table>

## 返回值说明<a name="section17970231879"></a>

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

