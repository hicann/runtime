# aclrtGetDevicesTopo<a name="ZH-CN_TOPIC_0000002341970325"></a>

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
<td class="cellrowborder" align="center" valign="top" width="42%" headers="mcps1.1.3.1.2 "><p id="p7948163910184"><a name="p7948163910184"></a><a name="p7948163910184"></a>√</p>
</td>
</tr>
<tr id="row173226882415"><td class="cellrowborder" valign="top" width="57.99999999999999%" headers="mcps1.1.3.1.1 "><p id="p14832120181815"><a name="p14832120181815"></a><a name="p14832120181815"></a><span id="ph1483216010188"><a name="ph1483216010188"></a><a name="ph1483216010188"></a><term id="zh-cn_topic_0000001312391781_term11962195213215"><a name="zh-cn_topic_0000001312391781_term11962195213215"></a><a name="zh-cn_topic_0000001312391781_term11962195213215"></a>Ascend 910B</term></span></p>
</td>
<td class="cellrowborder" align="center" valign="top" width="42%" headers="mcps1.1.3.1.2 "><p id="p19948143911820"><a name="p19948143911820"></a><a name="p19948143911820"></a>√</p>
</td>
</tr>
</tbody>
</table>

## 功能说明<a name="section36583473819"></a>

获取两个Device之间的网络拓扑关系。

## 函数原型<a name="section13230182415108"></a>

```
aclError aclrtGetDevicesTopo(uint32_t deviceId, uint32_t otherDeviceId, uint64_t *value)
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
<tbody><tr id="row16791142193514"><td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.1 "><p id="p19870162724018"><a name="p19870162724018"></a><a name="p19870162724018"></a>deviceId</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p12869227174011"><a name="p12869227174011"></a><a name="p12869227174011"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="72%" headers="mcps1.1.4.1.3 "><p id="p99450379174"><a name="p99450379174"></a><a name="p99450379174"></a>指定Device的ID。</p>
<p id="p5103103751315"><a name="p5103103751315"></a><a name="p5103103751315"></a>用户调用<a href="aclrtGetDeviceCount.md">aclrtGetDeviceCount</a>接口获取可用的Device数量后，这个Device ID的取值范围：[0, (可用的Device数量-1)]</p>
</td>
</tr>
<tr id="row19988133618518"><td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.1 "><p id="p188681727124010"><a name="p188681727124010"></a><a name="p188681727124010"></a>otherDeviceId</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p178671827144015"><a name="p178671827144015"></a><a name="p178671827144015"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="72%" headers="mcps1.1.4.1.3 "><p id="p31135071714"><a name="p31135071714"></a><a name="p31135071714"></a>指定Device的ID。</p>
<p id="p38531631113012"><a name="p38531631113012"></a><a name="p38531631113012"></a>用户调用<a href="aclrtGetDeviceCount.md">aclrtGetDeviceCount</a>接口获取可用的Device数量后，这个Device ID的取值范围：[0, (可用的Device数量-1)]</p>
</td>
</tr>
<tr id="zh-cn_topic_0122830089_row2038874343514"><td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.1 "><p id="p158651027114011"><a name="p158651027114011"></a><a name="p158651027114011"></a>value</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p6864182713406"><a name="p6864182713406"></a><a name="p6864182713406"></a>输出</p>
</td>
<td class="cellrowborder" valign="top" width="72%" headers="mcps1.1.4.1.3 "><p id="p2862927114017"><a name="p2862927114017"></a><a name="p2862927114017"></a>两个Device之间互联的拓扑关系。</p>
<a name="ul1940114213588"></a><a name="ul1940114213588"></a><ul id="ul1940114213588"><li>通过HCCS连接<div class="p" id="p4979165715916"><a name="p4979165715916"></a><a name="p4979165715916"></a>HCCS是Huawei Cache Coherence System（华为缓存一致性系统），用于CPU/NPU之间的高速互联。<pre class="screen" id="screen1953473919590"><a name="screen1953473919590"></a><a name="screen1953473919590"></a>#define ACL_RT_DEVS_TOPOLOGY_HCCS     0x01ULL</pre>
</div>
</li><li>通过同一个PCIe Switch连接<pre class="screen" id="screen5335129503"><a name="screen5335129503"></a><a name="screen5335129503"></a>#define ACL_RT_DEVS_TOPOLOGY_PIX      0x02ULL</pre>
</li><li>通过PCIe Host Bridge连接<pre class="screen" id="screen1191012422019"><a name="screen1191012422019"></a><a name="screen1191012422019"></a>#define ACL_RT_DEVS_TOPOLOGY_PHB      0x08ULL</pre>
</li><li>通过SMP（Symmetric Multiprocessing）连接，NUMA节点之间通过SMP互连<pre class="screen" id="screen1046319201112"><a name="screen1046319201112"></a><a name="screen1046319201112"></a>#define ACL_RT_DEVS_TOPOLOGY_SYS      0x10ULL</pre>
</li><li>片内连接方式，两个DIE之间通过该方式连接<pre class="screen" id="screen2989745817"><a name="screen2989745817"></a><a name="screen2989745817"></a>#define ACL_RT_DEVS_TOPOLOGY_SIO      0x20ULL</pre>
</li><li>通过HCCS Switch连接<pre class="screen" id="screen2921681217"><a name="screen2921681217"></a><a name="screen2921681217"></a>#define ACL_RT_DEVS_TOPOLOGY_HCCS_SW  0x40ULL</pre>
</li><li>预留值<pre class="screen" id="screen194341232013"><a name="screen194341232013"></a><a name="screen194341232013"></a>#define ACL_RT_DEVS_TOPOLOGY_PIB      0x04ULL</pre>
</li></ul>
</td>
</tr>
</tbody>
</table>

## 返回值说明<a name="section25791320141317"></a>

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

