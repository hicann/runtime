# aclrtRandomParaInfo<a name="ZH-CN_TOPIC_0000002353248437"></a>

```
typedef struct {
    uint8_t isAddr;
    uint8_t valueOrAddr[8];
    uint8_t size;
    uint8_t rsv[6];
} aclrtRandomParaInfo;
```

<a name="table154428882117"></a>
<table><thead align="left"><tr id="row15442178172115"><th class="cellrowborder" valign="top" width="31.580000000000002%" id="mcps1.1.3.1.1"><p id="p10442188112114"><a name="p10442188112114"></a><a name="p10442188112114"></a>成员名称</p>
</th>
<th class="cellrowborder" valign="top" width="68.42%" id="mcps1.1.3.1.2"><p id="p84426814219"><a name="p84426814219"></a><a name="p84426814219"></a>说明</p>
</th>
</tr>
</thead>
<tbody><tr id="row17236151044815"><td class="cellrowborder" valign="top" width="31.580000000000002%" headers="mcps1.1.3.1.1 "><p id="p1423619105487"><a name="p1423619105487"></a><a name="p1423619105487"></a>isAddr</p>
</td>
<td class="cellrowborder" valign="top" width="68.42%" headers="mcps1.1.3.1.2 "><p id="p923717106489"><a name="p923717106489"></a><a name="p923717106489"></a>取值：0，表示存放参数值；1，表示存放指向参数值的内存地址。</p>
</td>
</tr>
<tr id="row134425813216"><td class="cellrowborder" valign="top" width="31.580000000000002%" headers="mcps1.1.3.1.1 "><p id="p113169261413"><a name="p113169261413"></a><a name="p113169261413"></a>valueOrAddr</p>
</td>
<td class="cellrowborder" valign="top" width="68.42%" headers="mcps1.1.3.1.2 "><p id="p127279213615"><a name="p127279213615"></a><a name="p127279213615"></a>存放参数值或者存放指向参数值的内存地址。</p>
<p id="p18622748142211"><a name="p18622748142211"></a><a name="p18622748142211"></a>当isAddr=0，请根据数据类型填充相应字节数，例如fp16,、bf16，填充前2个字节；fp32、uint32、int32，填充前4个字节；uint64、int64，填充8个字节。</p>
<p id="p17684144432114"><a name="p17684144432114"></a><a name="p17684144432114"></a>当isAddr=1时，则填充8字节的内存地址值。</p>
</td>
</tr>
<tr id="row4291121763611"><td class="cellrowborder" valign="top" width="31.580000000000002%" headers="mcps1.1.3.1.1 "><p id="p103140269117"><a name="p103140269117"></a><a name="p103140269117"></a>size</p>
</td>
<td class="cellrowborder" valign="top" width="68.42%" headers="mcps1.1.3.1.2 "><p id="p1672617216614"><a name="p1672617216614"></a><a name="p1672617216614"></a>对valueOrAddr实际填充的字节数。</p>
</td>
</tr>
<tr id="row1264813220483"><td class="cellrowborder" valign="top" width="31.580000000000002%" headers="mcps1.1.3.1.1 "><p id="p1964820324489"><a name="p1964820324489"></a><a name="p1964820324489"></a>rsv</p>
</td>
<td class="cellrowborder" valign="top" width="68.42%" headers="mcps1.1.3.1.2 "><p id="p10759125411554"><a name="p10759125411554"></a><a name="p10759125411554"></a>预留参数。当前固定配置为0。</p>
</td>
</tr>
</tbody>
</table>

