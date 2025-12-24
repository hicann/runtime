# acltdtEnqueue<a name="ZH-CN_TOPIC_0000001265081702"></a>

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
<td class="cellrowborder" align="center" valign="top" width="42%" headers="mcps1.1.3.1.2 "><p id="p197162019489"><a name="p197162019489"></a><a name="p197162019489"></a>☓</p>
</td>
</tr>
<tr id="row173226882415"><td class="cellrowborder" valign="top" width="57.99999999999999%" headers="mcps1.1.3.1.1 "><p id="p14832120181815"><a name="p14832120181815"></a><a name="p14832120181815"></a><span id="ph1483216010188"><a name="ph1483216010188"></a><a name="ph1483216010188"></a><term id="zh-cn_topic_0000001312391781_term11962195213215"><a name="zh-cn_topic_0000001312391781_term11962195213215"></a><a name="zh-cn_topic_0000001312391781_term11962195213215"></a>Ascend 910B</term></span></p>
</td>
<td class="cellrowborder" align="center" valign="top" width="42%" headers="mcps1.1.3.1.2 "><p id="p1873202084816"><a name="p1873202084816"></a><a name="p1873202084816"></a>☓</p>
</td>
</tr>
</tbody>
</table>

## 功能说明<a name="section93499471063"></a>

向队列中添加数据，存放数据的内存必须调用[acltdtAllocBuf](acltdtAllocBuf.md)接口申请。

## 函数原型<a name="section14885205814615"></a>

```
aclError acltdtEnqueue(uint32_t qid, acltdtBuf buf, int32_t timeout)
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
<td class="cellrowborder" valign="top" width="68%" headers="mcps1.1.4.1.3 "><p id="p1172563414511"><a name="p1172563414511"></a><a name="p1172563414511"></a>需要添加数据的队列。</p>
<p id="p987965312432"><a name="p987965312432"></a><a name="p987965312432"></a>队列需提前调用<a href="acltdtCreateQueue.md">acltdtCreateQueue</a>接口创建。</p>
</td>
</tr>
<tr id="row139744303510"><td class="cellrowborder" valign="top" width="18%" headers="mcps1.1.4.1.1 "><p id="p1997573113510"><a name="p1997573113510"></a><a name="p1997573113510"></a>buf</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p209758343512"><a name="p209758343512"></a><a name="p209758343512"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="68%" headers="mcps1.1.4.1.3 "><p id="p179751234355"><a name="p179751234355"></a><a name="p179751234355"></a>共享Buffer指针。</p>
<p id="p18281899511"><a name="p18281899511"></a><a name="p18281899511"></a>该内存必须提前调用<a href="acltdtAllocBuf.md">acltdtAllocBuf</a>接口申请。</p>
</td>
</tr>
<tr id="row18864667357"><td class="cellrowborder" valign="top" width="18%" headers="mcps1.1.4.1.1 "><p id="p8865764354"><a name="p8865764354"></a><a name="p8865764354"></a>timeout</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p158652064353"><a name="p158652064353"></a><a name="p158652064353"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="68%" headers="mcps1.1.4.1.3 "><p id="p1063785917577"><a name="p1063785917577"></a><a name="p1063785917577"></a>等待超时时间。当队列满时，如果向队列中添加数据，系统内部会根据设置的等待超时时间来决定如何处理。</p>
<div class="p" id="p19168192614220"><a name="p19168192614220"></a><a name="p19168192614220"></a>该参数取值范围如下：<a name="ul106543915231"></a><a name="ul106543915231"></a><ul id="ul106543915231"><li>-1：阻塞方式，一直等待直到数据成功加入队列。</li><li>0：非阻塞方式，当队列满时，直接返回队列满这个错误，这时由用户自行设定重试间隔。</li><li>&gt;0：配置具体的超时时间，单位为毫秒。队列满时，等待达到超时时间后返回报错。<p id="p89381216195012"><a name="p89381216195012"></a><a name="p89381216195012"></a>超时时间受操作系统影响，一般偏差在操作系统的一个时间片内，例如，操作系统的一个时间片为4ms，用户设置的超时时间为1ms，则实际的超时时间在1ms到5ms范围内。在CPU负载高场景下，超时时间仍可能存在波动。</p>
</li></ul>
</div>
</td>
</tr>
</tbody>
</table>

## 返回值说明<a name="section17970231879"></a>

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

