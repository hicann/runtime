# acltdtGetDatasetSize<a name="ZH-CN_TOPIC_0000001264921902"></a>

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

## 功能说明<a name="section0117164520431"></a>

获取acltdtDataset中acltdtDataItem的个数。

## 函数原型<a name="section133154911438"></a>

```
size_t acltdtGetDatasetSize(const acltdtDataset *dataset)
```

## 参数说明<a name="section13616184164416"></a>

<a name="table1527919256810"></a>
<table><thead align="left"><tr id="row227932516813"><th class="cellrowborder" valign="top" width="18%" id="mcps1.1.4.1.1"><p id="p132793252810"><a name="p132793252810"></a><a name="p132793252810"></a>参数名</p>
</th>
<th class="cellrowborder" valign="top" width="14.000000000000002%" id="mcps1.1.4.1.2"><p id="p15279225883"><a name="p15279225883"></a><a name="p15279225883"></a>输入/输出</p>
</th>
<th class="cellrowborder" valign="top" width="68%" id="mcps1.1.4.1.3"><p id="p1627918251083"><a name="p1627918251083"></a><a name="p1627918251083"></a>说明</p>
</th>
</tr>
</thead>
<tbody><tr id="row627902516814"><td class="cellrowborder" valign="top" width="18%" headers="mcps1.1.4.1.1 "><p id="p62799251187"><a name="p62799251187"></a><a name="p62799251187"></a>dataset</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p328019251384"><a name="p328019251384"></a><a name="p328019251384"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="68%" headers="mcps1.1.4.1.3 "><p id="p882593171011"><a name="p882593171011"></a><a name="p882593171011"></a>acltdtDataset类型的指针。</p>
<p id="p8958217204511"><a name="p8958217204511"></a><a name="p8958217204511"></a>需提前调用<a href="acltdtCreateDataset.md">acltdtCreateDataset</a>接口创建acltdtDataset类型的数据。</p>
</td>
</tr>
</tbody>
</table>

## 返回值说明<a name="section162895447"></a>

acltdtDataItem的个数。

