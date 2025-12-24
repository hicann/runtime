# aclrtSetBufUserData<a name="ZH-CN_TOPIC_0000002314770154"></a>

## 功能说明<a name="section93499471063"></a>

设置共享Buffer的私有数据区数据，从用户内存拷贝到共享Buffer的私有数据区的指定偏移位置，用于设置控制信息作为上下文传递。当前默认私有数据区大小是96Byte，offset+size必须小于或等于96Byte，否则返回报错。

## 函数原型<a name="section14885205814615"></a>

```
aclError aclrtSetBufUserData(aclrtMbuf buf, const void *dataPtr, size_t size, size_t offset)
```

## 参数说明<a name="section31916522610"></a>

<a name="t7578495d685c4a90bce9c97d867977d6"></a>
<table><thead align="left"><tr id="r2d1a1bf4a62d4919b78beceb6f54a2b5"><th class="cellrowborder" valign="top" width="18%" id="mcps1.1.4.1.1"><p id="a0ef8a1f61ce94163847db2d50aadf417"><a name="a0ef8a1f61ce94163847db2d50aadf417"></a><a name="a0ef8a1f61ce94163847db2d50aadf417"></a>参数名</p>
</th>
<th class="cellrowborder" valign="top" width="14.000000000000002%" id="mcps1.1.4.1.2"><p id="p1769255516412"><a name="p1769255516412"></a><a name="p1769255516412"></a>输入/输出</p>
</th>
<th class="cellrowborder" valign="top" width="68%" id="mcps1.1.4.1.3"><p id="aa32c26db853f48c09906042f64b95091"><a name="aa32c26db853f48c09906042f64b95091"></a><a name="aa32c26db853f48c09906042f64b95091"></a>说明</p>
</th>
</tr>
</thead>
<tbody><tr id="rac0b28977c28486084cd6002e34558ca"><td class="cellrowborder" valign="top" width="18%" headers="mcps1.1.4.1.1 "><p id="p472843475119"><a name="p472843475119"></a><a name="p472843475119"></a>buf</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p13727193415110"><a name="p13727193415110"></a><a name="p13727193415110"></a>输出</p>
</td>
<td class="cellrowborder" valign="top" width="68%" headers="mcps1.1.4.1.3 "><p id="p1172563414511"><a name="p1172563414511"></a><a name="p1172563414511"></a>共享Buffer，须通过<a href="aclrtAllocBuf.md">aclrtAllocBuf</a>或<a href="aclrtCopyBufRef.md">aclrtCopyBufRef</a>接口申请获得。</p>
</td>
</tr>
<tr id="row187161557143"><td class="cellrowborder" valign="top" width="18%" headers="mcps1.1.4.1.1 "><p id="p16716195718417"><a name="p16716195718417"></a><a name="p16716195718417"></a>dataPtr</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p207164571949"><a name="p207164571949"></a><a name="p207164571949"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="68%" headers="mcps1.1.4.1.3 "><p id="p178488371662"><a name="p178488371662"></a><a name="p178488371662"></a>存放用户数据的内存地址指针。</p>
</td>
</tr>
<tr id="row11152011056"><td class="cellrowborder" valign="top" width="18%" headers="mcps1.1.4.1.1 "><p id="p415611659"><a name="p415611659"></a><a name="p415611659"></a>size</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p415318513"><a name="p415318513"></a><a name="p415318513"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="68%" headers="mcps1.1.4.1.3 "><p id="p715711051"><a name="p715711051"></a><a name="p715711051"></a>用户数据的长度，单位为Byte。</p>
<p id="p188859182094"><a name="p188859182094"></a><a name="p188859182094"></a>数据长度小于或等于96Byte。</p>
</td>
</tr>
<tr id="row148911404819"><td class="cellrowborder" valign="top" width="18%" headers="mcps1.1.4.1.1 "><p id="p1892301884"><a name="p1892301884"></a><a name="p1892301884"></a>offset</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p1789218016819"><a name="p1789218016819"></a><a name="p1789218016819"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="68%" headers="mcps1.1.4.1.3 "><p id="p089219016812"><a name="p089219016812"></a><a name="p089219016812"></a>地址偏移，单位为Byte。</p>
<p id="p1334018487912"><a name="p1334018487912"></a><a name="p1334018487912"></a>偏移量小于或等于96Byte。</p>
</td>
</tr>
</tbody>
</table>

## 返回值说明<a name="section17970231879"></a>

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

