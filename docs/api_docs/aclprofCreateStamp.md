# aclprofCreateStamp<a name="ZH-CN_TOPIC_0000001312721813"></a>

## AI处理器支持情况<a name="section8178181118225"></a>

<a name="zh-cn_topic_0000001265241414_table38301303189"></a>
<table><thead align="left"><tr id="zh-cn_topic_0000001265241414_row20831180131817"><th class="cellrowborder" valign="top" width="57.99999999999999%" id="mcps1.1.3.1.1"><p id="zh-cn_topic_0000001265241414_p1883113061818"><a name="zh-cn_topic_0000001265241414_p1883113061818"></a><a name="zh-cn_topic_0000001265241414_p1883113061818"></a><span id="zh-cn_topic_0000001265241414_ph20833205312295"><a name="zh-cn_topic_0000001265241414_ph20833205312295"></a><a name="zh-cn_topic_0000001265241414_ph20833205312295"></a>AI处理器类型</span></p>
</th>
<th class="cellrowborder" align="center" valign="top" width="42%" id="mcps1.1.3.1.2"><p id="zh-cn_topic_0000001265241414_p783113012187"><a name="zh-cn_topic_0000001265241414_p783113012187"></a><a name="zh-cn_topic_0000001265241414_p783113012187"></a>是否支持</p>
</th>
</tr>
</thead>
<tbody><tr id="zh-cn_topic_0000001265241414_row220181016240"><td class="cellrowborder" valign="top" width="57.99999999999999%" headers="mcps1.1.3.1.1 "><p id="zh-cn_topic_0000001265241414_p48327011813"><a name="zh-cn_topic_0000001265241414_p48327011813"></a><a name="zh-cn_topic_0000001265241414_p48327011813"></a><span id="zh-cn_topic_0000001265241414_ph583230201815"><a name="zh-cn_topic_0000001265241414_ph583230201815"></a><a name="zh-cn_topic_0000001265241414_ph583230201815"></a><term id="zh-cn_topic_0000001265241414_zh-cn_topic_0000001312391781_term1253731311225"><a name="zh-cn_topic_0000001265241414_zh-cn_topic_0000001312391781_term1253731311225"></a><a name="zh-cn_topic_0000001265241414_zh-cn_topic_0000001312391781_term1253731311225"></a>Ascend 910C</term></span></p>
</td>
<td class="cellrowborder" align="center" valign="top" width="42%" headers="mcps1.1.3.1.2 "><p id="zh-cn_topic_0000001265241414_p7948163910184"><a name="zh-cn_topic_0000001265241414_p7948163910184"></a><a name="zh-cn_topic_0000001265241414_p7948163910184"></a>√</p>
</td>
</tr>
<tr id="zh-cn_topic_0000001265241414_row173226882415"><td class="cellrowborder" valign="top" width="57.99999999999999%" headers="mcps1.1.3.1.1 "><p id="zh-cn_topic_0000001265241414_p14832120181815"><a name="zh-cn_topic_0000001265241414_p14832120181815"></a><a name="zh-cn_topic_0000001265241414_p14832120181815"></a><span id="zh-cn_topic_0000001265241414_ph1483216010188"><a name="zh-cn_topic_0000001265241414_ph1483216010188"></a><a name="zh-cn_topic_0000001265241414_ph1483216010188"></a><term id="zh-cn_topic_0000001265241414_zh-cn_topic_0000001312391781_term11962195213215"><a name="zh-cn_topic_0000001265241414_zh-cn_topic_0000001312391781_term11962195213215"></a><a name="zh-cn_topic_0000001265241414_zh-cn_topic_0000001312391781_term11962195213215"></a>Ascend 910B</term></span></p>
</td>
<td class="cellrowborder" align="center" valign="top" width="42%" headers="mcps1.1.3.1.2 "><p id="zh-cn_topic_0000001265241414_p19948143911820"><a name="zh-cn_topic_0000001265241414_p19948143911820"></a><a name="zh-cn_topic_0000001265241414_p19948143911820"></a>√</p>
</td>
</tr>
</tbody>
</table>

## 功能说明<a name="section5408205113614"></a>

创建msproftx事件标记。后续调用[aclprofMark](aclprofMark.md)、[aclprofSetStampTraceMessage](aclprofSetStampTraceMessage.md)、[aclprofPush](aclprofPush.md)和[aclprofRangeStart](aclprofRangeStart.md)接口时需要以描述该事件的指针作为输入，表示记录该事件发生的时间跨度。

## 函数原型<a name="section632914018717"></a>

```
void *aclprofCreateStamp()
```

## 返回值说明<a name="section41841371675"></a>

-   返回void类型的指针，表示成功。
-   返回nullptr，表示失败。

## 约束说明<a name="section515814611143"></a>

与[aclprofDestroyStamp](aclprofDestroyStamp.md)接口配对使用，需提前调用[aclprofStart](aclprofStart.md)接口。

