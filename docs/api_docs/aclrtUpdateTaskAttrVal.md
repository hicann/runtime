# aclrtUpdateTaskAttrVal<a name="ZH-CN_TOPIC_0000002344790237"></a>

```
typedef union { 
    aclrtRandomTaskUpdateAttr randomTaskAttr; 
    aclrtAicAivTaskUpdateAttr aicAivTaskAttr; 
} aclrtUpdateTaskAttrVal;
```

<a name="table154428882117"></a>
<table><thead align="left"><tr id="row15442178172115"><th class="cellrowborder" valign="top" width="31.580000000000002%" id="mcps1.1.3.1.1"><p id="p10442188112114"><a name="p10442188112114"></a><a name="p10442188112114"></a>成员名称</p>
</th>
<th class="cellrowborder" valign="top" width="68.42%" id="mcps1.1.3.1.2"><p id="p84426814219"><a name="p84426814219"></a><a name="p84426814219"></a>说明</p>
</th>
</tr>
</thead>
<tbody><tr id="row134425813216"><td class="cellrowborder" valign="top" width="31.580000000000002%" headers="mcps1.1.3.1.1 "><p id="p633014100915"><a name="p633014100915"></a><a name="p633014100915"></a>randomTaskAttr</p>
</td>
<td class="cellrowborder" valign="top" width="68.42%" headers="mcps1.1.3.1.2 "><p id="p127279213615"><a name="p127279213615"></a><a name="p127279213615"></a>随机数生成任务。</p>
<p id="p136941026141117"><a name="p136941026141117"></a><a name="p136941026141117"></a>不同型号对该任务支持的情况不同：</p>
<p id="p10221171821510"><a name="p10221171821510"></a><a name="p10221171821510"></a><span id="ph1522191811513"><a name="ph1522191811513"></a><a name="ph1522191811513"></a><term id="zh-cn_topic_0000001312391781_term1253731311225"><a name="zh-cn_topic_0000001312391781_term1253731311225"></a><a name="zh-cn_topic_0000001312391781_term1253731311225"></a>Ascend 910C</term></span>支持随机数生成任务</p>
<p id="p22211818171520"><a name="p22211818171520"></a><a name="p22211818171520"></a><span id="ph3221218201511"><a name="ph3221218201511"></a><a name="ph3221218201511"></a><term id="zh-cn_topic_0000001312391781_term11962195213215"><a name="zh-cn_topic_0000001312391781_term11962195213215"></a><a name="zh-cn_topic_0000001312391781_term11962195213215"></a>Ascend 910B</term></span>支持随机数生成任务</p>
</td>
</tr>
<tr id="row4291121763611"><td class="cellrowborder" valign="top" width="31.580000000000002%" headers="mcps1.1.3.1.1 "><p id="p4980161515914"><a name="p4980161515914"></a><a name="p4980161515914"></a>aicAivTaskAttr</p>
</td>
<td class="cellrowborder" valign="top" width="68.42%" headers="mcps1.1.3.1.2 "><p id="p1672617216614"><a name="p1672617216614"></a><a name="p1672617216614"></a>在Cube\Vector计算单元上执行的计算任务。</p>
</td>
</tr>
</tbody>
</table>

