# aclrtBarrierTaskInfo<a name="ZH-CN_TOPIC_0000002344555225"></a>

```
typedef struct { 
    size_t barrierNum;   
    aclrtBarrierCmoInfo cmoInfo[ACL_RT_CMO_MAX_BARRIER_NUM]; 
} aclrtBarrierTaskInfo;
```

<a name="table154428882117"></a>
<table><thead align="left"><tr id="row15442178172115"><th class="cellrowborder" valign="top" width="31.580000000000002%" id="mcps1.1.3.1.1"><p id="p10442188112114"><a name="p10442188112114"></a><a name="p10442188112114"></a>成员名称</p>
</th>
<th class="cellrowborder" valign="top" width="68.42%" id="mcps1.1.3.1.2"><p id="p84426814219"><a name="p84426814219"></a><a name="p84426814219"></a>说明</p>
</th>
</tr>
</thead>
<tbody><tr id="row134425813216"><td class="cellrowborder" valign="top" width="31.580000000000002%" headers="mcps1.1.3.1.1 "><p id="p8566172941813"><a name="p8566172941813"></a><a name="p8566172941813"></a>barrierNum</p>
</td>
<td class="cellrowborder" valign="top" width="68.42%" headers="mcps1.1.3.1.2 "><p id="p5566112913181"><a name="p5566112913181"></a><a name="p5566112913181"></a>cmoInfo数组的长度。</p>
</td>
</tr>
<tr id="row0173327101817"><td class="cellrowborder" valign="top" width="31.580000000000002%" headers="mcps1.1.3.1.1 "><p id="p756382919189"><a name="p756382919189"></a><a name="p756382919189"></a>cmoInfo</p>
</td>
<td class="cellrowborder" valign="top" width="68.42%" headers="mcps1.1.3.1.2 "><p id="p16562132917186"><a name="p16562132917186"></a><a name="p16562132917186"></a>Cache内存操作的任务信息。</p>
<pre class="screen" id="screen1765513154314"><a name="screen1765513154314"></a><a name="screen1765513154314"></a>#define ACL_RT_CMO_MAX_BARRIER_NUM 6U</pre>
</td>
</tr>
</tbody>
</table>

