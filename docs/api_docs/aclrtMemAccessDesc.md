# aclrtMemAccessDesc<a name="ZH-CN_TOPIC_0000002505552531"></a>

```
typedef struct {
    aclrtMemAccessFlags flags;   
    aclrtMemLocation location;   
    uint8_t rsv[12];             
} aclrtMemAccessDesc;
```

<a name="zh-cn_topic_0249624707_table6284194414136"></a>
<table><thead align="left"><tr id="zh-cn_topic_0249624707_row341484411134"><th class="cellrowborder" valign="top" width="20.9%" id="mcps1.1.3.1.1"><p id="zh-cn_topic_0249624707_p154141244121314"><a name="zh-cn_topic_0249624707_p154141244121314"></a><a name="zh-cn_topic_0249624707_p154141244121314"></a>成员名称</p>
</th>
<th class="cellrowborder" valign="top" width="79.10000000000001%" id="mcps1.1.3.1.2"><p id="zh-cn_topic_0249624707_p10414344151315"><a name="zh-cn_topic_0249624707_p10414344151315"></a><a name="zh-cn_topic_0249624707_p10414344151315"></a>描述</p>
</th>
</tr>
</thead>
<tbody><tr id="zh-cn_topic_0249624707_row754710296481"><td class="cellrowborder" valign="top" width="20.9%" headers="mcps1.1.3.1.1 "><p id="zh-cn_topic_0249624707_p374123634812"><a name="zh-cn_topic_0249624707_p374123634812"></a><a name="zh-cn_topic_0249624707_p374123634812"></a>flags</p>
</td>
<td class="cellrowborder" valign="top" width="79.10000000000001%" headers="mcps1.1.3.1.2 "><p id="p171874599523"><a name="p171874599523"></a><a name="p171874599523"></a>内存访问保护标志。</p>
<p id="p111623282141"><a name="p111623282141"></a><a name="p111623282141"></a>当前仅支持ACL_RT_MEM_ACCESS_FLAGS_READWRITE，表示地址范围可读可写。</p>
</td>
</tr>
<tr id="zh-cn_topic_0249624707_row936773214820"><td class="cellrowborder" valign="top" width="20.9%" headers="mcps1.1.3.1.1 "><p id="zh-cn_topic_0249624707_p92431040174810"><a name="zh-cn_topic_0249624707_p92431040174810"></a><a name="zh-cn_topic_0249624707_p92431040174810"></a>location</p>
</td>
<td class="cellrowborder" valign="top" width="79.10000000000001%" headers="mcps1.1.3.1.2 "><p id="p1119103211412"><a name="p1119103211412"></a><a name="p1119103211412"></a>内存所在位置。</p>
<p id="p16655834104119"><a name="p16655834104119"></a><a name="p16655834104119"></a>当前仅支持将aclrtMemLocation.type设置为ACL_MEM_LOCATION_TYPE_HOST或ACL_MEM_LOCATION_TYPE_DEVICE。当aclrtMemLocation.type为ACL_MEM_LOCATION_TYPE_HOST时，aclrtMemLocation.id无效，固定设置为0即可。</p>
</td>
</tr>
<tr id="zh-cn_topic_0249624707_row194149449133"><td class="cellrowborder" valign="top" width="20.9%" headers="mcps1.1.3.1.1 "><p id="zh-cn_topic_0249624707_p16414844191314"><a name="zh-cn_topic_0249624707_p16414844191314"></a><a name="zh-cn_topic_0249624707_p16414844191314"></a>rsv</p>
</td>
<td class="cellrowborder" valign="top" width="79.10000000000001%" headers="mcps1.1.3.1.2 "><p id="p318645910521"><a name="p318645910521"></a><a name="p318645910521"></a>预留参数，当前固定配置为0。</p>
</td>
</tr>
</tbody>
</table>

