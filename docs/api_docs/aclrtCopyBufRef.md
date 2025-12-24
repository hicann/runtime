# aclrtCopyBufRef<a name="ZH-CN_TOPIC_0000002308011396"></a>

## 功能说明<a name="section36583473819"></a>

对共享Buffer数据区的引用拷贝，创建并返回一个新的Mbuf管理结构指向相同的数据区。

## 函数原型<a name="section13230182415108"></a>

```
aclError aclrtCopyBufRef(const aclrtMbuf buf, aclrtMbuf *newBuf)
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
<tbody><tr id="row16791142193514"><td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.1 "><p id="p2890092591"><a name="p2890092591"></a><a name="p2890092591"></a>buf</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p1889194596"><a name="p1889194596"></a><a name="p1889194596"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="72%" headers="mcps1.1.4.1.3 "><p id="p78896912594"><a name="p78896912594"></a><a name="p78896912594"></a>共享Buffer。</p>
<p id="p176251215192113"><a name="p176251215192113"></a><a name="p176251215192113"></a>共享Buffer可通过<a href="aclrtAllocBuf.md">aclrtAllocBuf</a>或<a href="aclrtCopyBufRef.md">aclrtCopyBufRef</a>接口申请获得。</p>
</td>
</tr>
<tr id="row121658477229"><td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.1 "><p id="p91656470225"><a name="p91656470225"></a><a name="p91656470225"></a>newBuf</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p1516534742214"><a name="p1516534742214"></a><a name="p1516534742214"></a>输出</p>
</td>
<td class="cellrowborder" valign="top" width="72%" headers="mcps1.1.4.1.3 "><p id="p141651647182220"><a name="p141651647182220"></a><a name="p141651647182220"></a>返回一个新的共享Buffer，指向相同的数据区。</p>
</td>
</tr>
</tbody>
</table>

## 返回值说明<a name="section25791320141317"></a>

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

