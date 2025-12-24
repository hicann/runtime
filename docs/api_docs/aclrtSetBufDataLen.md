# aclrtSetBufDataLen<a name="ZH-CN_TOPIC_0000002308011404"></a>

## 功能说明<a name="section36583473819"></a>

设置共享Buffer中有效数据的长度。

接口调用顺序：调用[aclrtAllocBuf](aclrtAllocBuf.md)或[aclrtCopyBufRef](aclrtCopyBufRef.md)接口申请到共享Buffer后，因此需由用户调用[aclrtGetBufData](aclrtGetBufData.md)接口获取共享Buffer的内存指针及长度后，再自行向内存中填充有效数据，然后再调用[aclrtSetBufDataLen](aclrtSetBufDataLen.md)接口设置共享Buffer中有效数据的长度，且长度必须小于[aclrtGetBufData](aclrtGetBufData.md)获取到的size大小。

## 函数原型<a name="section13230182415108"></a>

```
aclError aclrtSetBufDataLen(aclrtMbuf buf, size_t len)
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
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p13727193415110"><a name="p13727193415110"></a><a name="p13727193415110"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="72%" headers="mcps1.1.4.1.3 "><p id="p1172563414511"><a name="p1172563414511"></a><a name="p1172563414511"></a>共享Buffer，须通过<a href="aclrtAllocBuf.md">aclrtAllocBuf</a>或<a href="aclrtCopyBufRef.md">aclrtCopyBufRef</a>接口申请获得。</p>
</td>
</tr>
<tr id="row528114910296"><td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.1 "><p id="p13281149152918"><a name="p13281149152918"></a><a name="p13281149152918"></a>len</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p415318513"><a name="p415318513"></a><a name="p415318513"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="72%" headers="mcps1.1.4.1.3 "><p id="p715711051"><a name="p715711051"></a><a name="p715711051"></a>有效数据的长度，单位为Byte。</p>
</td>
</tr>
</tbody>
</table>

## 返回值说明<a name="section25791320141317"></a>

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

