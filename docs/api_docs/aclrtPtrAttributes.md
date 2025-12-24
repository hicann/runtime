# aclrtPtrAttributes<a name="ZH-CN_TOPIC_0000002218853604"></a>

```
typedef struct aclrtPtrAttributes {
    aclrtMemLocation location; 
    uint32_t pageSize;   
    uint32_t rsv[4];    
} aclrtPtrAttributes;
```

<a name="table154428882117"></a>
<table><thead align="left"><tr id="row15442178172115"><th class="cellrowborder" valign="top" width="31.580000000000002%" id="mcps1.1.3.1.1"><p id="p10442188112114"><a name="p10442188112114"></a><a name="p10442188112114"></a>成员名称</p>
</th>
<th class="cellrowborder" valign="top" width="68.42%" id="mcps1.1.3.1.2"><p id="p84426814219"><a name="p84426814219"></a><a name="p84426814219"></a>说明</p>
</th>
</tr>
</thead>
<tbody><tr id="row134425813216"><td class="cellrowborder" valign="top" width="31.580000000000002%" headers="mcps1.1.3.1.1 "><p id="p94424892111"><a name="p94424892111"></a><a name="p94424892111"></a>location</p>
</td>
<td class="cellrowborder" valign="top" width="68.42%" headers="mcps1.1.3.1.2 "><p id="p19222931194718"><a name="p19222931194718"></a><a name="p19222931194718"></a>内存所在位置。</p>
</td>
</tr>
<tr id="row4291121763611"><td class="cellrowborder" valign="top" width="31.580000000000002%" headers="mcps1.1.3.1.1 "><p id="p2292171723615"><a name="p2292171723615"></a><a name="p2292171723615"></a>pageSize</p>
</td>
<td class="cellrowborder" valign="top" width="68.42%" headers="mcps1.1.3.1.2 "><p id="p5499124417470"><a name="p5499124417470"></a><a name="p5499124417470"></a>页表大小，单位Byte。</p>
</td>
</tr>
<tr id="row77592549554"><td class="cellrowborder" valign="top" width="31.580000000000002%" headers="mcps1.1.3.1.1 "><p id="p12759115415511"><a name="p12759115415511"></a><a name="p12759115415511"></a>rsv</p>
</td>
<td class="cellrowborder" valign="top" width="68.42%" headers="mcps1.1.3.1.2 "><p id="p10759125411554"><a name="p10759125411554"></a><a name="p10759125411554"></a>预留参数。当前固定配置为0。</p>
</td>
</tr>
</tbody>
</table>

