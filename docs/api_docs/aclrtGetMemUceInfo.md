# aclrtGetMemUceInfo<a name="ZH-CN_TOPIC_0000001982751513"></a>

**须知：本接口为预留接口，暂不支持。**

## 功能说明<a name="section93499471063"></a>

获取内存UCE（uncorrect error，指系统硬件不能直接处理恢复内存错误）的错误虚拟地址。

## 函数原型<a name="section14885205814615"></a>

```
aclError aclrtGetMemUceInfo(int32_t deviceId, aclrtMemUceInfo *memUceInfoArray, size_t arraySize, size_t *retSize)
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
<tr id="row13831310174016"><td class="cellrowborder" valign="top" width="18%" headers="mcps1.1.4.1.1 "><p id="p6383131024014"><a name="p6383131024014"></a><a name="p6383131024014"></a>memUceInfoArray</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p183831210184020"><a name="p183831210184020"></a><a name="p183831210184020"></a>输入&amp;输出</p>
</td>
<td class="cellrowborder" valign="top" width="68%" headers="mcps1.1.4.1.3 "><p id="p1691611464567"><a name="p1691611464567"></a><a name="p1691611464567"></a>aclrtMemUceInfo数组的指针。</p>
</td>
</tr>
<tr id="row172441415114015"><td class="cellrowborder" valign="top" width="18%" headers="mcps1.1.4.1.1 "><p id="p824581584014"><a name="p824581584014"></a><a name="p824581584014"></a>arraySize</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p624515158406"><a name="p624515158406"></a><a name="p624515158406"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="68%" headers="mcps1.1.4.1.3 "><p id="p11916114610561"><a name="p11916114610561"></a><a name="p11916114610561"></a>传入aclrtMemUceInfo数组的长度。</p>
</td>
</tr>
<tr id="row558771212403"><td class="cellrowborder" valign="top" width="18%" headers="mcps1.1.4.1.1 "><p id="p135871312204017"><a name="p135871312204017"></a><a name="p135871312204017"></a>retSize</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p1658711125404"><a name="p1658711125404"></a><a name="p1658711125404"></a>输出</p>
</td>
<td class="cellrowborder" valign="top" width="68%" headers="mcps1.1.4.1.3 "><p id="p1091604617567"><a name="p1091604617567"></a><a name="p1091604617567"></a>实际返回的aclrtMemUceInfo数组的有效长度。</p>
</td>
</tr>
</tbody>
</table>

## 返回值说明<a name="section17970231879"></a>

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

