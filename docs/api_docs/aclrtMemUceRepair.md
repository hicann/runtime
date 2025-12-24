# aclrtMemUceRepair<a name="ZH-CN_TOPIC_0000001982631673"></a>

**须知：本接口为预留接口，暂不支持。**

## 功能说明<a name="section93499471063"></a>

修复内存UCE的错误虚拟地址。

## 函数原型<a name="section14885205814615"></a>

```
aclError aclrtMemUceRepair(int32_t deviceId, aclrtMemUceInfo *memUceInfoArray, size_t arraySize)
```

## 参数说明<a name="section31916522610"></a>

<a name="zh-cn_topic_0122830089_table438764393513"></a>
<table><thead align="left"><tr id="zh-cn_topic_0122830089_row53871743113510"><th class="cellrowborder" valign="top" width="18%" id="mcps1.1.4.1.1"><p id="zh-cn_topic_0122830089_p1438834363520"><a name="zh-cn_topic_0122830089_p1438834363520"></a><a name="zh-cn_topic_0122830089_p1438834363520"></a>参数名</p>
</th>
<th class="cellrowborder" valign="top" width="14.000000000000002%" id="mcps1.1.4.1.2"><p id="p1769255516412"><a name="p1769255516412"></a><a name="p1769255516412"></a>输入/输出</p>
</th>
<th class="cellrowborder" valign="top" width="68%" id="mcps1.1.4.1.3"><p id="zh-cn_topic_0122830089_p173881843143514"><a name="zh-cn_topic_0122830089_p173881843143514"></a><a name="zh-cn_topic_0122830089_p173881843143514"></a>说明</p>
</th>
</tr>
</thead>
<tbody><tr id="zh-cn_topic_0122830089_row2038874343514"><td class="cellrowborder" valign="top" width="18%" headers="mcps1.1.4.1.1 "><p id="p1311921153314"><a name="p1311921153314"></a><a name="p1311921153314"></a>deviceId</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p103172113317"><a name="p103172113317"></a><a name="p103172113317"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="68%" headers="mcps1.1.4.1.3 "><p id="zh-cn_topic_0122830089_p19388143103518"><a name="zh-cn_topic_0122830089_p19388143103518"></a><a name="zh-cn_topic_0122830089_p19388143103518"></a>Device ID。</p>
<p id="p5103103751315"><a name="p5103103751315"></a><a name="p5103103751315"></a>与<a href="aclrtSetDevice.md">aclrtSetDevice</a>接口中Device ID保持一致。</p>
</td>
</tr>
<tr id="row24225813376"><td class="cellrowborder" valign="top" width="18%" headers="mcps1.1.4.1.1 "><p id="p19431058193717"><a name="p19431058193717"></a><a name="p19431058193717"></a>memUceInfoArray</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p9437582371"><a name="p9437582371"></a><a name="p9437582371"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="68%" headers="mcps1.1.4.1.3 "><p id="p207951720171117"><a name="p207951720171117"></a><a name="p207951720171117"></a>aclrtMemUceInfo数组的指针。</p>
</td>
</tr>
<tr id="row84229610380"><td class="cellrowborder" valign="top" width="18%" headers="mcps1.1.4.1.1 "><p id="p1042256203810"><a name="p1042256203810"></a><a name="p1042256203810"></a>arraySize</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p1542266153810"><a name="p1542266153810"></a><a name="p1542266153810"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="68%" headers="mcps1.1.4.1.3 "><p id="p1795820141116"><a name="p1795820141116"></a><a name="p1795820141116"></a>传入aclrtMemUceInfo数组的长度。</p>
</td>
</tr>
</tbody>
</table>

## 返回值说明<a name="section17970231879"></a>

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

