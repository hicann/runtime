# aclrtBinaryLoadFromData<a name="ZH-CN_TOPIC_0000002308171156"></a>

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

从内存加载并解析算子二进制数据，同时默认将算子二进制数据拷贝至当前Context对应的Device上，输出指向算子二进制的binHandle。

调用本接口用于加载AI CPU算子信息（aclrtBinaryLoadOption.type包含ACL\_RT\_BINARY\_LOAD\_OPT\_CPU\_KERNEL\_MODE）时，还需配合使用[aclrtRegisterCpuFunc](aclrtRegisterCpuFunc.md)接口注册AI CPU算子。

注意，系统仅将算子加载至当前Context所对应的Device上，因此在调用[aclrtLaunchKernelWithConfig](aclrtLaunchKernelWithConfig.md)接口启动算子计算任务时，所在的Device必须与算子加载时的Device相同。

## 函数原型<a name="section195491952142612"></a>

```
aclError aclrtBinaryLoadFromData(const void *data, size_t length, const aclrtBinaryLoadOptions *options, aclrtBinHandle *binHandle)
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
<tbody><tr id="row7909131293411"><td class="cellrowborder" valign="top" width="18%" headers="mcps1.1.4.1.1 "><p id="p3122105811479"><a name="p3122105811479"></a><a name="p3122105811479"></a>data</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p4122185884720"><a name="p4122185884720"></a><a name="p4122185884720"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="68%" headers="mcps1.1.4.1.3 "><p id="p51217588470"><a name="p51217588470"></a><a name="p51217588470"></a>存放算子二进制数据的Host内存地址，不能为空。</p>
</td>
</tr>
<tr id="row153124110712"><td class="cellrowborder" valign="top" width="18%" headers="mcps1.1.4.1.1 "><p id="p21213586474"><a name="p21213586474"></a><a name="p21213586474"></a>length</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p012005804712"><a name="p012005804712"></a><a name="p012005804712"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="68%" headers="mcps1.1.4.1.3 "><p id="p101201658154719"><a name="p101201658154719"></a><a name="p101201658154719"></a>算子二进制数据的内存大小，必须大于0，单位Byte。</p>
</td>
</tr>
<tr id="row107134414713"><td class="cellrowborder" valign="top" width="18%" headers="mcps1.1.4.1.1 "><p id="p1711910587479"><a name="p1711910587479"></a><a name="p1711910587479"></a>options</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p711813586479"><a name="p711813586479"></a><a name="p711813586479"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="68%" headers="mcps1.1.4.1.3 "><p id="p18174152143113"><a name="p18174152143113"></a><a name="p18174152143113"></a>加载算子二进制文件的可选参数。</p>
</td>
</tr>
<tr id="row1172315476538"><td class="cellrowborder" valign="top" width="18%" headers="mcps1.1.4.1.1 "><p id="p177241347125317"><a name="p177241347125317"></a><a name="p177241347125317"></a>binHandle</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p67241747115312"><a name="p67241747115312"></a><a name="p67241747115312"></a>输出</p>
</td>
<td class="cellrowborder" valign="top" width="68%" headers="mcps1.1.4.1.3 "><p id="p14111122374218"><a name="p14111122374218"></a><a name="p14111122374218"></a>标识算子二进制的句柄。</p>
</td>
</tr>
</tbody>
</table>

## 返回值说明<a name="section1435713587268"></a>

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

