# aclrtValueWait<a name="ZH-CN_TOPIC_0000002290095233"></a>

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

等待指定内存中的数据满足一定条件后解除阻塞。异步接口。

## 函数原型<a name="section14885205814615"></a>

```
aclError aclrtValueWait(void* devAddr, uint64_t value, uint32_t flag, aclrtStream stream) 
```

## 参数说明<a name="section31916522610"></a>

<a name="zh-cn_topic_0122830089_table438764393513"></a>
<table><thead align="left"><tr id="zh-cn_topic_0122830089_row53871743113510"><th class="cellrowborder" valign="top" width="15%" id="mcps1.1.4.1.1"><p id="zh-cn_topic_0122830089_p1438834363520"><a name="zh-cn_topic_0122830089_p1438834363520"></a><a name="zh-cn_topic_0122830089_p1438834363520"></a>参数名</p>
</th>
<th class="cellrowborder" valign="top" width="15%" id="mcps1.1.4.1.2"><p id="p1769255516412"><a name="p1769255516412"></a><a name="p1769255516412"></a>输入/输出</p>
</th>
<th class="cellrowborder" valign="top" width="70%" id="mcps1.1.4.1.3"><p id="zh-cn_topic_0122830089_p173881843143514"><a name="zh-cn_topic_0122830089_p173881843143514"></a><a name="zh-cn_topic_0122830089_p173881843143514"></a>说明</p>
</th>
</tr>
</thead>
<tbody><tr id="zh-cn_topic_0122830089_row2038874343514"><td class="cellrowborder" valign="top" width="15%" headers="mcps1.1.4.1.1 "><p id="p411592119718"><a name="p411592119718"></a><a name="p411592119718"></a><span>devAddr</span></p>
</td>
<td class="cellrowborder" valign="top" width="15%" headers="mcps1.1.4.1.2 "><p id="p41148211270"><a name="p41148211270"></a><a name="p41148211270"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="70%" headers="mcps1.1.4.1.3 "><p id="p1706182762719"><a name="p1706182762719"></a><a name="p1706182762719"></a>Device侧内存地址。</p>
<p id="p14655101983620"><a name="p14655101983620"></a><a name="p14655101983620"></a><span>devAddr的有效内存位宽为</span><span>64bit</span>。</p>
</td>
</tr>
<tr id="row94145116119"><td class="cellrowborder" valign="top" width="15%" headers="mcps1.1.4.1.1 "><p id="p144175121119"><a name="p144175121119"></a><a name="p144175121119"></a><span>value</span></p>
</td>
<td class="cellrowborder" valign="top" width="15%" headers="mcps1.1.4.1.2 "><p id="p2413516116"><a name="p2413516116"></a><a name="p2413516116"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="70%" headers="mcps1.1.4.1.3 "><p id="p20705192719278"><a name="p20705192719278"></a><a name="p20705192719278"></a>需与内存中的数据作比较的值。</p>
</td>
</tr>
<tr id="row128613662617"><td class="cellrowborder" valign="top" width="15%" headers="mcps1.1.4.1.1 "><p id="p12287113612261"><a name="p12287113612261"></a><a name="p12287113612261"></a><span>flag</span></p>
</td>
<td class="cellrowborder" valign="top" width="15%" headers="mcps1.1.4.1.2 "><p id="p15287173622614"><a name="p15287173622614"></a><a name="p15287173622614"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="70%" headers="mcps1.1.4.1.3 "><p id="p4815510173513"><a name="p4815510173513"></a><a name="p4815510173513"></a>比较的方式，等满足条件后解除阻塞。取值如下：</p>
<pre class="screen" id="screen5222754133912"><a name="screen5222754133912"></a><a name="screen5222754133912"></a>ACL_VALUE_WAIT_GEQ = 0x0;   // 等到(int64_t)(*<span>devAddr</span> - value) &gt;= 0 
ACL_VALUE_WAIT_EQ = 0x1;    // 等到*<span>devAddr</span> == value
ACL_VALUE_WAIT_AND = 0x2;   // 等到(*devAddr &amp; value) != 0
ACL_VALUE_WAIT_NOR = 0x3;   // 等到<font style="font-size:8pt" Face="Courier New" >~</font>(*devAddr | value) != 0 </pre>
</td>
</tr>
<tr id="row20764953102611"><td class="cellrowborder" valign="top" width="15%" headers="mcps1.1.4.1.1 "><p id="p12764115316260"><a name="p12764115316260"></a><a name="p12764115316260"></a>stream</p>
</td>
<td class="cellrowborder" valign="top" width="15%" headers="mcps1.1.4.1.2 "><p id="p1276414534267"><a name="p1276414534267"></a><a name="p1276414534267"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="70%" headers="mcps1.1.4.1.3 "><p id="p16774162816465"><a name="p16774162816465"></a><a name="p16774162816465"></a>执行等待任务的stream。</p>
<p id="p113154110296"><a name="p113154110296"></a><a name="p113154110296"></a>此处支持传NULL，表示使用默认Stream。</p>
</td>
</tr>
</tbody>
</table>

## 返回值说明<a name="section17970231879"></a>

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

