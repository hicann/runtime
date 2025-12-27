# aclrtCreateStreamWithConfig<a name="ZH-CN_TOPIC_0000001473505705"></a>

## AI处理器支持情况<a name="section15254644421"></a>

<a name="zh-cn_topic_0000002219420921_table14931115524110"></a>
<table><thead align="left"><tr id="zh-cn_topic_0000002219420921_row1993118556414"><th class="cellrowborder" valign="top" width="57.99999999999999%" id="mcps1.1.3.1.1"><p id="zh-cn_topic_0000002219420921_p29315553419"><a name="zh-cn_topic_0000002219420921_p29315553419"></a><a name="zh-cn_topic_0000002219420921_p29315553419"></a><span id="zh-cn_topic_0000002219420921_ph59311455164119"><a name="zh-cn_topic_0000002219420921_ph59311455164119"></a><a name="zh-cn_topic_0000002219420921_ph59311455164119"></a>AI处理器类型</span></p>
</th>
<th class="cellrowborder" align="center" valign="top" width="42%" id="mcps1.1.3.1.2"><p id="zh-cn_topic_0000002219420921_p59313557417"><a name="zh-cn_topic_0000002219420921_p59313557417"></a><a name="zh-cn_topic_0000002219420921_p59313557417"></a>是否支持</p>
</th>
</tr>
</thead>
<tbody><tr id="zh-cn_topic_0000002219420921_row1693117553411"><td class="cellrowborder" valign="top" width="57.99999999999999%" headers="mcps1.1.3.1.1 "><p id="zh-cn_topic_0000002219420921_p1493195513412"><a name="zh-cn_topic_0000002219420921_p1493195513412"></a><a name="zh-cn_topic_0000002219420921_p1493195513412"></a><span id="zh-cn_topic_0000002219420921_ph1093110555418"><a name="zh-cn_topic_0000002219420921_ph1093110555418"></a><a name="zh-cn_topic_0000002219420921_ph1093110555418"></a><term id="zh-cn_topic_0000002219420921_zh-cn_topic_0000001312391781_term1253731311225"><a name="zh-cn_topic_0000002219420921_zh-cn_topic_0000001312391781_term1253731311225"></a><a name="zh-cn_topic_0000002219420921_zh-cn_topic_0000001312391781_term1253731311225"></a>Ascend 910C</term></span></p>
</td>
<td class="cellrowborder" align="center" valign="top" width="42%" headers="mcps1.1.3.1.2 "><p id="zh-cn_topic_0000002219420921_p20931175524111"><a name="zh-cn_topic_0000002219420921_p20931175524111"></a><a name="zh-cn_topic_0000002219420921_p20931175524111"></a>√</p>
</td>
</tr>
<tr id="zh-cn_topic_0000002219420921_row199312559416"><td class="cellrowborder" valign="top" width="57.99999999999999%" headers="mcps1.1.3.1.1 "><p id="zh-cn_topic_0000002219420921_p0931555144119"><a name="zh-cn_topic_0000002219420921_p0931555144119"></a><a name="zh-cn_topic_0000002219420921_p0931555144119"></a><span id="zh-cn_topic_0000002219420921_ph1693115559411"><a name="zh-cn_topic_0000002219420921_ph1693115559411"></a><a name="zh-cn_topic_0000002219420921_ph1693115559411"></a><term id="zh-cn_topic_0000002219420921_zh-cn_topic_0000001312391781_term11962195213215"><a name="zh-cn_topic_0000002219420921_zh-cn_topic_0000001312391781_term11962195213215"></a><a name="zh-cn_topic_0000002219420921_zh-cn_topic_0000001312391781_term11962195213215"></a>Ascend 910B</term></span></p>
</td>
<td class="cellrowborder" align="center" valign="top" width="42%" headers="mcps1.1.3.1.2 "><p id="zh-cn_topic_0000002219420921_p129321955154117"><a name="zh-cn_topic_0000002219420921_p129321955154117"></a><a name="zh-cn_topic_0000002219420921_p129321955154117"></a>√</p>
</td>
</tr>
</tbody>
</table>

## 功能说明<a name="section36583473819"></a>

在当前进程或线程中创建Stream。

Ascend 910C，相比[aclrtCreateStream](aclrtCreateStream.md)接口，使用本接口可以创建一个快速下发任务的Stream，但会增加内存消耗或CPU的性能消耗。

Ascend 910B，相比[aclrtCreateStream](aclrtCreateStream.md)接口，使用本接口可以创建一个快速下发任务的Stream，但会增加内存消耗或CPU的性能消耗。

## 函数原型<a name="section13230182415108"></a>

```
aclError aclrtCreateStreamWithConfig(aclrtStream *stream, uint32_t priority, uint32_t flag)
```

## 参数说明<a name="section75395119104"></a>

<a name="zh-cn_topic_0122830089_table438764393513"></a>
<table><thead align="left"><tr id="zh-cn_topic_0122830089_row53871743113510"><th class="cellrowborder" valign="top" width="14.000000000000002%" id="mcps1.1.4.1.1"><p id="zh-cn_topic_0122830089_p1438834363520"><a name="zh-cn_topic_0122830089_p1438834363520"></a><a name="zh-cn_topic_0122830089_p1438834363520"></a>参数名</p>
</th>
<th class="cellrowborder" valign="top" width="14.000000000000002%" id="mcps1.1.4.1.2"><p id="p1769255516412"><a name="p1769255516412"></a><a name="p1769255516412"></a>输入/输出</p>
</th>
<th class="cellrowborder" valign="top" width="72%" id="mcps1.1.4.1.3"><p id="zh-cn_topic_0122830089_p173881843143514"><a name="zh-cn_topic_0122830089_p173881843143514"></a><a name="zh-cn_topic_0122830089_p173881843143514"></a>说明</p>
</th>
</tr>
</thead>
<tbody><tr id="zh-cn_topic_0122830089_row2038874343514"><td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.1 "><p id="p116115286175"><a name="p116115286175"></a><a name="p116115286175"></a>stream</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p1760828181716"><a name="p1760828181716"></a><a name="p1760828181716"></a>输出</p>
</td>
<td class="cellrowborder" valign="top" width="72%" headers="mcps1.1.4.1.3 "><p id="p11581028101716"><a name="p11581028101716"></a><a name="p11581028101716"></a>Stream的指针。</p>
</td>
</tr>
<tr id="row1893814238124"><td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.1 "><p id="p141661531121211"><a name="p141661531121211"></a><a name="p141661531121211"></a>priority</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p516663131214"><a name="p516663131214"></a><a name="p516663131214"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="72%" headers="mcps1.1.4.1.3 "><p id="p14166153118122"><a name="p14166153118122"></a><a name="p14166153118122"></a>优先级。</p>
<p id="p8519125910341"><a name="p8519125910341"></a><a name="p8519125910341"></a>对以下产品，该参数为预留参数，暂不使用，当前固定设置为0：</p>
<a name="ul1647914285370"></a><a name="ul1647914285370"></a><ul id="ul1647914285370"><li><span id="ph583230201815"><a name="ph583230201815"></a><a name="ph583230201815"></a><term id="zh-cn_topic_0000001312391781_term1253731311225_1"><a name="zh-cn_topic_0000001312391781_term1253731311225_1"></a><a name="zh-cn_topic_0000001312391781_term1253731311225_1"></a>Ascend 910C</term></span></li><li><span id="ph193121041142717"><a name="ph193121041142717"></a><a name="ph193121041142717"></a><term id="zh-cn_topic_0000001312391781_term11962195213215_1"><a name="zh-cn_topic_0000001312391781_term11962195213215_1"></a><a name="zh-cn_topic_0000001312391781_term11962195213215_1"></a>Ascend 910B</term></span></li></ul>
</td>
</tr>
<tr id="row15190123811428"><td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.1 "><p id="p1819043864216"><a name="p1819043864216"></a><a name="p1819043864216"></a>flag</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p8190138144218"><a name="p8190138144218"></a><a name="p8190138144218"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="72%" headers="mcps1.1.4.1.3 "><p id="p10504122634619"><a name="p10504122634619"></a><a name="p10504122634619"></a>Stream指针的flag。</p>
<p id="p69301912154616"><a name="p69301912154616"></a><a name="p69301912154616"></a>当前支持将flag设置为如下宏,既支持配置单个宏，也支持配置多个宏位或（例如ACL_STREAM_FAST_LAUNCH | ACL_STREAM_FAST_SYNC）。对于不支持位或的宏，本接口会返回报错。配置其他值创建出来的Stream等同于通过<a href="aclrtCreateStream.md">aclrtCreateStream</a>接口创建出来的Stream。</p>
<a name="ul14833151874612"></a><a name="ul14833151874612"></a><ul id="ul14833151874612"><li><strong id="b8185145565920"><a name="b8185145565920"></a><a name="b8185145565920"></a>ACL_STREAM_FAST_LAUNCH</strong>：使用该flag创建出来的Stream，在使用Stream时，下发任务的速度更快。<p id="p12458533152812"><a name="p12458533152812"></a><a name="p12458533152812"></a>相比<a href="aclrtCreateStream.md">aclrtCreateStream</a>接口创建出来的Stream，在使用Stream时才会申请系统内部资源，导致下发任务的时长增加，使用本接口的<strong id="b393155115916"><a name="b393155115916"></a><a name="b393155115916"></a>ACL_STREAM_FAST_LAUNCH</strong>模式创建Stream时，会在创建Stream时预申请系统内部资源，因此创建Stream的时长增加，下发任务的时长缩短，总体来说，创建一次Stream，使用多次的场景下，总时长缩短，但创建Stream时预申请内部资源会增加内存消耗。</p>
<pre class="screen" id="screen518714112326"><a name="screen518714112326"></a><a name="screen518714112326"></a>#define ACL_STREAM_FAST_LAUNCH      0x00000001U</pre>
</li><li><strong id="b113611313109"><a name="b113611313109"></a><a name="b113611313109"></a>ACL_STREAM_FAST_SYNC</strong>：使用该flag创建出来的Stream，在调用<a href="aclrtSynchronizeStream.md">aclrtSynchronizeStream</a>接口时，会阻塞当前线程，主动查询任务的执行状态，一旦任务完成，立即返回。<p id="p720099173817"><a name="p720099173817"></a><a name="p720099173817"></a>相比<a href="aclrtCreateStream.md">aclrtCreateStream</a>接口创建出来的Stream，在调用<a href="aclrtSynchronizeStream.md">aclrtSynchronizeStream</a>接口时，会一直被动等待Device上任务执行完成的通知，等待时间长，使用本接口的<strong id="b142882017208"><a name="b142882017208"></a><a name="b142882017208"></a>ACL_STREAM_FAST_SYNC</strong>模式创建的Stream，没有被动等待，总时长缩短，但主动查询的操作会增加CPU的性能消耗。</p>
<pre class="screen" id="screen3316122516325"><a name="screen3316122516325"></a><a name="screen3316122516325"></a>#define ACL_STREAM_FAST_SYNC        0x00000002U</pre>
</li><li><strong id="b17336165214271"><a name="b17336165214271"></a><a name="b17336165214271"></a>ACL_STREAM_PERSISTENT</strong>：使用该flag创建出来的Stream，在该Stream上下发的任务不会立即执行、任务执行完成后也不会立即销毁，在销毁Stream时才会销毁任务相关的资源。该方式下创建的Stream用于与模型绑定，适用于模型构建场景，模型构建相关接口的说明请参见<a href="aclmdlRIBindStream.md">aclmdlRIBindStream</a>。<pre class="screen" id="screen9308540143213"><a name="screen9308540143213"></a><a name="screen9308540143213"></a>#define ACL_STREAM_PERSISTENT       0x00000004U</pre>
</li><li><strong id="b187256405463"><a name="b187256405463"></a><a name="b187256405463"></a>ACL_STREAM_HUGE</strong>：相比其他flag，使用该flag创建出来的Stream所能容纳的Task最大数量更大。<p id="p5517112881417"><a name="p5517112881417"></a><a name="p5517112881417"></a>当前版本设置该flag不生效。</p>
<pre class="screen" id="screen18979953163217"><a name="screen18979953163217"></a><a name="screen18979953163217"></a>#define ACL_STREAM_HUGE             0x00000008U</pre>
</li><li><strong id="b1997354354618"><a name="b1997354354618"></a><a name="b1997354354618"></a>ACL_STREAM_CPU_SCHEDULE</strong>：使用该flag创建出来的Stream用于队列方式模型推理场景下承载AI CPU调度的相关任务。预留功能。<pre class="screen" id="screen13022012133317"><a name="screen13022012133317"></a><a name="screen13022012133317"></a>#define ACL_STREAM_CPU_SCHEDULE     0x00000010U</pre>
</li><li><strong id="b01831614191612"><a name="b01831614191612"></a><a name="b01831614191612"></a>ACL_STREAM_DEVICE_USE_ONLY</strong>：表示该Stream仅在Device上调用。<pre class="screen" id="screen188918273333"><a name="screen188918273333"></a><a name="screen188918273333"></a>#define ACL_STREAM_DEVICE_USE_ONLY  0x00000020U</pre>
</li></ul>
</td>
</tr>
</tbody>
</table>

## 返回值说明<a name="section25791320141317"></a>

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

