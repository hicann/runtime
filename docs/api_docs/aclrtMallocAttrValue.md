# aclrtMallocAttrValue<a name="ZH-CN_TOPIC_0000002218693764"></a>

```
typedef union {
    uint16_t moduleId; 
    uint32_t deviceId;  
    uint8_t rsv[8]; 
} aclrtMallocAttrValue;
```

<a name="table154428882117"></a>
<table><thead align="left"><tr id="row15442178172115"><th class="cellrowborder" valign="top" width="31.580000000000002%" id="mcps1.1.3.1.1"><p id="p10442188112114"><a name="p10442188112114"></a><a name="p10442188112114"></a>成员名称</p>
</th>
<th class="cellrowborder" valign="top" width="68.42%" id="mcps1.1.3.1.2"><p id="p84426814219"><a name="p84426814219"></a><a name="p84426814219"></a>说明</p>
</th>
</tr>
</thead>
<tbody><tr id="row134425813216"><td class="cellrowborder" valign="top" width="31.580000000000002%" headers="mcps1.1.3.1.1 "><p id="p94424892111"><a name="p94424892111"></a><a name="p94424892111"></a>moduleId</p>
</td>
<td class="cellrowborder" valign="top" width="68.42%" headers="mcps1.1.3.1.2 "><p id="p1583114610497"><a name="p1583114610497"></a><a name="p1583114610497"></a>模块ID，建议配置为33，表示APP，用于表示该内存是由用户的应用程序申请的，便于维测场景下定位问题。</p>
</td>
</tr>
<tr id="row9844133114915"><td class="cellrowborder" valign="top" width="31.580000000000002%" headers="mcps1.1.3.1.1 "><p id="p0844153112493"><a name="p0844153112493"></a><a name="p0844153112493"></a>deviceId</p>
</td>
<td class="cellrowborder" valign="top" width="68.42%" headers="mcps1.1.3.1.2 "><p id="p78311546144917"><a name="p78311546144917"></a><a name="p78311546144917"></a>Device ID，若此处配置的Device ID与当前用于计算的Device ID不一致，接口会返回报错，建议不配置该属性值。</p>
</td>
</tr>
<tr id="row4291121763611"><td class="cellrowborder" valign="top" width="31.580000000000002%" headers="mcps1.1.3.1.1 "><p id="p2292171723615"><a name="p2292171723615"></a><a name="p2292171723615"></a>rsv</p>
</td>
<td class="cellrowborder" valign="top" width="68.42%" headers="mcps1.1.3.1.2 "><p id="p783019463496"><a name="p783019463496"></a><a name="p783019463496"></a>预留参数。当前固定配置为0。</p>
</td>
</tr>
</tbody>
</table>

