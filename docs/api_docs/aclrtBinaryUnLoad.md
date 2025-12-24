# aclrtBinaryUnLoad<a name="ZH-CN_TOPIC_0000001678093204"></a>

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
<td class="cellrowborder" align="center" valign="top" width="42%" headers="mcps1.1.3.1.2 "><p id="p116858459716"><a name="p116858459716"></a><a name="p116858459716"></a>√</p>
</td>
</tr>
<tr id="row173226882415"><td class="cellrowborder" valign="top" width="57.99999999999999%" headers="mcps1.1.3.1.1 "><p id="p14832120181815"><a name="p14832120181815"></a><a name="p14832120181815"></a><span id="ph1483216010188"><a name="ph1483216010188"></a><a name="ph1483216010188"></a><term id="zh-cn_topic_0000001312391781_term11962195213215"><a name="zh-cn_topic_0000001312391781_term11962195213215"></a><a name="zh-cn_topic_0000001312391781_term11962195213215"></a>Ascend 910B</term></span></p>
</td>
<td class="cellrowborder" align="center" valign="top" width="42%" headers="mcps1.1.3.1.2 "><p id="p1568544511713"><a name="p1568544511713"></a><a name="p1568544511713"></a>√</p>
</td>
</tr>
</tbody>
</table>

## 功能说明<a name="section73552454261"></a>

删除binHandle指向的算子二进制数据，同时也删除加载算子二进制文件时拷贝到Device上的算子二进制数据。

## 函数原型<a name="section195491952142612"></a>

```
aclError aclrtBinaryUnLoad(aclrtBinHandle binHandle)
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
<tbody><tr id="row7909131293411"><td class="cellrowborder" valign="top" width="18%" headers="mcps1.1.4.1.1 "><p id="p1912212521619"><a name="p1912212521619"></a><a name="p1912212521619"></a>binHandle</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p171219521613"><a name="p171219521613"></a><a name="p171219521613"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="68%" headers="mcps1.1.4.1.3 "><p id="p14111122374218"><a name="p14111122374218"></a><a name="p14111122374218"></a>算子二进制句柄。</p>
<p id="p1583912438429"><a name="p1583912438429"></a><a name="p1583912438429"></a>该handle在调用<a href="aclrtBinaryLoadFromFile.md">aclrtBinaryLoadFromFile</a>、<a href="aclrtBinaryLoadFromData.md">aclrtBinaryLoadFromData</a>或者<a href="aclrtBinaryLoad.md">aclrtBinaryLoad</a>接口时生成。</p>
</td>
</tr>
</tbody>
</table>

## 返回值说明<a name="section1435713587268"></a>

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

## 约束说明<a name="section1963213152413"></a>

调用本接口删除算子二进制数据时，需跟[aclrtBinaryLoadFromFile](aclrtBinaryLoadFromFile.md)、[aclrtBinaryLoadFromData](aclrtBinaryLoadFromData.md)或者[aclrtBinaryLoad](aclrtBinaryLoad.md)接口在同一个Context下，这样才能一并删除加载算子二进制文件时拷贝到Device上的算子二进制数据，否则可能会导致Device上的算子二进制数据删除异常。

