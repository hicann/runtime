# aclrtMemSharedHandleType<a name="ZH-CN_TOPIC_0000002455738308"></a>

```
typedef enum aclrtMemSharedHandleType {
    ACL_MEM_SHARE_HANDLE_TYPE_DEFAULT = 0x1,  
    ACL_MEM_SHARE_HANDLE_TYPE_FABRIC = 0x2,
} aclrtMemSharedHandleType;
```

**表 1**  枚举项说明

<a name="table154428882117"></a>
<table><thead align="left"><tr id="row15442178172115"><th class="cellrowborder" valign="top" width="37.169999999999995%" id="mcps1.2.3.1.1"><p id="p10442188112114"><a name="p10442188112114"></a><a name="p10442188112114"></a>枚举项</p>
</th>
<th class="cellrowborder" valign="top" width="62.83%" id="mcps1.2.3.1.2"><p id="p84426814219"><a name="p84426814219"></a><a name="p84426814219"></a>说明</p>
</th>
</tr>
</thead>
<tbody><tr id="row134425813216"><td class="cellrowborder" valign="top" width="37.169999999999995%" headers="mcps1.2.3.1.1 "><p id="p5215143820613"><a name="p5215143820613"></a><a name="p5215143820613"></a>ACL_MEM_SHARE_HANDLE_TYPE_DEFAULT</p>
</td>
<td class="cellrowborder" valign="top" width="62.83%" headers="mcps1.2.3.1.2 "><p id="p1322014193401"><a name="p1322014193401"></a><a name="p1322014193401"></a>默认值，AI Server内跨进程共享内存。</p>
</td>
</tr>
<tr id="row444313892114"><td class="cellrowborder" valign="top" width="37.169999999999995%" headers="mcps1.2.3.1.1 "><p id="p102065381266"><a name="p102065381266"></a><a name="p102065381266"></a>ACL_MEM_SHARE_HANDLE_TYPE_FABRIC</p>
</td>
<td class="cellrowborder" valign="top" width="62.83%" headers="mcps1.2.3.1.2 "><p id="p9241747154116"><a name="p9241747154116"></a><a name="p9241747154116"></a>跨AI Server跨进程共享内存。</p>
<p id="p0916111394213"><a name="p0916111394213"></a><a name="p0916111394213"></a>仅<span id="ph8589330154012"><a name="ph8589330154012"></a><a name="ph8589330154012"></a><term id="zh-cn_topic_0000001312391781_term1253731311225"><a name="zh-cn_topic_0000001312391781_term1253731311225"></a><a name="zh-cn_topic_0000001312391781_term1253731311225"></a>Ascend 910C</term></span>支持该选项。</p>
<p id="p10454202815402"><a name="p10454202815402"></a><a name="p10454202815402"></a>其它产品型号当前不支持该选项。</p>
</td>
</tr>
</tbody>
</table>

