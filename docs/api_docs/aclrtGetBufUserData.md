# aclrtGetBufUserData<a name="ZH-CN_TOPIC_0000002341970353"></a>

## 功能说明<a name="section36583473819"></a>

获取共享Buffer的私有数据区数据，偏移offset后，拷贝至用户申请的内存区域。当前默认私有数据区大小是96Byte，offset+size必须小于或等于96Byte，否则返回报错。

## 函数原型<a name="section13230182415108"></a>

```
aclError aclrtGetBufUserData(const aclrtMbuf buf, void *dataPtr, size_t size, size_t offset)
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
<td class="cellrowborder" valign="top" width="72%" headers="mcps1.1.4.1.3 "><p id="p1172563414511"><a name="p1172563414511"></a><a name="p1172563414511"></a>共享Buffer，须通过<a href="aclrtAllocBuf.md">aclrtAllocBuf</a>或<a href="aclrtCopyBufRef.md">aclrtCopyBufRef</a>接口申请获得。</p>
</td>
</tr>
<tr id="row1580883218128"><td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.1 "><p id="p17808532171213"><a name="p17808532171213"></a><a name="p17808532171213"></a>dataPtr</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p15808113271219"><a name="p15808113271219"></a><a name="p15808113271219"></a>输出</p>
</td>
<td class="cellrowborder" valign="top" width="72%" headers="mcps1.1.4.1.3 "><p id="p178488371662"><a name="p178488371662"></a><a name="p178488371662"></a>存放用户数据的内存地址指针。</p>
</td>
</tr>
<tr id="row194733411125"><td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.1 "><p id="p159478345127"><a name="p159478345127"></a><a name="p159478345127"></a>size</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p179471934121218"><a name="p179471934121218"></a><a name="p179471934121218"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="72%" headers="mcps1.1.4.1.3 "><p id="p715711051"><a name="p715711051"></a><a name="p715711051"></a>用户数据的长度，单位为Byte。</p>
<p id="p188859182094"><a name="p188859182094"></a><a name="p188859182094"></a>数据长度小于或等于96Byte。</p>
</td>
</tr>
<tr id="row5217195011127"><td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.1 "><p id="p10217550121215"><a name="p10217550121215"></a><a name="p10217550121215"></a>offset</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p1821715019127"><a name="p1821715019127"></a><a name="p1821715019127"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="72%" headers="mcps1.1.4.1.3 "><p id="p089219016812"><a name="p089219016812"></a><a name="p089219016812"></a>地址偏移，单位为Byte。</p>
<p id="p1334018487912"><a name="p1334018487912"></a><a name="p1334018487912"></a>偏移量小于或等于96Byte。</p>
</td>
</tr>
</tbody>
</table>

## 返回值说明<a name="section25791320141317"></a>

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

