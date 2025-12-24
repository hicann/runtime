# aclrtAicAivTaskUpdateAttr<a name="ZH-CN_TOPIC_0000002310562188"></a>

```
typedef struct { 
    void *binHandle;      
    void *funcEntryAddr;  
    void *blockDimAddr;   
    uint32_t rsv[4];      
} aclrtAicAivTaskUpdateAttr;
```

<a name="table154428882117"></a>
<table><thead align="left"><tr id="row15442178172115"><th class="cellrowborder" valign="top" width="31.580000000000002%" id="mcps1.1.3.1.1"><p id="p10442188112114"><a name="p10442188112114"></a><a name="p10442188112114"></a>成员名称</p>
</th>
<th class="cellrowborder" valign="top" width="68.42%" id="mcps1.1.3.1.2"><p id="p84426814219"><a name="p84426814219"></a><a name="p84426814219"></a>说明</p>
</th>
</tr>
</thead>
<tbody><tr id="row134425813216"><td class="cellrowborder" valign="top" width="31.580000000000002%" headers="mcps1.1.3.1.1 "><p id="p8566172941813"><a name="p8566172941813"></a><a name="p8566172941813"></a>binHandle</p>
</td>
<td class="cellrowborder" valign="top" width="68.42%" headers="mcps1.1.3.1.2 "><p id="p5566112913181"><a name="p5566112913181"></a><a name="p5566112913181"></a>存放待刷新的算子二进制句柄，可调用<a href="aclrtBinaryLoadFromFile.md">aclrtBinaryLoadFromFile</a>或<a href="aclrtBinaryLoadFromData.md">aclrtBinaryLoadFromData</a>接口获取算子二进制句柄。</p>
</td>
</tr>
<tr id="row0173327101817"><td class="cellrowborder" valign="top" width="31.580000000000002%" headers="mcps1.1.3.1.1 "><p id="p756382919189"><a name="p756382919189"></a><a name="p756382919189"></a>funcEntryAddr</p>
</td>
<td class="cellrowborder" valign="top" width="68.42%" headers="mcps1.1.3.1.2 "><p id="p16562132917186"><a name="p16562132917186"></a><a name="p16562132917186"></a>存放Function Entry（用于标识函数的关键字）的Device内存地址。</p>
</td>
</tr>
<tr id="row4291121763611"><td class="cellrowborder" valign="top" width="31.580000000000002%" headers="mcps1.1.3.1.1 "><p id="p9562429111817"><a name="p9562429111817"></a><a name="p9562429111817"></a>blockDimAddr</p>
</td>
<td class="cellrowborder" valign="top" width="68.42%" headers="mcps1.1.3.1.2 "><p id="p2561142910184"><a name="p2561142910184"></a><a name="p2561142910184"></a>存放blockDim(用于指定核函数将会在几个核上执行)的Device内存地址</p>
</td>
</tr>
<tr id="row1531011444185"><td class="cellrowborder" valign="top" width="31.580000000000002%" headers="mcps1.1.3.1.1 "><p id="p163116447182"><a name="p163116447182"></a><a name="p163116447182"></a>rsv</p>
</td>
<td class="cellrowborder" valign="top" width="68.42%" headers="mcps1.1.3.1.2 "><p id="p23111444161814"><a name="p23111444161814"></a><a name="p23111444161814"></a>预留参数。当前固定配置为0。</p>
</td>
</tr>
</tbody>
</table>

