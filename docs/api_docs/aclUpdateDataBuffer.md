# aclUpdateDataBuffer<a name="ZH-CN_TOPIC_0000001312400485"></a>

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

更新aclDataBuffer中数据的内存及大小。

更新aclDataBuffer后，之前aclDataBuffer中存放数据的内存如果不使用，需及时释放，否则可能会导致内存泄漏。

## 函数原型<a name="section13230182415108"></a>

```
aclError aclUpdateDataBuffer(aclDataBuffer *dataBuffer, void *data, size_t size)
```

## 参数说明<a name="section75395119104"></a>

<a name="table1220182313110"></a>
<table><thead align="left"><tr id="row19215236111"><th class="cellrowborder" valign="top" width="18%" id="mcps1.1.4.1.1"><p id="p182116237116"><a name="p182116237116"></a><a name="p182116237116"></a>参数名</p>
</th>
<th class="cellrowborder" valign="top" width="14.000000000000002%" id="mcps1.1.4.1.2"><p id="p92192311110"><a name="p92192311110"></a><a name="p92192311110"></a>输入/输出</p>
</th>
<th class="cellrowborder" valign="top" width="68%" id="mcps1.1.4.1.3"><p id="p12213231112"><a name="p12213231112"></a><a name="p12213231112"></a>说明</p>
</th>
</tr>
</thead>
<tbody><tr id="row17211923918"><td class="cellrowborder" valign="top" width="18%" headers="mcps1.1.4.1.1 "><p id="p82111234112"><a name="p82111234112"></a><a name="p82111234112"></a>dataBuffer</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p102132319117"><a name="p102132319117"></a><a name="p102132319117"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="68%" headers="mcps1.1.4.1.3 "><p id="p521723612"><a name="p521723612"></a><a name="p521723612"></a>aclDataBuffer类型的指针。</p>
<p id="p44091754164018"><a name="p44091754164018"></a><a name="p44091754164018"></a>需提前调用<a href="aclCreateDataBuffer.md">aclCreateDataBuffer</a>接口创建aclDataBuffer类型的数据。</p>
<p id="p1515693715161"><a name="p1515693715161"></a><a name="p1515693715161"></a>该内存需由用户自行管理，调用<a href="aclrtMalloc.md">aclrtMalloc</a>接口/<a href="aclrtFree.md">aclrtFree</a>接口申请/释放内存，或调用<a href="aclrtMallocHost.md">aclrtMallocHost</a>接口/<a href="aclrtFreeHost.md">aclrtFreeHost</a>接口申请/释放内存。</p>
</td>
</tr>
<tr id="row18782164581413"><td class="cellrowborder" valign="top" width="18%" headers="mcps1.1.4.1.1 "><p id="p6784945191418"><a name="p6784945191418"></a><a name="p6784945191418"></a>data</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p11784114521416"><a name="p11784114521416"></a><a name="p11784114521416"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="68%" headers="mcps1.1.4.1.3 "><p id="p14784134511419"><a name="p14784134511419"></a><a name="p14784134511419"></a>存放数据内存地址的指针。</p>
</td>
</tr>
<tr id="row2082662511517"><td class="cellrowborder" valign="top" width="18%" headers="mcps1.1.4.1.1 "><p id="p2827192517156"><a name="p2827192517156"></a><a name="p2827192517156"></a>size</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p1882717251150"><a name="p1882717251150"></a><a name="p1882717251150"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="68%" headers="mcps1.1.4.1.3 "><p id="p1382712571512"><a name="p1382712571512"></a><a name="p1382712571512"></a>内存大小，单位Byte。</p>
<p id="p1163015414312"><a name="p1163015414312"></a><a name="p1163015414312"></a>如果用户需要使用空tensor，则在申请内存时，内存大小最小为1Byte，以保障后续业务正常运行。</p>
</td>
</tr>
</tbody>
</table>

## 返回值说明<a name="section25791320141317"></a>

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

