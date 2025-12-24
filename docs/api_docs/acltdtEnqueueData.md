# acltdtEnqueueData<a name="ZH-CN_TOPIC_0000001312721765"></a>

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

## 功能说明<a name="section93499471063"></a>

向队列中添加数据。

## 函数原型<a name="section14885205814615"></a>

```
aclError acltdtEnqueueData(uint32_t qid, const void *data, size_t dataSize, const void *userData, size_t userDataSize, int32_t timeout, uint32_t rsv)
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
<tbody><tr id="rac0b28977c28486084cd6002e34558ca"><td class="cellrowborder" valign="top" width="18%" headers="mcps1.1.4.1.1 "><p id="p9612134194212"><a name="p9612134194212"></a><a name="p9612134194212"></a>qid</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p13727193415110"><a name="p13727193415110"></a><a name="p13727193415110"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="68%" headers="mcps1.1.4.1.3 "><p id="p1172563414511"><a name="p1172563414511"></a><a name="p1172563414511"></a>需要添加数据的队列。</p>
<p id="p4429193394414"><a name="p4429193394414"></a><a name="p4429193394414"></a>队列需提前调用<a href="acltdtCreateQueue.md">acltdtCreateQueue</a>接口创建。</p>
</td>
</tr>
<tr id="row139744303510"><td class="cellrowborder" valign="top" width="18%" headers="mcps1.1.4.1.1 "><p id="p190393234719"><a name="p190393234719"></a><a name="p190393234719"></a>data</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p209758343512"><a name="p209758343512"></a><a name="p209758343512"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="68%" headers="mcps1.1.4.1.3 "><p id="p28319675317"><a name="p28319675317"></a><a name="p28319675317"></a>内存数据指针，支持Host侧或Device侧的内存。</p>
</td>
</tr>
<tr id="row18864667357"><td class="cellrowborder" valign="top" width="18%" headers="mcps1.1.4.1.1 "><p id="p64361816184616"><a name="p64361816184616"></a><a name="p64361816184616"></a>dataSize</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p1994642517469"><a name="p1994642517469"></a><a name="p1994642517469"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="68%" headers="mcps1.1.4.1.3 "><p id="p1964755610477"><a name="p1964755610477"></a><a name="p1964755610477"></a>内存数据大小，单位为Byte。</p>
</td>
</tr>
<tr id="row2462175544520"><td class="cellrowborder" valign="top" width="18%" headers="mcps1.1.4.1.1 "><p id="p1510517596469"><a name="p1510517596469"></a><a name="p1510517596469"></a>userData</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p164161126204617"><a name="p164161126204617"></a><a name="p164161126204617"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="68%" headers="mcps1.1.4.1.3 "><p id="p204631755124513"><a name="p204631755124513"></a><a name="p204631755124513"></a>用户自定义数据指针。</p>
<p id="p193561451151418"><a name="p193561451151418"></a><a name="p193561451151418"></a>若用户没有自定义数据，则传nullptr。</p>
</td>
</tr>
<tr id="row1282604469"><td class="cellrowborder" valign="top" width="18%" headers="mcps1.1.4.1.1 "><p id="p157441251154610"><a name="p157441251154610"></a><a name="p157441251154610"></a>userDataSize</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p1129027194617"><a name="p1129027194617"></a><a name="p1129027194617"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="68%" headers="mcps1.1.4.1.3 "><p id="p1428312044613"><a name="p1428312044613"></a><a name="p1428312044613"></a>用户自定义数据大小（&lt;=96Byte）。</p>
<p id="p1859515481315"><a name="p1859515481315"></a><a name="p1859515481315"></a>若用户没有自定义数据，则传0。</p>
</td>
</tr>
<tr id="row127621154612"><td class="cellrowborder" valign="top" width="18%" headers="mcps1.1.4.1.1 "><p id="p8865764354"><a name="p8865764354"></a><a name="p8865764354"></a>timeout</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p158652064353"><a name="p158652064353"></a><a name="p158652064353"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="68%" headers="mcps1.1.4.1.3 "><p id="p1063785917577"><a name="p1063785917577"></a><a name="p1063785917577"></a>等待超时时间。当队列满时，如果向队列中添加数据，系统内部会根据设置的等待超时时间来决定如何处理。</p>
<div class="p" id="p19168192614220"><a name="p19168192614220"></a><a name="p19168192614220"></a>该参数取值范围如下：<a name="ul106543915231"></a><a name="ul106543915231"></a><ul id="ul106543915231"><li>-1：阻塞方式，一直等待直到数据成功加入队列。</li><li>0：非阻塞方式（仅支持Device场景，Host场景无效），当队列满时，直接返回队列满这个错误，这时由用户自行设定重试间隔。</li><li>&gt;0：配置具体的超时时间，单位为毫秒。队列满时，等待达到超时时间后返回报错。<p id="p165811203493"><a name="p165811203493"></a><a name="p165811203493"></a>超时时间受操作系统影响，一般偏差在操作系统的一个时间片内，例如，操作系统的一个时间片为4ms，用户设置的超时时间为1ms，则实际的超时时间在1ms到5ms范围内。在CPU负载高场景下，超时时间仍可能存在波动。</p>
</li></ul>
</div>
</td>
</tr>
<tr id="row79220724612"><td class="cellrowborder" valign="top" width="18%" headers="mcps1.1.4.1.1 "><p id="p139210714462"><a name="p139210714462"></a><a name="p139210714462"></a>rsv</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p2529112814463"><a name="p2529112814463"></a><a name="p2529112814463"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="68%" headers="mcps1.1.4.1.3 "><p id="p15933744614"><a name="p15933744614"></a><a name="p15933744614"></a>预留参数，暂不支持。当前可设置为0。</p>
</td>
</tr>
</tbody>
</table>

## 返回值说明<a name="section17970231879"></a>

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

