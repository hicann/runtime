# aclrtPhysicalMemProp<a name="ZH-CN_TOPIC_0000001651171042"></a>

```
typedef struct aclrtPhysicalMemProp {
    aclrtMemHandleType handleType;
    aclrtMemAllocationType allocationType;
    aclrtMemAttr memAttr;
    aclrtMemLocation location;
    uint64_t reserve; 
} aclrtPhysicalMemProp;
```

<a name="zh-cn_topic_0249624707_table6284194414136"></a>
<table><thead align="left"><tr id="zh-cn_topic_0249624707_row341484411134"><th class="cellrowborder" valign="top" width="20.9%" id="mcps1.1.3.1.1"><p id="zh-cn_topic_0249624707_p154141244121314"><a name="zh-cn_topic_0249624707_p154141244121314"></a><a name="zh-cn_topic_0249624707_p154141244121314"></a>成员名称</p>
</th>
<th class="cellrowborder" valign="top" width="79.10000000000001%" id="mcps1.1.3.1.2"><p id="zh-cn_topic_0249624707_p10414344151315"><a name="zh-cn_topic_0249624707_p10414344151315"></a><a name="zh-cn_topic_0249624707_p10414344151315"></a>描述</p>
</th>
</tr>
</thead>
<tbody><tr id="zh-cn_topic_0249624707_row754710296481"><td class="cellrowborder" valign="top" width="20.9%" headers="mcps1.1.3.1.1 "><p id="zh-cn_topic_0249624707_p374123634812"><a name="zh-cn_topic_0249624707_p374123634812"></a><a name="zh-cn_topic_0249624707_p374123634812"></a>handleType</p>
</td>
<td class="cellrowborder" valign="top" width="79.10000000000001%" headers="mcps1.1.3.1.2 "><p id="p20644640161111"><a name="p20644640161111"></a><a name="p20644640161111"></a>handle类型。</p>
<p id="p171874599523"><a name="p171874599523"></a><a name="p171874599523"></a>当前仅支持ACL_MEM_HANDLE_TYPE_NONE 。</p>
</td>
</tr>
<tr id="zh-cn_topic_0249624707_row936773214820"><td class="cellrowborder" valign="top" width="20.9%" headers="mcps1.1.3.1.1 "><p id="zh-cn_topic_0249624707_p92431040174810"><a name="zh-cn_topic_0249624707_p92431040174810"></a><a name="zh-cn_topic_0249624707_p92431040174810"></a>allocationType</p>
</td>
<td class="cellrowborder" valign="top" width="79.10000000000001%" headers="mcps1.1.3.1.2 "><p id="p11243201116"><a name="p11243201116"></a><a name="p11243201116"></a>内存分配类型。</p>
<p id="p618785911521"><a name="p618785911521"></a><a name="p618785911521"></a>当前仅支持ACL_MEM_ALLOCATION_TYPE_PINNED，表示锁页内存。</p>
</td>
</tr>
<tr id="zh-cn_topic_0249624707_row194149449133"><td class="cellrowborder" valign="top" width="20.9%" headers="mcps1.1.3.1.1 "><p id="zh-cn_topic_0249624707_p16414844191314"><a name="zh-cn_topic_0249624707_p16414844191314"></a><a name="zh-cn_topic_0249624707_p16414844191314"></a>memAttr</p>
</td>
<td class="cellrowborder" valign="top" width="79.10000000000001%" headers="mcps1.1.3.1.2 "><p id="p318645910521"><a name="p318645910521"></a><a name="p318645910521"></a>内存属性。</p>
</td>
</tr>
<tr id="zh-cn_topic_0249624707_row141411445133"><td class="cellrowborder" valign="top" width="20.9%" headers="mcps1.1.3.1.1 "><p id="zh-cn_topic_0249624707_p2414144441319"><a name="zh-cn_topic_0249624707_p2414144441319"></a><a name="zh-cn_topic_0249624707_p2414144441319"></a>location</p>
</td>
<td class="cellrowborder" valign="top" width="79.10000000000001%" headers="mcps1.1.3.1.2 "><p id="p14186135913525"><a name="p14186135913525"></a><a name="p14186135913525"></a>内存所在位置。</p>
<p id="p54791842203515"><a name="p54791842203515"></a><a name="p54791842203515"></a>当type为ACL_MEM_LOCATION_TYPE_HOST 时，id无效，固定设置为0即可。</p>
</td>
</tr>
<tr id="zh-cn_topic_0249624707_row941584421312"><td class="cellrowborder" valign="top" width="20.9%" headers="mcps1.1.3.1.1 "><p id="zh-cn_topic_0249624707_p20117104595119"><a name="zh-cn_topic_0249624707_p20117104595119"></a><a name="zh-cn_topic_0249624707_p20117104595119"></a>reserve</p>
</td>
<td class="cellrowborder" valign="top" width="79.10000000000001%" headers="mcps1.1.3.1.2 "><p id="p12185115910523"><a name="p12185115910523"></a><a name="p12185115910523"></a>预留。</p>
</td>
</tr>
</tbody>
</table>

