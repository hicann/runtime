# acltdtGetBufFromChain<a name="ZH-CN_TOPIC_0000001395930205"></a>

## AI处理器支持情况<a name="section8178181118225"></a>

<a name="table38301303189"></a>
<table><thead align="left"><tr id="row20831180131817"><th class="cellrowborder" valign="top" width="57.99999999999999%" id="mcps1.1.3.1.1"><p id="p1883113061818"><a name="p1883113061818"></a><a name="p1883113061818"></a><span id="ph20833205312295"><a name="ph20833205312295"></a><a name="ph20833205312295"></a>AI处理器类型</span></p>
</th>
<th class="cellrowborder" align="center" valign="top" width="42%" id="mcps1.1.3.1.2"><p id="p783113012187"><a name="p783113012187"></a><a name="p783113012187"></a>是否支持</p>
</th>
</tr>
</thead>
<tbody><tr id="row220181016240"><td class="cellrowborder" valign="top" width="57.99999999999999%" headers="mcps1.1.3.1.1 "><p id="p48327011813"><a name="p48327011813"></a><a name="p48327011813"></a><span id="ph583230201815"><a name="ph583230201815"></a><a name="ph583230201815"></a><term id="zh-cn_topic_0000001312391781_term1253731311225"><a name="zh-cn_topic_0000001312391781_term1253731311225"></a><a name="zh-cn_topic_0000001312391781_term1253731311225"></a>Ascend 910C</term></span></p>
</td>
<td class="cellrowborder" align="center" valign="top" width="42%" headers="mcps1.1.3.1.2 "><p id="p7948163910184"><a name="p7948163910184"></a><a name="p7948163910184"></a>x</p>
</td>
</tr>
<tr id="row173226882415"><td class="cellrowborder" valign="top" width="57.99999999999999%" headers="mcps1.1.3.1.1 "><p id="p14832120181815"><a name="p14832120181815"></a><a name="p14832120181815"></a><span id="ph1483216010188"><a name="ph1483216010188"></a><a name="ph1483216010188"></a><term id="zh-cn_topic_0000001312391781_term11962195213215"><a name="zh-cn_topic_0000001312391781_term11962195213215"></a><a name="zh-cn_topic_0000001312391781_term11962195213215"></a>Ascend 910B</term></span></p>
</td>
<td class="cellrowborder" align="center" valign="top" width="42%" headers="mcps1.1.3.1.2 "><p id="p19948143911820"><a name="p19948143911820"></a><a name="p19948143911820"></a>x</p>
</td>
</tr>
</tbody>
</table>

## 功能说明<a name="section188203228229"></a>

获取Mbuf链中第index个Mbuf。

## 函数原型<a name="section14885205814615"></a>

```
aclError acltdtGetBufFromChain(acltdtBuf headBuf, uint32_t index, acltdtBuf *buf)
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
<tbody><tr id="rac0b28977c28486084cd6002e34558ca"><td class="cellrowborder" valign="top" width="18%" headers="mcps1.1.4.1.1 "><p id="p472843475119"><a name="p472843475119"></a><a name="p472843475119"></a>headBuf</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p13727193415110"><a name="p13727193415110"></a><a name="p13727193415110"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="68%" headers="mcps1.1.4.1.3 "><p id="p1172563414511"><a name="p1172563414511"></a><a name="p1172563414511"></a>共享Buffer链头部的第一个共享Buffer，须通过<a href="acltdtAllocBuf.md">acltdtAllocBuf</a>或<a href="acltdtCopyBufRef.md">acltdtCopyBufRef</a>接口申请获得。</p>
</td>
</tr>
<tr id="row133515813486"><td class="cellrowborder" valign="top" width="18%" headers="mcps1.1.4.1.1 "><p id="p123359811487"><a name="p123359811487"></a><a name="p123359811487"></a>index</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p433517864816"><a name="p433517864816"></a><a name="p433517864816"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="68%" headers="mcps1.1.4.1.3 "><p id="p153355816489"><a name="p153355816489"></a><a name="p153355816489"></a>共享Buffer链中的共享Buffer序号（从0开始计数）。</p>
</td>
</tr>
<tr id="row1534994112536"><td class="cellrowborder" valign="top" width="18%" headers="mcps1.1.4.1.1 "><p id="p1234918414533"><a name="p1234918414533"></a><a name="p1234918414533"></a>buf</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p434914412535"><a name="p434914412535"></a><a name="p434914412535"></a>输出</p>
</td>
<td class="cellrowborder" valign="top" width="68%" headers="mcps1.1.4.1.3 "><p id="p18349241125318"><a name="p18349241125318"></a><a name="p18349241125318"></a>输出第index个共享Buffer。</p>
</td>
</tr>
</tbody>
</table>

## 返回值说明<a name="section17970231879"></a>

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

