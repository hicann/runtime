# aclrtAppendBufChain<a name="ZH-CN_TOPIC_0000002342050513"></a>

## 功能说明<a name="section36583473819"></a>

将共享Buffer添加到Mbuf链表中。共享Buffer链最大支持128个共享Buffer。共享Buffer可通过[aclrtAllocBuf](aclrtAllocBuf.md)或[aclrtCopyBufRef](aclrtCopyBufRef.md)接口申请获得。

## 函数原型<a name="section13230182415108"></a>

```
aclError aclrtAppendBufChain(aclrtMbuf headBuf, aclrtMbuf buf)
```

## 参数说明<a name="section75395119104"></a>

<a name="zh-cn_topic_0122830089_table438764393513"></a>
<table><thead align="left"><tr id="zh-cn_topic_0122830089_row53871743113510"><th class="cellrowborder" valign="top" width="14.000000000000002%" id="mcps1.1.4.1.1"><p id="zh-cn_topic_0122830089_p1438834363520"><a name="zh-cn_topic_0122830089_p1438834363520"></a><a name="zh-cn_topic_0122830089_p1438834363520"></a>参数名</p>
</th>
<th class="cellrowborder" valign="top" width="14.000000000000002%" id="mcps1.1.4.1.2"><p id="p1769255516412"><a name="p1769255516412"></a><a name="p1769255516412"></a>输入/输出</p>
</th>
<th class="cellrowborder" valign="top" width="72%" id="mcps1.1.4.1.3"><p id="zh-cn_topic_0122830089_p173881843143514"><a name="zh-cn_topic_0122830089_p173881843143514"></a><a name="zh-cn_topic_0122830089_p173881843143514"></a>说明</p>
</th>
</tr>
</thead>
<tbody><tr id="row16791142193514"><td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.1 "><p id="p2890092591"><a name="p2890092591"></a><a name="p2890092591"></a>headBuf</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p1889194596"><a name="p1889194596"></a><a name="p1889194596"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="72%" headers="mcps1.1.4.1.3 "><p id="p78896912594"><a name="p78896912594"></a><a name="p78896912594"></a>Mbuf链表中的第一个共享Buffer。</p>
</td>
</tr>
<tr id="row041442194912"><td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.1 "><p id="p441842104916"><a name="p441842104916"></a><a name="p441842104916"></a>buf</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p241242144911"><a name="p241242144911"></a><a name="p241242144911"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="72%" headers="mcps1.1.4.1.3 "><p id="p10410425491"><a name="p10410425491"></a><a name="p10410425491"></a>待添加的共享Buffer。</p>
</td>
</tr>
</tbody>
</table>

## 返回值说明<a name="section25791320141317"></a>

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

