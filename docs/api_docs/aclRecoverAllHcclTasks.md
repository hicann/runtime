# aclRecoverAllHcclTasks<a name="ZH-CN_TOPIC_0000002338563277"></a>

**须知：本接口为预留接口，暂不支持。**

## 功能说明<a name="section36583473819"></a>

维测场景下，本接口恢复指定Device上的所有集合通信任务。

## 函数原型<a name="section13230182415108"></a>

```
aclError aclRecoverAllHcclTasks(int32_t deviceId)
```

## 参数说明<a name="section75395119104"></a>

<a name="zh-cn_topic_0122830089_table438764393513"></a>
<table><thead align="left"><tr id="zh-cn_topic_0122830089_row53871743113510"><th class="cellrowborder" valign="top" width="14.000000000000002%" id="mcps1.1.4.1.1"><p id="zh-cn_topic_0122830089_p1438834363520"><a name="zh-cn_topic_0122830089_p1438834363520"></a><a name="zh-cn_topic_0122830089_p1438834363520"></a>参数名</p>
</th>
<th class="cellrowborder" valign="top" width="13.98%" id="mcps1.1.4.1.2"><p id="p1769255516412"><a name="p1769255516412"></a><a name="p1769255516412"></a>输入/输出</p>
</th>
<th class="cellrowborder" valign="top" width="72.02%" id="mcps1.1.4.1.3"><p id="zh-cn_topic_0122830089_p173881843143514"><a name="zh-cn_topic_0122830089_p173881843143514"></a><a name="zh-cn_topic_0122830089_p173881843143514"></a>说明</p>
</th>
</tr>
</thead>
<tbody><tr id="zh-cn_topic_0122830089_row2038874343514"><td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.1 "><p id="p11319248145911"><a name="p11319248145911"></a><a name="p11319248145911"></a>deviceId</p>
</td>
<td class="cellrowborder" valign="top" width="13.98%" headers="mcps1.1.4.1.2 "><p id="p1031974811592"><a name="p1031974811592"></a><a name="p1031974811592"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="72.02%" headers="mcps1.1.4.1.3 "><p id="zh-cn_topic_0122830089_p19388143103518"><a name="zh-cn_topic_0122830089_p19388143103518"></a><a name="zh-cn_topic_0122830089_p19388143103518"></a>Device ID。</p>
<p id="p5103103751315"><a name="p5103103751315"></a><a name="p5103103751315"></a>用户调用<a href="aclrtGetDeviceCount.md">aclrtGetDeviceCount</a>接口获取可用的Device数量后，这个Device ID的取值范围：[0, (可用的Device数量-1)]</p>
</td>
</tr>
</tbody>
</table>

## 返回值说明<a name="section25791320141317"></a>

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

