# aclmdlRICaptureBegin<a name="ZH-CN_TOPIC_0000002186835202"></a>

**须知：本接口为试验特性，后续版本可能会存在变更，不支持应用于商用产品中。**

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

开始捕获Stream上下发的任务。

在aclmdlRICaptureBegin和[aclmdlRICaptureEnd](aclmdlRICaptureEnd.md)接口之间，所有在指定Stream上下发的任务不会立即执行，而是被暂存在系统内部模型运行实例中，只有在调用[aclmdlRIExecute](aclmdlRIExecute.md)或[aclmdlRIExecuteAsync](aclmdlRIExecuteAsync.md)接口执行模型推理时，这些任务才会被真正执行，以此减少Host侧的任务下发开销。所有任务执行完毕后，若无需再使用内部模型，可调用[aclmdlRIDestroy](aclmdlRIDestroy.md)接口及时销毁该资源。

aclmdlRICaptureBegin和[aclmdlRICaptureEnd](aclmdlRICaptureEnd.md)接口要成对使用，且两个接口中的Stream应相同。在这两个接口之间，可以调用[aclmdlRICaptureGetInfo](aclmdlRICaptureGetInfo.md)接口获取捕获信息，调用[aclmdlRICaptureThreadExchangeMode](aclmdlRICaptureThreadExchangeMode.md)接口切换当前线程的捕获模式。此外，在调用[aclmdlRICaptureEnd](aclmdlRICaptureEnd.md)接口之后，还可以调用[aclmdlRIDebugPrint](aclmdlRIDebugPrint.md)接口打印模型信息，这在维护和测试场景下有助于问题定位。

在aclmdlRICaptureBegin和[aclmdlRICaptureEnd](aclmdlRICaptureEnd.md)接口之间捕获的任务，若要更新任务（包含任务本身以及任务的参数信息），则需在[aclmdlRICaptureTaskGrpBegin](aclmdlRICaptureTaskGrpBegin.md)、[aclmdlRICaptureTaskGrpEnd](aclmdlRICaptureTaskGrpEnd.md)接口之间下发后续可能更新的任务，给任务打上任务组的标记，然后在[aclmdlRICaptureTaskUpdateBegin](aclmdlRICaptureTaskUpdateBegin.md)、[aclmdlRICaptureTaskUpdateEnd](aclmdlRICaptureTaskUpdateEnd.md)接口之间更新任务的输入信息。

在aclmdlRICaptureBegin和[aclmdlRICaptureEnd](aclmdlRICaptureEnd.md)接口之间捕获到的任务会暂存在系统内部模型运行实例中，随着任务数量的增加，以及通过Event推导、内部任务的操作，导致更多的Stream进入捕获状态，Stream资源被不断消耗，最终可能会导致Stream资源不足（Stream数量限制请参见[aclrtCreateStream](aclrtCreateStream.md)），因此需提前规划好Stream的使用、关注捕获的任务数量。

## 函数原型<a name="section13230182415108"></a>

```
aclError aclmdlRICaptureBegin(aclrtStream stream, aclmdlRICaptureMode mode)
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
<tbody><tr id="zh-cn_topic_0122830089_row2038874343514"><td class="cellrowborder" valign="top" width="15%" headers="mcps1.1.4.1.1 "><p id="p14910142411910"><a name="p14910142411910"></a><a name="p14910142411910"></a>stream</p>
</td>
<td class="cellrowborder" valign="top" width="15%" headers="mcps1.1.4.1.2 "><p id="p1909192411917"><a name="p1909192411917"></a><a name="p1909192411917"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="70%" headers="mcps1.1.4.1.3 "><p id="p1390972415197"><a name="p1390972415197"></a><a name="p1390972415197"></a>指定Stream。</p>
</td>
</tr>
<tr id="row229712714517"><td class="cellrowborder" valign="top" width="15%" headers="mcps1.1.4.1.1 "><p id="p79081724131910"><a name="p79081724131910"></a><a name="p79081724131910"></a>mode</p>
</td>
<td class="cellrowborder" valign="top" width="15%" headers="mcps1.1.4.1.2 "><p id="p8908162411194"><a name="p8908162411194"></a><a name="p8908162411194"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="70%" headers="mcps1.1.4.1.3 "><p id="p1482414195424"><a name="p1482414195424"></a><a name="p1482414195424"></a>捕获模式，用于限制非安全函数（包括aclrtMemset、aclrtMemcpy、aclrtMemcpy2d）的调用范围。</p>
</td>
</tr>
</tbody>
</table>

## 返回值说明<a name="section25791320141317"></a>

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

