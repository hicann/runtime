# aclrtReduceAsync<a name="ZH-CN_TOPIC_0000002305752337"></a>

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

执行Reduce操作，包括SUM、MIN、MAX等。异步接口。

## 函数原型<a name="section13230182415108"></a>

```
aclError aclrtReduceAsync(void *dst, const void *src, uint64_t count, aclrtReduceKind kind, aclDataType type, aclrtStream stream, void *reserve)
```

## 参数说明<a name="section75395119104"></a>

<a name="zh-cn_topic_0122830089_table438764393513"></a>
<table><thead align="left"><tr id="zh-cn_topic_0122830089_row53871743113510"><th class="cellrowborder" valign="top" width="21.39%" id="mcps1.1.4.1.1"><p id="zh-cn_topic_0122830089_p1438834363520"><a name="zh-cn_topic_0122830089_p1438834363520"></a><a name="zh-cn_topic_0122830089_p1438834363520"></a>参数名</p>
</th>
<th class="cellrowborder" valign="top" width="18.7%" id="mcps1.1.4.1.2"><p id="p1769255516412"><a name="p1769255516412"></a><a name="p1769255516412"></a>输入/输出</p>
</th>
<th class="cellrowborder" valign="top" width="59.91%" id="mcps1.1.4.1.3"><p id="zh-cn_topic_0122830089_p173881843143514"><a name="zh-cn_topic_0122830089_p173881843143514"></a><a name="zh-cn_topic_0122830089_p173881843143514"></a>说明</p>
</th>
</tr>
</thead>
<tbody><tr id="row229712714517"><td class="cellrowborder" valign="top" width="21.39%" headers="mcps1.1.4.1.1 "><p id="p79081724131910"><a name="p79081724131910"></a><a name="p79081724131910"></a>dst</p>
</td>
<td class="cellrowborder" valign="top" width="18.7%" headers="mcps1.1.4.1.2 "><p id="p8908162411194"><a name="p8908162411194"></a><a name="p8908162411194"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="59.91%" headers="mcps1.1.4.1.3 "><p id="p2015516107499"><a name="p2015516107499"></a><a name="p2015516107499"></a>目的内存地址指针。</p>
</td>
</tr>
<tr id="row155291213104918"><td class="cellrowborder" valign="top" width="21.39%" headers="mcps1.1.4.1.1 "><p id="p7529113204911"><a name="p7529113204911"></a><a name="p7529113204911"></a>src</p>
</td>
<td class="cellrowborder" valign="top" width="18.7%" headers="mcps1.1.4.1.2 "><p id="p1352917131494"><a name="p1352917131494"></a><a name="p1352917131494"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="59.91%" headers="mcps1.1.4.1.3 "><p id="p6904103514274"><a name="p6904103514274"></a><a name="p6904103514274"></a>源内存地址指针。</p>
</td>
</tr>
<tr id="row14765201524915"><td class="cellrowborder" valign="top" width="21.39%" headers="mcps1.1.4.1.1 "><p id="p12765315184912"><a name="p12765315184912"></a><a name="p12765315184912"></a>count</p>
</td>
<td class="cellrowborder" valign="top" width="18.7%" headers="mcps1.1.4.1.2 "><p id="p77651415164910"><a name="p77651415164910"></a><a name="p77651415164910"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="59.91%" headers="mcps1.1.4.1.3 "><p id="p8903635192719"><a name="p8903635192719"></a><a name="p8903635192719"></a>源内存大小，单位为Byte。</p>
</td>
</tr>
<tr id="row55931636102610"><td class="cellrowborder" valign="top" width="21.39%" headers="mcps1.1.4.1.1 "><p id="p1594236102615"><a name="p1594236102615"></a><a name="p1594236102615"></a>kind</p>
</td>
<td class="cellrowborder" valign="top" width="18.7%" headers="mcps1.1.4.1.2 "><p id="p1459414364265"><a name="p1459414364265"></a><a name="p1459414364265"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="59.91%" headers="mcps1.1.4.1.3 "><p id="p12594336112610"><a name="p12594336112610"></a><a name="p12594336112610"></a>操作类型。</p>
</td>
</tr>
<tr id="row1946212452267"><td class="cellrowborder" valign="top" width="21.39%" headers="mcps1.1.4.1.1 "><p id="p1946254510268"><a name="p1946254510268"></a><a name="p1946254510268"></a>type</p>
</td>
<td class="cellrowborder" valign="top" width="18.7%" headers="mcps1.1.4.1.2 "><p id="p74624455267"><a name="p74624455267"></a><a name="p74624455267"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="59.91%" headers="mcps1.1.4.1.3 "><p id="p16462184519269"><a name="p16462184519269"></a><a name="p16462184519269"></a>数据类型。</p>
<p id="p338681103119"><a name="p338681103119"></a><a name="p338681103119"></a><span id="ph1091618344214"><a name="ph1091618344214"></a><a name="ph1091618344214"></a><term id="zh-cn_topic_0000001312391781_term1253731311225_1"><a name="zh-cn_topic_0000001312391781_term1253731311225_1"></a><a name="zh-cn_topic_0000001312391781_term1253731311225_1"></a>Ascend 910C</term></span>支持如下类型：int8、int16、int32、fp16、fp32、bf16。</p>
<p id="p14322049162920"><a name="p14322049162920"></a><a name="p14322049162920"></a><span id="ph1976372454117"><a name="ph1976372454117"></a><a name="ph1976372454117"></a><term id="zh-cn_topic_0000001312391781_term11962195213215_1"><a name="zh-cn_topic_0000001312391781_term11962195213215_1"></a><a name="zh-cn_topic_0000001312391781_term11962195213215_1"></a>Ascend 910B</term></span>支持如下类型：int8、int16、int32、fp16、fp32、bf16。</p>
<p id="p827312316402"><a name="p827312316402"></a><a name="p827312316402"></a></p>
</td>
</tr>
<tr id="row8781849182616"><td class="cellrowborder" valign="top" width="21.39%" headers="mcps1.1.4.1.1 "><p id="p137811449122618"><a name="p137811449122618"></a><a name="p137811449122618"></a>stream</p>
</td>
<td class="cellrowborder" valign="top" width="18.7%" headers="mcps1.1.4.1.2 "><p id="p7781144911261"><a name="p7781144911261"></a><a name="p7781144911261"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="59.91%" headers="mcps1.1.4.1.3 "><p id="p97811496266"><a name="p97811496266"></a><a name="p97811496266"></a>指定执行Reduce操作任务的Stream。</p>
<p id="p669019467720"><a name="p669019467720"></a><a name="p669019467720"></a>如果使用默认Stream，此处设置为NULL。</p>
</td>
</tr>
<tr id="row431185313263"><td class="cellrowborder" valign="top" width="21.39%" headers="mcps1.1.4.1.1 "><p id="p1831155314263"><a name="p1831155314263"></a><a name="p1831155314263"></a>reserve</p>
</td>
<td class="cellrowborder" valign="top" width="18.7%" headers="mcps1.1.4.1.2 "><p id="p17311195362619"><a name="p17311195362619"></a><a name="p17311195362619"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="59.91%" headers="mcps1.1.4.1.3 "><p id="p11886152364016"><a name="p11886152364016"></a><a name="p11886152364016"></a>预留参数。当前固定传NULL。</p>
</td>
</tr>
</tbody>
</table>

## 返回值说明<a name="section25791320141317"></a>

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

## 约束说明<a name="section21101545218"></a>

dts、src必须跟stream所在的Device是同一个设备。

