# aclrtMemUceInfo<a name="ZH-CN_TOPIC_0000001982752597"></a>

```
#define MAX_MEM_UCE_INFO_ARRAY_SIZE 128 
#define UCE_INFO_RESERVED_SIZE 14

typedef struct aclrtMemUceInfo {
    void* addr;
    size_t len;
    size_t reserved[UCE_INFO_RESERVED_SIZE];
} aclrtMemUceInfo;
```

<a name="zh-cn_topic_0249624707_table6284194414136"></a>
<table><thead align="left"><tr id="zh-cn_topic_0249624707_row341484411134"><th class="cellrowborder" valign="top" width="20.9%" id="mcps1.1.3.1.1"><p id="zh-cn_topic_0249624707_p154141244121314"><a name="zh-cn_topic_0249624707_p154141244121314"></a><a name="zh-cn_topic_0249624707_p154141244121314"></a>成员名称</p>
</th>
<th class="cellrowborder" valign="top" width="79.10000000000001%" id="mcps1.1.3.1.2"><p id="zh-cn_topic_0249624707_p10414344151315"><a name="zh-cn_topic_0249624707_p10414344151315"></a><a name="zh-cn_topic_0249624707_p10414344151315"></a>描述</p>
</th>
</tr>
</thead>
<tbody><tr id="zh-cn_topic_0249624707_row754710296481"><td class="cellrowborder" valign="top" width="20.9%" headers="mcps1.1.3.1.1 "><p id="p106121425182514"><a name="p106121425182514"></a><a name="p106121425182514"></a>addr</p>
</td>
<td class="cellrowborder" valign="top" width="79.10000000000001%" headers="mcps1.1.3.1.2 "><p id="p2673658115316"><a name="p2673658115316"></a><a name="p2673658115316"></a>内存UCE的错误虚拟起始地址。</p>
</td>
</tr>
<tr id="zh-cn_topic_0249624707_row936773214820"><td class="cellrowborder" valign="top" width="20.9%" headers="mcps1.1.3.1.1 "><p id="p0611152513258"><a name="p0611152513258"></a><a name="p0611152513258"></a>len</p>
</td>
<td class="cellrowborder" valign="top" width="79.10000000000001%" headers="mcps1.1.3.1.2 "><p id="p4238121595420"><a name="p4238121595420"></a><a name="p4238121595420"></a>内存大小，单位Byte。</p>
<p id="p2760132685519"><a name="p2760132685519"></a><a name="p2760132685519"></a>从addr开始的len大小范围内的内存都是异常的。</p>
</td>
</tr>
<tr id="zh-cn_topic_0249624707_row194149449133"><td class="cellrowborder" valign="top" width="20.9%" headers="mcps1.1.3.1.1 "><p id="p861112515256"><a name="p861112515256"></a><a name="p861112515256"></a>reserved</p>
</td>
<td class="cellrowborder" valign="top" width="79.10000000000001%" headers="mcps1.1.3.1.2 "><p id="p18672145895315"><a name="p18672145895315"></a><a name="p18672145895315"></a>预留参数。</p>
</td>
</tr>
</tbody>
</table>

