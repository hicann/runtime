# aclrtCmoWaitBarrier<a name="ZH-CN_TOPIC_0000002308171140"></a>

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
<td class="cellrowborder" align="center" valign="top" width="42%" headers="mcps1.1.3.1.2 "><p id="p5526416165718"><a name="p5526416165718"></a><a name="p5526416165718"></a>☓</p>
</td>
</tr>
<tr id="row173226882415"><td class="cellrowborder" valign="top" width="57.99999999999999%" headers="mcps1.1.3.1.1 "><p id="p14832120181815"><a name="p14832120181815"></a><a name="p14832120181815"></a><span id="ph1483216010188"><a name="ph1483216010188"></a><a name="ph1483216010188"></a><term id="zh-cn_topic_0000001312391781_term11962195213215"><a name="zh-cn_topic_0000001312391781_term11962195213215"></a><a name="zh-cn_topic_0000001312391781_term11962195213215"></a>Ascend 910B</term></span></p>
</td>
<td class="cellrowborder" align="center" valign="top" width="42%" headers="mcps1.1.3.1.2 "><p id="p1452812161572"><a name="p1452812161572"></a><a name="p1452812161572"></a>☓</p>
</td>
</tr>
</tbody>
</table>

## 功能说明<a name="section73552454261"></a>

等待具有指定barrierId的Invalid内存操作任务执行完成。异步接口。

## 函数原型<a name="section195491952142612"></a>

```
aclError aclrtCmoWaitBarrier(aclrtBarrierTaskInfo *taskInfo, aclrtStream stream, uint32_t flag)
```

## 参数说明<a name="section155499553266"></a>

<a name="zh-cn_topic_0122830089_table438764393513"></a>
<table><thead align="left"><tr id="zh-cn_topic_0122830089_row53871743113510"><th class="cellrowborder" valign="top" width="18%" id="mcps1.1.4.1.1"><p id="zh-cn_topic_0122830089_p1438834363520"><a name="zh-cn_topic_0122830089_p1438834363520"></a><a name="zh-cn_topic_0122830089_p1438834363520"></a>参数名</p>
</th>
<th class="cellrowborder" valign="top" width="14.000000000000002%" id="mcps1.1.4.1.2"><p id="p1769255516412"><a name="p1769255516412"></a><a name="p1769255516412"></a>输入/输出</p>
</th>
<th class="cellrowborder" valign="top" width="68%" id="mcps1.1.4.1.3"><p id="zh-cn_topic_0122830089_p173881843143514"><a name="zh-cn_topic_0122830089_p173881843143514"></a><a name="zh-cn_topic_0122830089_p173881843143514"></a>说明</p>
</th>
</tr>
</thead>
<tbody><tr id="row934119103813"><td class="cellrowborder" valign="top" width="18%" headers="mcps1.1.4.1.1 "><p id="p24362141442"><a name="p24362141442"></a><a name="p24362141442"></a>taskInfo</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p243616148446"><a name="p243616148446"></a><a name="p243616148446"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="68%" headers="mcps1.1.4.1.3 "><p id="p143514146444"><a name="p143514146444"></a><a name="p143514146444"></a>Cache内存操作的任务信息。</p>
<p id="p58492144344"><a name="p58492144344"></a><a name="p58492144344"></a>任务信息中的cmoType当前仅支持ACL_RT_CMO_TYPE_INVALID。</p>
</td>
</tr>
<tr id="row3210020182"><td class="cellrowborder" valign="top" width="18%" headers="mcps1.1.4.1.1 "><p id="p4210192014811"><a name="p4210192014811"></a><a name="p4210192014811"></a>stream</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p192101820989"><a name="p192101820989"></a><a name="p192101820989"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="68%" headers="mcps1.1.4.1.3 "><p id="p172561818114418"><a name="p172561818114418"></a><a name="p172561818114418"></a>执行等待任务的Stream。</p>
<p id="p17756574599"><a name="p17756574599"></a><a name="p17756574599"></a>此处只支持与模型绑定过的Stream，绑定模型与Stream需调用<a href="aclmdlRIBindStream.md">aclmdlRIBindStream</a>接口。</p>
</td>
</tr>
<tr id="row2664153013440"><td class="cellrowborder" valign="top" width="18%" headers="mcps1.1.4.1.1 "><p id="p666433094419"><a name="p666433094419"></a><a name="p666433094419"></a>flag</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p5148448164413"><a name="p5148448164413"></a><a name="p5148448164413"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="68%" headers="mcps1.1.4.1.3 "><p id="p196648306440"><a name="p196648306440"></a><a name="p196648306440"></a>预留参数。当前固定配置为0。</p>
</td>
</tr>
</tbody>
</table>

## 返回值说明<a name="section1435713587268"></a>

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

