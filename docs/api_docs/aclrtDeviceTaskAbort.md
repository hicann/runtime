# aclrtDeviceTaskAbort<a name="ZH-CN_TOPIC_0000001950952116"></a>

**须知：本接口为预留接口，暂不支持。**

## 功能说明<a name="section93499471063"></a>

停止指定Device上的正在执行的任务，同时丢弃指定Device上已下发的任务。该接口支持用户设置永久等待、或配置具体的超时时间，若配置具体的超时时间，则调用本接口超出超时时间，则接口返回报错。

## 函数原型<a name="section14885205814615"></a>

```
aclError aclrtDeviceTaskAbort(int32_t deviceId, uint32_t timeout);
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
<tr id="row071703213618"><td class="cellrowborder" valign="top" width="18%" headers="mcps1.1.4.1.1 "><p id="p1571713324360"><a name="p1571713324360"></a><a name="p1571713324360"></a>timeout</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p197176329369"><a name="p197176329369"></a><a name="p197176329369"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="68%" headers="mcps1.1.4.1.3 "><p id="p716312531128"><a name="p716312531128"></a><a name="p716312531128"></a>超时时间。</p>
<p id="p14163161111313"><a name="p14163161111313"></a><a name="p14163161111313"></a>取值说明如下：</p>
<a name="ul589318220132"></a><a name="ul589318220132"></a><ul id="ul589318220132"><li>0：表示永久等待；</li><li>&gt;0：配置具体的超时时间，单位是毫秒。最大超时时间36分钟。</li></ul>
</td>
</tr>
</tbody>
</table>

## 返回值说明<a name="section17970231879"></a>

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

