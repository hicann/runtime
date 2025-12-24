# aclrtServerPid<a name="ZH-CN_TOPIC_0000002453843276"></a>

```
typedef struct {
    uint32_t sdid; 
    int32_t *pid;  
    size_t num; 
} aclrtServerPid;
```

<a name="table154428882117"></a>
<table><thead align="left"><tr id="row15442178172115"><th class="cellrowborder" valign="top" width="31.580000000000002%" id="mcps1.1.3.1.1"><p id="p10442188112114"><a name="p10442188112114"></a><a name="p10442188112114"></a>成员名称</p>
</th>
<th class="cellrowborder" valign="top" width="68.42%" id="mcps1.1.3.1.2"><p id="p84426814219"><a name="p84426814219"></a><a name="p84426814219"></a>说明</p>
</th>
</tr>
</thead>
<tbody><tr id="row134425813216"><td class="cellrowborder" valign="top" width="31.580000000000002%" headers="mcps1.1.3.1.1 "><p id="p113169261413"><a name="p113169261413"></a><a name="p113169261413"></a>sdid</p>
</td>
<td class="cellrowborder" valign="top" width="68.42%" headers="mcps1.1.3.1.2 "><p id="p127279213615"><a name="p127279213615"></a><a name="p127279213615"></a>针对<span id="ph1094452913612"><a name="ph1094452913612"></a><a name="ph1094452913612"></a><term id="zh-cn_topic_0000001312391781_term1253731311225"><a name="zh-cn_topic_0000001312391781_term1253731311225"></a><a name="zh-cn_topic_0000001312391781_term1253731311225"></a>Ascend 910C</term></span>中的超节点产品，sdid（SuperPOD Device ID）表示超节点产品中的Device唯一标识，可提前调用<a href="aclrtGetDeviceInfo.md">aclGetDeviceInfo</a>接口获取。</p>
</td>
</tr>
<tr id="row4291121763611"><td class="cellrowborder" valign="top" width="31.580000000000002%" headers="mcps1.1.3.1.1 "><p id="p103140269117"><a name="p103140269117"></a><a name="p103140269117"></a>pid</p>
</td>
<td class="cellrowborder" valign="top" width="68.42%" headers="mcps1.1.3.1.2 "><p id="p1166009114217"><a name="p1166009114217"></a><a name="p1166009114217"></a>Host侧进程ID白名单数组。</p>
</td>
</tr>
<tr id="row348119013421"><td class="cellrowborder" valign="top" width="31.580000000000002%" headers="mcps1.1.3.1.1 "><p id="p34811405422"><a name="p34811405422"></a><a name="p34811405422"></a>num</p>
</td>
<td class="cellrowborder" valign="top" width="68.42%" headers="mcps1.1.3.1.2 "><p id="p114811004210"><a name="p114811004210"></a><a name="p114811004210"></a>pid数组长度。</p>
</td>
</tr>
</tbody>
</table>

