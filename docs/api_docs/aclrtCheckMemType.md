# aclrtCheckMemType<a name="ZH-CN_TOPIC_0000002512284493"></a>

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
<td class="cellrowborder" align="center" valign="top" width="42%" headers="mcps1.1.3.1.2 "><p id="p183501357115213"><a name="p183501357115213"></a><a name="p183501357115213"></a>√</p>
</td>
</tr>
<tr id="row173226882415"><td class="cellrowborder" valign="top" width="57.99999999999999%" headers="mcps1.1.3.1.1 "><p id="p14832120181815"><a name="p14832120181815"></a><a name="p14832120181815"></a><span id="ph1483216010188"><a name="ph1483216010188"></a><a name="ph1483216010188"></a><term id="zh-cn_topic_0000001312391781_term11962195213215"><a name="zh-cn_topic_0000001312391781_term11962195213215"></a><a name="zh-cn_topic_0000001312391781_term11962195213215"></a>Ascend 910B</term></span></p>
</td>
<td class="cellrowborder" align="center" valign="top" width="42%" headers="mcps1.1.3.1.2 "><p id="p11349105713526"><a name="p11349105713526"></a><a name="p11349105713526"></a>√</p>
</td>
</tr>
</tbody>
</table>

## 功能说明<a name="section36583473819"></a>

检查Device内存类型。

## 函数原型<a name="section13230182415108"></a>

```
aclError aclrtCheckMemType(void** addrList, uint32_t size, uint32_t memType, uint32_t *checkResult, uint32_t reserve)
```

## 参数说明<a name="section75395119104"></a>

<a name="zh-cn_topic_0122830089_table438764393513"></a>
<table><thead align="left"><tr id="zh-cn_topic_0122830089_row53871743113510"><th class="cellrowborder" valign="top" width="18%" id="mcps1.1.4.1.1"><p id="zh-cn_topic_0122830089_p1438834363520"><a name="zh-cn_topic_0122830089_p1438834363520"></a><a name="zh-cn_topic_0122830089_p1438834363520"></a>参数名</p>
</th>
<th class="cellrowborder" valign="top" width="14.000000000000002%" id="mcps1.1.4.1.2"><p id="p1769255516412"><a name="p1769255516412"></a><a name="p1769255516412"></a>输入/输出</p>
</th>
<th class="cellrowborder" valign="top" width="68%" id="mcps1.1.4.1.3"><p id="zh-cn_topic_0122830089_p173881843143514"><a name="zh-cn_topic_0122830089_p173881843143514"></a><a name="zh-cn_topic_0122830089_p173881843143514"></a>说明</p>
</th>
</tr>
</thead>
<tbody><tr id="zh-cn_topic_0122830089_row2038874343514"><td class="cellrowborder" valign="top" width="18%" headers="mcps1.1.4.1.1 "><p id="p348915102537"><a name="p348915102537"></a><a name="p348915102537"></a>addrList</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p248981011532"><a name="p248981011532"></a><a name="p248981011532"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="68%" headers="mcps1.1.4.1.3 "><p id="p19488191015312"><a name="p19488191015312"></a><a name="p19488191015312"></a>Device内存地址数组。</p>
</td>
</tr>
<tr id="row198943121925"><td class="cellrowborder" valign="top" width="18%" headers="mcps1.1.4.1.1 "><p id="p4487610155311"><a name="p4487610155311"></a><a name="p4487610155311"></a>size</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p4487181014532"><a name="p4487181014532"></a><a name="p4487181014532"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="68%" headers="mcps1.1.4.1.3 "><p id="p12486610205312"><a name="p12486610205312"></a><a name="p12486610205312"></a><span>addrList数组大小。</span></p>
</td>
</tr>
<tr id="row948704010396"><td class="cellrowborder" valign="top" width="18%" headers="mcps1.1.4.1.1 "><p id="p164851010165317"><a name="p164851010165317"></a><a name="p164851010165317"></a>memType</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p648519107535"><a name="p648519107535"></a><a name="p648519107535"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="68%" headers="mcps1.1.4.1.3 "><p id="p1948451015530"><a name="p1948451015530"></a><a name="p1948451015530"></a>Device内存类型。</p>
<p id="p3890152611510"><a name="p3890152611510"></a><a name="p3890152611510"></a>当前支持设置为如下宏：</p>
<a name="ul99873501257"></a><a name="ul99873501257"></a><ul id="ul99873501257"><li>ACL_RT_MEM_TYPE_DEV<div class="p" id="p12112939618"><a name="p12112939618"></a><a name="p12112939618"></a>表示调用<a href="aclrtMalloc.md">aclrtMalloc</a>、<a href="aclrtMallocWithCfg.md">aclrtMallocWithCfg</a>等接口申请的Device内存。<pre class="screen" id="screen1255118112224"><a name="screen1255118112224"></a><a name="screen1255118112224"></a>#define ACL_RT_MEM_TYPE_DEV   (0X2U)</pre>
</div>
</li></ul>
<a name="ul720216139619"></a><a name="ul720216139619"></a><ul id="ul720216139619"><li>ACL_RT_MEM_TYPE_DVPP<p id="p1253914221634"><a name="p1253914221634"></a><a name="p1253914221634"></a>表示DVPP专用的Device内存，可调用<a href="zh-cn_topic_0000001312641577.md">acldvppMalloc</a>、<a href="zh-cn_topic_0000001312641293.md">hi_mpi_dvpp_malloc</a>等接口申请该内存。</p>
</li><li>ACL_RT_MEM_TYPE_RSVD<div class="p" id="p26272443401"><a name="p26272443401"></a><a name="p26272443401"></a>表示调用<a href="aclrtReserveMemAddress.md">aclrtReserveMemAddress</a>接口预留的虚拟内存。<pre class="screen" id="screen16757135814181"><a name="screen16757135814181"></a><a name="screen16757135814181"></a>#define ACL_RT_MEM_TYPE_RSVD  (0X10U)</pre>
</div>
</li></ul>
<p id="p11948182114206"><a name="p11948182114206"></a><a name="p11948182114206"></a>若<span>addrList</span>数组中有多种不同类型的内存地址，则memType处需配置为多种内存类型位或，例如配置为：RT_MEM_MASK_DEV_TYPE | RT_MEM_MASK_DVPP_TYPE</p>
</td>
</tr>
<tr id="row134631256182814"><td class="cellrowborder" valign="top" width="18%" headers="mcps1.1.4.1.1 "><p id="p446314561288"><a name="p446314561288"></a><a name="p446314561288"></a>checkResult</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p174639561286"><a name="p174639561286"></a><a name="p174639561286"></a>输出</p>
</td>
<td class="cellrowborder" valign="top" width="68%" headers="mcps1.1.4.1.3 "><p id="p13498142812225"><a name="p13498142812225"></a><a name="p13498142812225"></a><span>检查</span><span>addrList</span>数组中内存地址类型与memType处是否匹配。</p>
<a name="ul1653715723210"></a><a name="ul1653715723210"></a><ul id="ul1653715723210"><li>1：匹配</li><li>0：不匹配</li></ul>
</td>
</tr>
<tr id="row678395912285"><td class="cellrowborder" valign="top" width="18%" headers="mcps1.1.4.1.1 "><p id="p14783125922816"><a name="p14783125922816"></a><a name="p14783125922816"></a>reserve</p>
</td>
<td class="cellrowborder" valign="top" width="14.000000000000002%" headers="mcps1.1.4.1.2 "><p id="p178385902816"><a name="p178385902816"></a><a name="p178385902816"></a>输入</p>
</td>
<td class="cellrowborder" valign="top" width="68%" headers="mcps1.1.4.1.3 "><p id="p77831659102810"><a name="p77831659102810"></a><a name="p77831659102810"></a>预留参数，当前固定配置为0。</p>
</td>
</tr>
</tbody>
</table>

## 返回值说明<a name="section25791320141317"></a>

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

