# aclrtRandomNumTaskInfo<a name="ZH-CN_TOPIC_0000002353368641"></a>

```
typedef struct { 
    aclDataType dataType; 
    aclrtRandomNumFuncParaInfo randomNumFuncParaInfo;
    void *randomParaAddr;  
    void *randomResultAddr; 
    void *randomCounterAddr;
    aclrtRandomParaInfo randomSeed; 
    aclrtRandomParaInfo randomNum; 
    uint8_t rsv[10]; 
} aclrtRandomNumTaskInfo;
```

<a name="table154428882117"></a>
<table><thead align="left"><tr id="row15442178172115"><th class="cellrowborder" valign="top" width="31.540000000000003%" id="mcps1.1.3.1.1"><p id="p10442188112114"><a name="p10442188112114"></a><a name="p10442188112114"></a>成员名称</p>
</th>
<th class="cellrowborder" valign="top" width="68.46%" id="mcps1.1.3.1.2"><p id="p84426814219"><a name="p84426814219"></a><a name="p84426814219"></a>说明</p>
</th>
</tr>
</thead>
<tbody><tr id="row134425813216"><td class="cellrowborder" valign="top" width="31.540000000000003%" headers="mcps1.1.3.1.1 "><p id="p94424892111"><a name="p94424892111"></a><a name="p94424892111"></a>dataType</p>
</td>
<td class="cellrowborder" valign="top" width="68.46%" headers="mcps1.1.3.1.2 "><p id="p19853125232911"><a name="p19853125232911"></a><a name="p19853125232911"></a>随机数数据类型。仅支持如下数据类型：ACL_INT32、ACL_INT64、ACL_UINT32、ACL_UINT64、ACL_BF16、ACL_FLOAT16、ACL_FLOAT。</p>
</td>
</tr>
<tr id="row4291121763611"><td class="cellrowborder" valign="top" width="31.540000000000003%" headers="mcps1.1.3.1.1 "><p id="p38466574299"><a name="p38466574299"></a><a name="p38466574299"></a>randomNumFuncParaInfo</p>
</td>
<td class="cellrowborder" valign="top" width="68.46%" headers="mcps1.1.3.1.2 "><p id="p98451757182916"><a name="p98451757182916"></a><a name="p98451757182916"></a>随机数函数信息，包括函数类别、参数信息。</p>
</td>
</tr>
<tr id="row27277271303"><td class="cellrowborder" valign="top" width="31.540000000000003%" headers="mcps1.1.3.1.1 "><p id="p1772711272301"><a name="p1772711272301"></a><a name="p1772711272301"></a>randomParaAddr</p>
</td>
<td class="cellrowborder" valign="top" width="68.46%" headers="mcps1.1.3.1.2 "><p id="p157277276303"><a name="p157277276303"></a><a name="p157277276303"></a>此处传NULL时，由接口内部自行申请Device内存，存放randomNumFuncParaInfo参数中的数据；否则，由用户申请Device内存，将内存地址作为参数传入。</p>
</td>
</tr>
<tr id="row1330511291301"><td class="cellrowborder" valign="top" width="31.540000000000003%" headers="mcps1.1.3.1.1 "><p id="p113051529183017"><a name="p113051529183017"></a><a name="p113051529183017"></a>randomResultAddr</p>
</td>
<td class="cellrowborder" valign="top" width="68.46%" headers="mcps1.1.3.1.2 "><p id="p1850484552010"><a name="p1850484552010"></a><a name="p1850484552010"></a>存放随机数结果的内存地址。</p>
<p id="p0305172912303"><a name="p0305172912303"></a><a name="p0305172912303"></a>由用户提前申请Device内存，将内存地址作为参数传入。</p>
</td>
</tr>
<tr id="row57705527362"><td class="cellrowborder" valign="top" width="31.540000000000003%" headers="mcps1.1.3.1.1 "><p id="p10844165762919"><a name="p10844165762919"></a><a name="p10844165762919"></a>randomCounterAddr</p>
</td>
<td class="cellrowborder" valign="top" width="68.46%" headers="mcps1.1.3.1.2 "><p id="p12935121810244"><a name="p12935121810244"></a><a name="p12935121810244"></a><span>生成随机数的偏移量。</span></p>
<p id="p10302182016267"><a name="p10302182016267"></a><a name="p10302182016267"></a>由用户提前申请Device内存，读入偏移量数据后，再将内存地址作为参数传入</p>
<p id="p413728192417"><a name="p413728192417"></a><a name="p413728192417"></a><a name="image1813115216269"></a><a name="image1813115216269"></a><span><img id="image1813115216269" src="figures/zh-cn_image_0000002320610726.png" width="392.01750000000004" height="58.942674000000004"></span></p>
</td>
</tr>
<tr id="row1259713467303"><td class="cellrowborder" valign="top" width="31.540000000000003%" headers="mcps1.1.3.1.1 "><p id="p15971746123017"><a name="p15971746123017"></a><a name="p15971746123017"></a>randomSeed</p>
</td>
<td class="cellrowborder" valign="top" width="68.46%" headers="mcps1.1.3.1.2 "><p id="p13597104643014"><a name="p13597104643014"></a><a name="p13597104643014"></a>随机种子。</p>
</td>
</tr>
<tr id="row1876345193014"><td class="cellrowborder" valign="top" width="31.540000000000003%" headers="mcps1.1.3.1.1 "><p id="p11763185123010"><a name="p11763185123010"></a><a name="p11763185123010"></a>randomNum</p>
</td>
<td class="cellrowborder" valign="top" width="68.46%" headers="mcps1.1.3.1.2 "><p id="p1376325115306"><a name="p1376325115306"></a><a name="p1376325115306"></a>随机数个数。</p>
</td>
</tr>
<tr id="row77592549554"><td class="cellrowborder" valign="top" width="31.540000000000003%" headers="mcps1.1.3.1.1 "><p id="p12759115415511"><a name="p12759115415511"></a><a name="p12759115415511"></a>rsv</p>
</td>
<td class="cellrowborder" valign="top" width="68.46%" headers="mcps1.1.3.1.2 "><p id="p10759125411554"><a name="p10759125411554"></a><a name="p10759125411554"></a>预留参数。当前固定配置为0。</p>
</td>
</tr>
</tbody>
</table>

