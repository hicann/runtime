# aclrtRepairError<a name="ZH-CN_TOPIC_0000002450408852"></a>

**须知：本接口为预留接口，暂不支持。**

## 功能说明<a name="section93499471063"></a>

基于[aclrtGetErrorVerbose](aclrtGetErrorVerbose.md)接口获取的详细信息进行故障恢复，此接口应该在提交任务中止之后调用。

## 函数原型<a name="section14885205814615"></a>

```
aclError aclrtRepairError(int32_t deviceId, const aclrtErrorInfo *errorInfo)
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
<tr id="row071703213618"><td class="cellrowborder" valign="top" width="18%" headers="mcps1.1.4.1.1 "><p id="p1571713324360"><a name="p1571713324360"></a><a name="p1571713324360"></a>errorInfo</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p197176329369"><a name="p197176329369"></a><a name="p197176329369"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="68%" headers="mcps1.1.4.1.3 "><p id="p06778211106"><a name="p06778211106"></a><a name="p06778211106"></a>错误信息。</p>
<p id="p18901108171417"><a name="p18901108171417"></a><a name="p18901108171417"></a>aclrtErrorInfo结构体的描述请参见<a href="aclrtGetErrorVerbose.md">aclrtGetErrorVerbose</a>。</p>
</td>
</tr>
</tbody>
</table>

## 返回值说明<a name="section17970231879"></a>

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

