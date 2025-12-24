# aclrtRandomNumFuncParaInfo<a name="ZH-CN_TOPIC_0000002353248441"></a>

```
typedef struct { 
    aclrtRandomNumFuncType funcType;
    union { 
        aclrtDropoutBitMaskInfo dropoutBitmaskInfo; 
        aclrtUniformDisInfo uniformDisInfo;
        aclrtNormalDisInfo normalDisInfo; 
    } paramInfo; 
} aclrtRandomNumFuncParaInfo;
```

<a name="table154428882117"></a>
<table><thead align="left"><tr id="row15442178172115"><th class="cellrowborder" valign="top" width="31.580000000000002%" id="mcps1.1.3.1.1"><p id="p10442188112114"><a name="p10442188112114"></a><a name="p10442188112114"></a>成员名称</p>
</th>
<th class="cellrowborder" valign="top" width="68.42%" id="mcps1.1.3.1.2"><p id="p84426814219"><a name="p84426814219"></a><a name="p84426814219"></a>说明</p>
</th>
</tr>
</thead>
<tbody><tr id="row134425813216"><td class="cellrowborder" valign="top" width="31.580000000000002%" headers="mcps1.1.3.1.1 "><p id="p113169261413"><a name="p113169261413"></a><a name="p113169261413"></a>funcType</p>
</td>
<td class="cellrowborder" valign="top" width="68.42%" headers="mcps1.1.3.1.2 "><p id="p33153261811"><a name="p33153261811"></a><a name="p33153261811"></a>函数类别。</p>
</td>
</tr>
<tr id="row4291121763611"><td class="cellrowborder" valign="top" width="31.580000000000002%" headers="mcps1.1.3.1.1 "><p id="p103140269117"><a name="p103140269117"></a><a name="p103140269117"></a>dropoutBitmaskInfo</p>
</td>
<td class="cellrowborder" valign="top" width="68.42%" headers="mcps1.1.3.1.2 "><p id="p143138261910"><a name="p143138261910"></a><a name="p143138261910"></a>Dropout bitmask信息。</p>
</td>
</tr>
<tr id="row27277271303"><td class="cellrowborder" valign="top" width="31.580000000000002%" headers="mcps1.1.3.1.1 "><p id="p1031222618115"><a name="p1031222618115"></a><a name="p1031222618115"></a>uniformDisInfo</p>
</td>
<td class="cellrowborder" valign="top" width="68.42%" headers="mcps1.1.3.1.2 "><p id="p1099717474219"><a name="p1099717474219"></a><a name="p1099717474219"></a>均匀分布信息。</p>
</td>
</tr>
<tr id="row19701549211"><td class="cellrowborder" valign="top" width="31.580000000000002%" headers="mcps1.1.3.1.1 "><p id="p2970354121"><a name="p2970354121"></a><a name="p2970354121"></a>normalDisInfo</p>
</td>
<td class="cellrowborder" valign="top" width="68.42%" headers="mcps1.1.3.1.2 "><p id="p59701254123"><a name="p59701254123"></a><a name="p59701254123"></a>正态分布信息或截断正态分布信息。</p>
</td>
</tr>
</tbody>
</table>

